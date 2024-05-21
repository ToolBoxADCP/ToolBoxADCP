load (point(Tronc,:))
load (Ftransth)
load (MouillageAnalyse)
load (MouillageAnalyse_proj)

clear Umes Uajust Vmes Vajust
    C=[];
P0=800; %Position mouillage
LongTr=max(GPSth(Tronc).dpas); %Longueur transect
degPol=7;
nbPoint=size(P,2);

Umes=0*ones(100,nbPoint);
Uajust=0*ones(100,nbPoint);
Vmes=0*ones(100,nbPoint);
Vajust=0*ones(100,nbPoint);

for nb=2:nbPoint;
i=1:size(P_vitesse_s(nb).u,2);
%% Tout mettre sous forme vectorielle pour chaque point: 
%%[u], [heure], [distance au mouillage], [prof] 
    B.u=P_vitesse_s(nb).u(:,i);
    B.v=P_vitesse_s(nb).v(:,i);
    B.prof=26.03-P(nb).surface_s(:,i)
    
    Temps=P_temps(nb);
    t=datum_str(P_temps(nb))-T0;
    
    Point=(GPSth(Tronc).dpas(nb)*ones(size(P_vitesse_s(nb).u(:,i)))-P0)/(LongTr);

[N,M]=size(B.u);

B.u=reshape(B.u,N*M,1);
B.v=reshape(B.v,N*M,1);
B.prof=reshape(B.prof,N*M,1);
   
Y=[Temps.year]'*ones(1,M);Y=reshape(Y,N*M,1);
Mo=[Temps.month]'*ones(1,M);Mo=reshape(Mo,N*M,1);
D=[Temps.day]'*ones(1,M);D=reshape(D,N*M,1);
H=[Temps.hour]'*ones(1,M);H=reshape(H,N*M,1);
Mi=[Temps.minute]'*ones(1,M);Mi=reshape(Mi,N*M,1);
S=[Temps.seconde]'*ones(1,M);S=reshape(S,N*M,1);

Temps=[];
Temps.year=Y;
Temps.month=Mo;
Temps.day=D;
Temps.hour=H;
Temps.minute=Mi;
Temps.seconde=S;

Point=reshape(Point,N*M,1);

%Nettoyage
ii=find(isnan(B.u)==0);
  B.u=B.u(ii);
  B.v=B.v(ii);
  B.prof=B.prof(ii);
  
  Temps.year=Temps.year(ii);
  Temps.month=Temps.month(ii);
  Temps.day=Temps.day(ii);
  Temps.hour=Temps.hour(ii);
  Temps.minute=Temps.minute(ii);
  Temps.seconde=Temps.seconde(ii);
  
  Point=Point(ii);

%% Definition de la matrice A à l'aide de la vitesse au mouillage  
if(size(ii,1)~=0)
VitMouillage.u=Vit_Mouillage(Temps,B.prof,HarmoniqueU,Hcellule,5:6);
VitMouillage.v=Vit_Mouillage(Temps,B.prof,HarmoniqueV,Hcellule,5:6);

%Nettoyage - bis
  u=VitMouillage.u;v=VitMouillage.v;
  ii=find(isnan(u(:,1))==0 & isnan(u(:,2))==0 & isnan(v(:,1))==0 & isnan(v(:,2))==0);
  if (size(ii,1)~=0)
    B.u=B.u(ii);
    B.v=B.v(ii);
    B.prof=B.prof(ii);
  
    Temps.year=Temps.year(ii);
    Temps.month=Temps.month(ii);
    Temps.day=Temps.day(ii);
    Temps.hour=Temps.hour(ii);
    Temps.minute=Temps.minute(ii);
    Temps.seconde=Temps.seconde(ii);
  
    Point=Point(ii);

    VitMouillage.u=VitMouillage.u(ii,:);
    VitMouillage.v=VitMouillage.v(ii,:);
  
  
    A=[];
    A.u=[];
    A.v=[];
    vect=ones(1,size(VitMouillage.u,2));

    A.u=VitMouillage.u;
    A.v=VitMouillage.v;
    %B.u=2.*sum(A.u')'-B.u;
    %B.v=2.*sum(A.v')'-B.v;

%% Moindre carré  
    %Interpolation
    %c=pinv(A.u)*B.u,C.u(:,nb)=c;
% sur X
    %x0=[0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];
    x0=[0;0;0;0;0];
    global par
    par=[A.u B.u];
    MoindreCarre(x0);
    [X, info ] = SMarquardt('MoindreCarre',x0);c=X;C.u(:,nb)=c;   
% sur Y
    %x0=[0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];
    x0=[0;0;0;0;0];
    global par
    par=[A.v B.v];
    MoindreCarre(x0);
    [X, info ] = SMarquardt('MoindreCarre',x0);c=X;C.v(:,nb)=c;   
%c=fzero(MoindreCarre(c),c0)
%    [A.u*C.u(:,nb) B.u];sqrt(sum((A.u*C.u(:,nb)-B.u).^2))/length(B.u)
    %figure(1),clf,subplot(2,1,1),plot(A.u*C.u(:,nb),'-+b'),hold on, plot(B.u,'+r')
    %figure(1),subplot(2,1,2),plot(A.v*C.v(:,nb),'-+b'),hold on, plot(B.v,'+r')
    %figure(2),clf,plot(A.u*(C.u(:,nb).^2),'-+b'),hold on, plot(B.u,'+r')
%     figure(3),clf,plot(A.u*(2-C.u(:,nb)),'-+b'),hold on, plot((-B.u+2.*sum(A.u')'),'+r')
%    c=pinv(A.v)*B.v;C.v(:,nb)=c;

    t=(datum_str(Temps)-T0)*24*3600;
    errU(nb)=sum((B.u-A.u*C.u(:,nb)).^2);
    errV(nb)=sum((B.v-A.v*C.v(:,nb)).^2);
    NbAjustement(nb)=size(B.u,1);
    Umes(1:size(B.u,1),nb)=B.u;Uajust(1:size(B.u,1),nb)=A.u*C.u(:,nb);
    Vmes(1:size(B.u,1),nb)=B.v;Vajust(1:size(B.u,1),nb)=A.v*C.v(:,nb);
    %hold on,plot(t,A.u*C.u(:,nb),'*m')
  
end
end
end
%% Calculs d'erreurs
ErrU=sqrt(sum(errU))/sum(NbAjustement);
ErrV=sqrt(sum(errV))/sum(NbAjustement);
[ErrU ErrV]
[N,M]=size(Umes);
Umes=reshape(Umes,N*M,1);Uajust=reshape(Uajust,N*M,1);
Vmes=reshape(Vmes,N*M,1);Vajust=reshape(Vajust,N*M,1);
    
ii=find(Umes~=0);
ErrU=sqrt(mean((Umes(ii)-Uajust(ii)).^2));
ErrV=sqrt(mean((Vmes(ii)-Vajust(ii)).^2));
    
    figure(1),clf,subplot(2,1,1),plot(Umes,'*r'),hold on, plot(Uajust,'b')
    subplot(2,1,2),plot(Vmes,'*r'),hold on, plot(Vajust,'b')
    
    figure(2),clf,subplot(2,1,1),plot(Umes,Uajust,'.r')
    rU=Correlation(Umes(ii),Uajust(ii)); hold on,plot(Umes,Umes*rU,'b'),plot(Umes,Umes,'--k')
    subplot(2,1,2),plot(Vmes,Vajust,'.r')
    rV=Correlation(Vmes(ii),Vajust(ii));hold on,plot(Vmes,Vmes*rV,'b'),plot(Vmes,Vmes,'--k')

    
    disp('Erreur'),[ErrU ErrV]
    disp('Correlation'),[rU rV]


%close all
%reconstitutionB
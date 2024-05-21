
%% Idée : voir ce que représente u et v --> tres joli
%%
global par degPol ImpVit_M NbOndes
%ProfondeurMouillage=26.03
%ProfondeurMouillage=max(Hcellule)+4.6;
if isempty(degPol)
   degPol=input('degPol : ');
end
if ~exist('Tronc','var')
   Tronc=input('Tronc : ');
end
if ~exist('BolFig','var')
   BolFig=input('BolFig : ');
end
if ~exist('CalcVit','var')
   CalcVit=input('CalcVit : ');
end


CouplVitesse=1;
ImpVit_M=0;
load (MouillagePropre_proj)
ProfMax=0;

if(mean(P.depth)==100)
ProfondeurMouillage=8;
else
ProfondeurMouillage=mean(P.depth)+hadcpM;
end
%ProfMax=ProfondeurMouillage
P0=P0_tous(Tronc)
%P0=3200
load (point(Tronc,:))
load (Ftransth)
load (MouillageAnalyse)
load (MouillageAnalyse_proj)

ii=find(isnan(P_Adcp.fond_f)==0);
  C=[];
  %Position mouillage
  [Mpr(Tronc).long,Mpr(Tronc).lat]=projection_ortho...
                        (PositionMouillage.long,-PositionMouillage.lat,...
                                              p_TS(Tronc,1),p_TS(Tronc,2));
if(P0<0)
    disp('P0 indéterminée')
    P0=sqrt(((Mpr(Tronc).long-GPSth_Deb(Tronc).long)*dLong).^2 ...
                 +((Mpr(Tronc).lat-GPSth_Deb(Tronc).lat)*dLat).^2)
    %pause
end
%    %P0=2600; %MN2
%    % P0=1400; %MN1
%      P0=550; %MS

LongTr=max(GPSth(Tronc).dpas); %Longueur transect
nbPoint=size(P,2);


%% Tout mettre sous forme vectorielle : 
%%[u], [heure], [distance au mouillage], [prof] 
 
B.u=[];
B.v=[];
B.prof=[];

Temps=[];
Temps.year=[];
Temps.month=[];
Temps.day=[];
Temps.hour=[];
Temps.minute=[];
Temps.seconde=[];

Point=[];

for nb=1:nbPoint;
  if(size(P(nb).fond_s,1)~=0)
    B.u=[B.u P_vitesse_s(nb).u(:,:)];
    B.v=[B.v P_vitesse_s(nb).v(:,:)];
    B.prof=[B.prof ProfondeurMouillage-P(nb).surface_s(:,:)];
    %B.prof=[B.prof (ProfondeurMouillage-P(nb).fond_s(:,1))*ones(size(P(nb).fond_s(1,:)))+P(nb).fond_s];
    %B.prof=[B.prof (ProfondeurMouillage-P(nb).prof)+P(nb).fond_s];
    %B.prof=[B.prof 20+P(nb).fond_s];
    
    Temps.year   = [Temps.year P_temps(nb).year'*ones(1,size(P_vitesse_s(nb).u(:,:),2))];
    Temps.month  = [Temps.month P_temps(nb).month'*ones(1,size(P_vitesse_s(nb).u(:,:),2))];
    Temps.day    = [Temps.day P_temps(nb).day'*ones(1,size(P_vitesse_s(nb).u(:,:),2))];
    Temps.hour   = [Temps.hour P_temps(nb).hour'*ones(1,size(P_vitesse_s(nb).u(:,:),2))];
    Temps.minute = [Temps.minute P_temps(nb).minute'*ones(1,size(P_vitesse_s(nb).u(:,:),2))];
    Temps.seconde= [Temps.seconde P_temps(nb).seconde'*ones(1,size(P_vitesse_s(nb).u(:,:),2))];
    t=datum_str(P_temps(nb))-T0;
    %B.u=[B.u;sin(2*3.14/12*t')*ones(1,size(P_vitesse_s(nb).v(:,:),2))];
    
    Point=[Point (GPSth(Tronc).dpas(nb)*ones(size(P_vitesse_s(nb).u(:,:)))-P0)/(LongTr)];
  end
end
[N,M]=size(B.u);

B.u=reshape(B.u,N*M,1);
B.v=reshape(B.v,N*M,1);
B.prof=reshape(B.prof,N*M,1);
   
Y=[Temps.year];Y=reshape(Y,N*M,1);
Mo=[Temps.month];Mo=reshape(Mo,N*M,1);
D=[Temps.day];D=reshape(D,N*M,1);
H=[Temps.hour];H=reshape(H,N*M,1);
Mi=[Temps.minute];Mi=reshape(Mi,N*M,1);
S=[Temps.seconde];S=reshape(S,N*M,1);

Temps=[];
Temps.year=Y;
Temps.month=Mo;
Temps.day=D;
Temps.hour=H;
Temps.minute=Mi;
Temps.seconde=S;

Point=reshape(Point,N*M,1);
%Nettoyage
ii=find(isnan(B.u)==0&isnan(Temps.year)==0);
%ii=find(isnan(B.u)==0&isnan(Temps.year)==0&B.prof>ProfMax);
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
min(max(B.prof',4.6),9.6);

%% Definition de la matrice A à l'aide de la vitesse au mouillage  
VitMouillage.u=Vit_Mouillage(Temps,B.prof,HarmoniqueU,Hcellule);
VitMouillage.v=Vit_Mouillage(Temps,B.prof,HarmoniqueV,Hcellule);

%Nettoyage - bis
  u=VitMouillage.u;v=VitMouillage.v;
  ii=find(isnan(u(:,1))==0 & isnan(u(:,2))==0 & isnan(v(:,1))==0 & isnan(v(:,2))==0);
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

Mouil=CalculVitMouillage(VitMouillage);

A=CalculMatriceA(Point,VitMouillage,ImpVit_M,CouplVitesse,degPol);

B.u=B.u-ImpVit_M*Mouil.u;
B.v=B.v-ImpVit_M*Mouil.v;
%% Moindre carré  
%Interpolation
% C.u=pinv(A.u)*B.u;
% C.v=pinv(A.v)*B.v;
% sur X
    %x0=[0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];
    xxx=degPol-ImpVit_M+1;
    %x0=zeros(1,2*xxx*( NbOndes +1)+4*(xxx-1)+5);
    %x0=zeros(1,2*xxx*( NbOndes +1)+4*xxx+1;
    %x0=zeros(1,2*xxx*( NbOndes +2)+2*xxx+1;
    x0=zeros(1,xxx*2*( NbOndes +2)+xxx);
    x0(1)=0;
    x0(xxx+1: xxx+NbOndes +2)=1*ones( NbOndes +2,1);
    par=[A.u B.u];
    MoindreCarre(x0);
    [X, info ] = SMarquardt('MoindreCarre',x0);C.u=X;   
% sur Y
    x0=zeros(1,xxx*2*( NbOndes +2)+xxx);
    x0(1)=1;
    x0(xxx+NbOndes+2+1:xxx+2*(NbOndes+2))=1*ones(1,NbOndes +2);
    par=[A.v B.v];
    MoindreCarre(x0);
    [X, info ] = SMarquardt('MoindreCarre',x0);C.v=X;   


t=(datum_str(Temps)-T0)*24*3600;
u_cris=CalcVitesse(C.u,A.u,degPol,ImpVit_M,NbOndes);
hold on,plot(t,CalcVitesse(C.u,A.u,degPol,ImpVit_M,NbOndes),'*m')

%% Calcul d'erreur :
% Umes=B.u+sum(VitMouillage.u,2);Uajust=A.u*C.u+sum(VitMouillage.u,2);
% Vmes=B.v+sum(VitMouillage.v,2);Vajust=A.v*C.v+sum(VitMouillage.v,2);
Umes=B.u+ImpVit_M*Mouil.u;
Uajust=CalcVitesse(C.u,A.u,degPol,ImpVit_M,NbOndes)+ImpVit_M*Mouil.u;
Vmes=B.v+ImpVit_M*Mouil.v;
Vajust=CalcVitesse(C.v,A.v,degPol,ImpVit_M,NbOndes)+ImpVit_M*Mouil.v;
    
ii=find(Umes~=0);
ErrU=sqrt(mean((Umes(ii)-Uajust(ii)).^2));
ErrV=sqrt(mean((Vmes(ii)-Vajust(ii)).^2));
    rU=Correlation(Umes(ii),Uajust(ii));
    rV=Correlation(Vmes(ii),Vajust(ii));
    
if(BolFig~=0)
    figure(1),clf,subplot(2,1,1),plot(Umes,'*r'),hold on, plot(Uajust,'b')
    subplot(2,1,2),plot(Vmes,'*r'),hold on, plot(Vajust,'b')
    
    figure(5),clf,subplot(2,2,1),plot(Umes,Uajust,'.r')
    hold on,plot(Umes,Umes*rU,'b'),plot(Umes,Umes,'--k'),axis equal
    subplot(2,2,3),plot(Vmes,Vajust,'.r')
    hold on,plot(Vmes,Vmes*rV,'b'),plot(Vmes,Vmes,'--k'),axis equal

    
    disp('Erreur'),[ErrU ErrV]
    disp('Correlation'),[rU rV]
    figure(3),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,axis(axe),hold on
    hold on
    plot(Mpr(Tronc).long,-Mpr(Tronc).lat,'ow')
    
end

if(CalcVit==1)
   ReconstitutionVitesse
   save(VitReconst(Tronc,:),'C','Tr_reconst','tetaMoy')
end

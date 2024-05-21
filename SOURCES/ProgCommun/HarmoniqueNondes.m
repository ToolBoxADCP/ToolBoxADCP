% extraction maree
% 1 composantes S2 + M2 1nd degres polynomial function 
% 1 degree polynomial function pour la constante
% eta= a+b*temps+c*cos(M2)+d*sin(M2)
% load M10094b
% resultat=M10094b;
% Tresultat=length(resultat);resultat=resultat(1:Tresultat-1,:);
% 
% time=24*3600*resultat(:,1)+3600*resultat(:,2);%en seconde
% u=resultat(:,3);%vecteur en colonne
% %v=resultat(:,4);%vecteur en colonne
% 
% ii=find(u~=0);
% u=u(ii);time=time(ii);%v=v(ii);
% ndata=length(time); 


% 9/05/2007 Sab modification d�composition uniquement sur les ondes M2 S2
% et K1 et M22=1.13 E-5
% 10/05/07 Sab am�lioration de la m�thode de minimisation des moindres
% carr�s

% mouillage =5;

function Harm=HarmoniqueNondes(varargin);
%function [u_est, h, phi, phim]=Harmonique3ondes(depth,tinterp,time1)
% si var=h on a soit  :
            % * Harmonique3ondes('h')
            % * Harmonique3ondes('h',tmin,tmax)
            % * Harmonique3ondes('h',ti)
            % * Harmonique3ondes('h',tmin,tmax,ti)
% si var~=h (var= u ou v ou Uproj ou Vproj) on a soit  :
            % * Harmonique3ondes('u',i)
            % * Harmonique3ondes('u',i,tmin,tmax)
            % * Harmonique3ondes('u',i,ti)
            % * Harmonique3ondes('u',i,tmin,tmax,ti)

Nargin=nargin;
EntreeHarmonique

% for mouillage=1:5
time=t;%ntime=floor(size(time,1)/2);
%time=t-time(ntime);time(1)
tinterp=ti;
u=(S-nanmean(S));  
%time=time(18:end)+7.9200;
%u=u(18:end);
% lissage des courbes

ind=find(isnan(u)==0);u=u(ind);time=time(ind);S_=S(ind);

%%              ESTIMATION DES COEF A L AIDE DE TIME
%creation de la matrice A
omega(2)=2*pi/(12.42060126);      %ondeM2
omega(3)=2*pi/(12.0000);           %onde S2
omega(1)=2*pi/(23.9345-0.3039E-4);        %onde K1 
omega(4)=2*pi/(6.21030063);         %onde6H
% omega(2)=2*pi/(12.4206);      %ondeM2
% omega(3)=2*pi/(12.0000);           %onde S2
% omega(1)=2*pi/(23.9345);        %onde K1 
% omega(4)=2*pi/(6.2103);         %onde6H
omega(5)=2*pi/(145.46);       %onde 145h env.
omega(6)=2*pi/(100);          %onde 100H
omega(14)=2*pi/(278);         %onde 300H
%Analyse de la r�siduelle
omega(8)=2*pi/(11.2794);      %ondeM2
omega(9)=2*pi/(13.34);        %onde S2
omega(10)=2*pi/(14.98230);     %onde K1
omega(11)=2*pi/(17.636);      %onde K1
omega(12)=2*pi/(33.0851);     %onde6H
omega(13)=2*pi/(49.5492);     %onde 100H
omega(7)=2*pi/(68.0091);      %onde 300H

% Matrice d'interpolation
A=[ones(size(time)) time/3600]; 

%A=[A cos(time/3600*omega(1:NbOndes)) sin(time/3600*omega(1:NbOndes))];
for onde=1:NbOndes
   A=[A cos(omega(onde).*time/3600) sin(omega(onde).*time/3600)];
   m(onde)=2*onde+1;
end

% projection de u sur une somme de sinus et cosinus (inv(A)*u)
coef=A\u;

%estimation du mod�le
u_est=A*coef;res=u-u_est;
plot(time/3600/24,u,'g',time/3600/24,u_est,'b')

%%              INTERPOLATION SUR tinterp
%r�siduelle
resI=interp1(time,res,tinterp);
Harm.res=resI;
Harm.temps=tinterp;

% Matrice d'interpolation
A=[ones(size(tinterp)) tinterp/3600]; 

for onde=1:NbOndes
   A=[A cos(omega(onde).*tinterp/3600) sin(omega(onde).*tinterp/3600)];
   m(onde)=2*onde+1;
end

%estimation du mod�le
u_est=A*coef;

%figure,clf,plot(time/3600/24,u,'m',tinterp/3600/24,u_est,'b')
%plot(time/3600/24,u,'r')
%plot(time/3600/24,(u),'r',tinterp/3600/24,detrend(u_est),'k','LineWidth',2)
% save(['E:\Sab\Mayotte\Fichiers_exploitables\est' num2str(mouillage)],'u_est');

%%              IDENTIFICATION AMPL ET PHASE
Harm.lin(1)=coef(1)+nanmean(S);
Harm.lin(2)=coef(2);

for onde=1:NbOndes
   Harm.ampl(onde)=sqrt(coef(m(onde))^2+coef(m(onde)+1)^2);
   Harm.phase(onde)=atan(coef(m(onde))/coef(m(onde)+1))+(sign(coef(m(onde)+1))==-1)*pi;
   Harm.omega(onde)=omega(onde);
end


t=Harm.temps';
u=0;

for ind=1:NbOndes;
  om=Harm.omega(ind);
  u=u+Harm.ampl(ind).*sin(om*t/3600+Harm.phase(ind));
end
vit(:,1)=u;

vit(:,2)=Harm.res;

u=0;
for ind=1:2
  a=Harm.lin(ind);
  u=u+a.*((t/3600).^(ind-1));
end
vit(:,3)=u;
u=sum(vit');
%figure,clf,
hold on
u_est=A*coef;
plot(time/3600/24,(S_-nanmean(S_)),'m',tinterp/3600/24,u_est,'b')
hold on,plot(t/3600/24,Harm.res,'r')
%figure(2),clf
%u_est=A(:,3:8)*coef(3:8);
%plot(tinterp/3600/24,u_est,'b',t/3600/24,vit(:,1),'--r')
%figure(3),clf
%u_est=resI;
%plot(tinterp/3600/24,u_est,'b',t/3600/24,vit(:,2),'--r')


 %       CC=ones(3,1);
 %       u=vit*CC;


%figure,
%hold on,plot(tinterp/3600/24,u,'.r')
%pause
%% Correlation :
X=u_est+Harm.res;
Y=u_est;
% figure,plot(X,Y,'.b')
Xm=mean(X);Ym=mean(Y);
Harm.r=sum((X-Xm).*(Y-Ym))/sqrt((sum((X-Xm).^2))*(sum((Y-Ym).^2)));
    'erreur moy 1',nanmean(abs(Harm.res))

% hold on,plot(X,X*Harm.r)


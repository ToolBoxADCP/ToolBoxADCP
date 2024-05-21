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

function Harm=HarmoniqueNondes_gene(depth,tinterp,time,NbOndes)

u=detrend(depth);  

ind=find(isnan(u)==0);u=u(ind);time=time(ind);

%%              ESTIMATION DES COEF A L AIDE DE TIME
% X(4)=1;      %   M2   0.0805114    
% X(5)=2 ;     %   S2   0.0833333    
% X(9)=3 ;     %   MS4  0.1638447    
% X(3)=4 ;     %   K1   0.0417807    
% X(1)=5 ;     %   MSF  0.0028219    
% X(2)=10 ;     %   O1   0.0387307    
% X(6)=10 ;     %   M3   0.1207671    
% X(7)=10 ;     %   SK3  0.1251141    
% X(8)=10 ;     %   M4   0.1610228    
% X(10)=10 ;    %   S4   0.1666667    
% X(11)=10 ;    %   2MK5 0.2028035    
% X(12)=10  ;   %   2SK5 0.2084474    
% X(13)=10  ;   %   M6   0.2415342    
% X(14)=10  ;   %   2MS6 0.2443561    
% X(15)=10  ;   %   2SM6 0.2471781    
% X(16)=10  ;   %   3MK7 0.2833149    
% X(17)=10  ;   %   M8   0.3220456    

%creation de la matrice A
Periode(1)=12.420 ;  % onde M2
Periode(2)=12     ;  % onde S2
Periode(3)=12.658 ;  % onde N2
Periode(4)=12.192 ;  % onde L2
Periode(5)=11.967 ;  % onde K2
Periode(6)=12.016 ;  % onde T2

Periode(7)=24.833 ; % onde M1
Periode(8)=24     ;  % onde S1
Periode(9)=23.934 ; % onde K1
Periode(10)=24.065;  % onde P1
Periode(11)=25.819;  % onde O1
Periode(12)=22.306;  % onde OO1

omega=2*pi./Periode;

% omega(1)=2*pi*0.0805114;        %onde M2 
% omega(2)=2*pi*0.0833333;        %onde S2 
% omega(3)=2*pi*0.0789992;        %onde N2 
% omega(4)=2*pi*0.0417807 ;       %onde K1 
% omega(5)=2*pi*0.0387307;        %onde 01 
% omega(6)=2*pi*0.0372185;        %onde SK3 
% omega(7)=2*pi*0.0028219;        %onde MSF 
% omega(8)=2*pi*0.1251141;        %onde M4
% omega(9)=2*pi*0.1610228;        %onde S4 
% omega(3)=2*pi*0.1638447;        %onde MS4 
% 
% Matrice d'interpolation
A=[ones(size(time)) time]; 

%A=[A cos(time/3600*omega(1:NbOndes)) sin(time/3600*omega(1:NbOndes))];
for onde=1:NbOndes
   A=[A cos(omega(onde).*time) sin(omega(onde).*time)];
   m(onde)=2*onde+1;
end

% projection de u sur une somme de sinus et cosinus (inv(A)*u)
coef=A\u;

%estimation du mod�le
u_est=A*coef;res=u-u_est;
plot(time/24,u,'g',time/24,u_est,'b')

%%              INTERPOLATION SUR tinterp
%r�siduelle
resI=interp1(time,res,tinterp);
Harm.res=resI;
Harm.temps=tinterp;

% Matrice d'interpolation
A=[ones(size(tinterp)) tinterp]; 

for onde=1:NbOndes
   A=[A cos(omega(onde).*tinterp) sin(omega(onde).*tinterp)];
   m(onde)=2*onde+1;
end

%estimation du mod�le
u_est=A*coef;

%figure,clf,plot(time/3600/24,u,'m',tinterp/3600/24,u_est,'b')
%plot(time/3600/24,u,'r')
%plot(time/3600/24,(u),'r',tinterp/3600/24,detrend(u_est),'k','LineWidth',2)
% save(['E:\Sab\Mayotte\Fichiers_exploitables\est' num2str(mouillage)],'u_est');

%%              IDENTIFICATION AMPL ET PHASE
Harm.lin(1)=coef(1)+mean(depth);
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
  u=u+Harm.ampl(ind).*sin(om*t+Harm.phase(ind));
end
vit(:,1)=u;

vit(:,2)=Harm.res;

u=0;
for ind=1:2
  a=Harm.lin(ind);
  u=u+a.*((t).^(ind-1));
end
vit(:,3)=u;
u=sum(vit');
%figure,clf,
hold on
u_est=A*coef;
plot(time/24,detrend(depth),'m',tinterp/24,u_est,'b')
hold on,plot(t/24,Harm.res,'r')
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


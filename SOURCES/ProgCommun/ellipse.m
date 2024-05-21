% 12/04/2007 Sab param�tre des ellipses, recherche de la direction
% principale
% u: composante Est de la vitesse
% v: composante Nord de la vitesse 
% courbe;
function [Ellipse Pr]=ellipse(varargin); 
%1 ou 3 variables demand�es: la prof (i) et si 3 variables tmin et tmax
%r�duisant la zone d'�tude de la fonction
dir='./DessinRobert/EllipseDispersion';[a,b]=mkdir (dir);
fich1='./DessinRobert/EllipseDispersion/Ellipse_';
fich2='./DessinRobert/EllipseDispersion/EllipseProj_';
BoulFig=1;
NomMouillage=[];

GlobaleVar
if (~exist('nom','var'));nom=[];end

if (~isempty(MouillagePropre));
    load (MouillagePropre);
end
%load (MouillageAnalyse)

%% Lecture des donnees de la fonction
if (nargin==1)
    i=cell2mat(varargin(1));
    tmin=1;tmax=size(vitesse.u(:,i),1);
    uu=vitesse.u(tmin:tmax,i);
    vv=vitesse.v(tmin:tmax,i);
elseif (nargin==3)
    i=cell2mat(varargin(1));
    tmin=cell2mat(varargin(2));tmin=max(tmin,1);
    tmax=cell2mat(varargin(3));tmax=min(tmax,size(vitesse.u(:,i),1));
    uu=vitesse.u(tmin:tmax,i);
    vv=vitesse.v(tmin:tmax,i);
elseif (nargin==4)
    tmin=cell2mat(varargin(1));tmin=max(tmin,1);
    tmax=cell2mat(varargin(2));
    uu=cell2mat(varargin(3));
    vv=cell2mat(varargin(4));
    uu=uu(tmin:tmax);
    vv=vv(tmin:tmax);
    tmax=min(tmax,size(uu,1));
elseif (nargin==5)
    tmin=cell2mat(varargin(1));tmin=max(tmin,1);
    tmax=cell2mat(varargin(2));
    uu=cell2mat(varargin(3));
    vv=cell2mat(varargin(4));
    uu=uu(tmin:tmax);
    vv=vv(tmin:tmax);
    tmax=min(tmax,size(uu,1));
    BoulFig=cell2mat(varargin(5));
elseif (nargin==6)
    tmin=cell2mat(varargin(1));tmin=max(tmin,1);
    tmax=cell2mat(varargin(2));
    uu=cell2mat(varargin(3));
    vv=cell2mat(varargin(4));
    uu=uu(tmin:tmax);
    vv=vv(tmin:tmax);
    tmax=min(tmax,size(uu,1));
    BoulFig=cell2mat(varargin(5));
    NomMouillage=cell2mat(varargin(6));
end

%% Initialisation de fonction et graphe des vitesses
%u=Projection.u(tmin:tmax,i);
%v=Projection.v(tmin:tmax,i);

ind=find(isnan(uu)==0); u=uu(ind);v=vv(ind);
umoy=mean(u);vmoy=mean(v);
N=length(u);
if(BoulFig==1)
    figure(1),clf
    subplot(2,1,1),plot((u-umoy))
    subplot(2,1,2),plot((v-vmoy))
    figure(2),clf
    subplot(2,1,1),plot((u-umoy).^2)
    subplot(2,1,2),plot((v-vmoy).^2)
end

%% D�termination des param�tres de l'ellipse
Du=sum((u-umoy).^2)/(N-1);
Dv=sum((v-vmoy).^2)/(N-1);
Kuv=sum((u-umoy).*(v-vmoy))/(N-1);
if(BoulFig==1)
    figure(1),
    subplot(2,1,1),hold on, plot(umoy*ones(size(u)),'r')
    subplot(2,1,2),hold on, plot(vmoy*ones(size(v)),'r')
    figure(2),
    subplot(2,1,1),hold on, plot(Du*ones(size(u)),'r')
    subplot(2,1,2),hold on, plot(Dv*ones(size(v)),'r')
end

var=atan(2*Kuv/(Du-Dv));% angle en radian

teta=var/2; 

if (sin(var)<=0)& (2*Kuv/(Du-Dv)>=0)
    teta=teta+pi;
end
if (sin(var)>=0)& (2*Kuv/(Du-Dv)<=0)
    teta=teta+pi;    
end


std_eta=sqrt(Du*cos(teta)^2+Kuv*sin(2*teta)+Dv*sin(teta)^2);
std_nu=sqrt(Du*sin(teta)^2-Kuv*sin(2*teta)+Dv*cos(teta)^2);

if (std_eta<std_nu)
    s=std_eta;
    std_eta=std_nu;
    std_nu=s;
    teta=teta+pi/2;
end;
% if(teta<0),teta=teta+pi;end
T=teta*180/pi; %teta en degr�s

%% Projection :
% expression de l'ellipse dans le rep�re de sa direction principale
alpha=[0:pi/20:2*pi];
x= 2*std_eta*cos(alpha);
y= 2*std_nu*sin(alpha);

[cap,module]=uv2dirspeed(uu,vv);
    Pr.u=module.*sin(cap*2*pi/360+teta); 
    Pr.v=module.*cos(cap*2*pi/360+teta);
[cap,module]=uv2dirspeed(umoy,vmoy);
    Pr_umoy=module.*sin(cap*2*pi/360+teta); 
    Pr_vmoy=module.*cos(cap*2*pi/360+teta);
if (~exist('i','var'));i=1;end
if(BoulFig==1)
   figure(8),clf,
     plot(Pr.u-Pr_umoy,Pr.v-Pr_vmoy,'+r'), 
     hold on, plot(x,y,'k'), 
     grid on, axis('equal')
     title(['Ellipse de dispersion Projetee au niveau ',num2str(i)])
     %axis([-500 500 -300 500])
     %,plot(u(der),v(der),'or');plot(u(1),v(1),'og');
     Fichier=[fich2 nom '_Niv_',num2str(i)];
      saveas(gcf,Fichier,'fig')
      saveas(gcf,Fichier,'png')
end
%expression de l'ellipse dans le rep�re Nord-Est
X= umoy+ x * cos(teta) - y * sin(teta);
Y= vmoy+ x* sin(teta) + y * cos(teta);

der=length(u);

if(BoulFig==1)
    figure(9),clf,plot(u,v,'+r'), hold on, plot(X,Y,'k'), grid on, axis('equal')%,plot(u(der),v(der),'or');plot(u(1),v(1),'og');
     title(['Ellipse de dispersion au niveau ',num2str(i)])
     %axis([-500 500 -300 500])
     Fichier=[fich1 nom '_Niv_',num2str(i)];
      saveas(gcf,Fichier,'fig')
      saveas(gcf,Fichier,'png')
    figure(10)
      subplot(2,1,1),plot(u)
      subplot(2,1,2),plot(v)
    figure(12)
      [uu,vv]=ProjectionVitesse_surEllipse(u,v,teta);
      subplot(2,1,1),plot(uu)
      subplot(2,1,2),plot(vv)
end
% axis('equal')
% hold off

%% Sauvegarde des param�tres de l'ellipse
Ellipse.umoy=umoy;
Ellipse.vmoy=vmoy;
Ellipse.eta=std_eta;    % 1/2 petit axe
Ellipse.nu=std_nu;      % 1/2 grand axe
Ellipse.teta=teta;       % angle entre le grand axe et l'E


addpath ..\..\Mayotte\ProgrammesTraitementGlobal_sept09\ProgCommun\DessinRobert
fich='./DessinRobert/VitesseSurCarte/';
T_deb=6.25;T_fin=8;    %jours
T_deb=6;T_fin=40;    %jours
DT=1;        %heure
DT=.5*24;        %heure
ech=10000;
ech=1000;

section=[500*5;10*2500;1300*10;18300*2]/10000;

close all,
%% Recherche des jours de chaque prélèvement pour le mois étudié
VitesseMoy=[];
for i = 1:size(Nom,1);
  Nom(i,:);DonneesCampagne(Nom(i,:))
  load(MouillagePropre)
  
  
  time1=(datum_str(Temps)-T0)*24;
  time=time1(1:end-1);timep=time1(2:end);
  i_deb=find(time<T_deb*24&timep>T_deb*24);
        if(isempty(i_deb)==1);i_deb=1;end
  i_fin=find(time<T_fin*24&timep>T_fin*24);
        if(isempty(i_fin)==1);i_fin=size(time,1);end
  dt=min(diff(time));
  
  %N_t(i)=MaxProf(vitesse);
  u=nanmean(vitesse.u(i_deb:i_fin,:),2);
  v=nanmean(vitesse.v(i_deb:i_fin,:),2);
  tim=time1(i_deb:i_fin);
  
  nb_i=floor(DT/dt);
  Nx=floor(size(u,1)/nb_i);
  T=NaN*zeros(Nx,nb_i);V=NaN*zeros(Nx,nb_i);U=NaN*zeros(Nx,nb_i);
  for ind=1:nb_i;
    U(:,ind)=u(ind:nb_i:end-nb_i+ind);
    V(:,ind)=v(ind:nb_i:end-nb_i+ind);
    T(:,ind)=tim(ind:nb_i:end-nb_i+ind);
  end
  VitesseMoy(i).u=mean(U,2);
  VitesseMoy(i).v=mean(V,2);
  VitesseMoy(i).t=mean(T,2);
end

%% Tracer DT par DT
for t = T_deb*24:DT:T_fin*24;
  figure(1),clf,axis('equal'),axis xy,hold on
  figure(2),clf,axis('equal'),axis xy,hold on
  if(~isempty(Photo))
      figure(1),image(Ylong,Xlat,Photo)
      figure(2),image(Ylong,Xlat,Photo)
  end
  for i = 1:size(Nom,1);
      Nom(i,:);DonneesCampagne(Nom(i,:))
      index=find(VitesseMoy(i).t>=t&VitesseMoy(i).t<t+DT);
      if (isempty(index)==0)
          % Vitesse Moyenne durant DT
         plot(PositionMouillage.long,PositionMouillage.lat,'*r')
         vectX=[PositionMouillage.long ...
             PositionMouillage.long+VitesseMoy(i).u(index)/ech];
         vectY=[PositionMouillage.lat ...
             PositionMouillage.lat+VitesseMoy(i).v(index)/ech];
         figure(1),plot(vectX,vectY)
         
          % Flux Moyen durant DT
         plot(PositionMouillage.long,PositionMouillage.lat,'*r')
         vectX=[PositionMouillage.long ...
               PositionMouillage.long+u(i)*section(i)/ech];
         vectY=[PositionMouillage.lat ...
               PositionMouillage.lat+v(i)*section(i)/ech];
         figure(2),plot(vectX,vectY)
         
      end
  end
  t/24
%Sauvegarde
%   Limites=axis;axis([Limites(1) Limites(2) Limites(3) Limites(4)+0.05])
%   xlabel('Longitude')
%   ylabel('Latitude')
%   Titre=[cellstr(['Prélèvement ',num2str(i_indice(ind))])...
%       cellstr(['echelle : 1/' num2str(ech)])];
%   title(Titre)
%   
%       Fichier=[fich 'Prél_',num2str(i_indice(ind))];
%       saveas(gcf,Fichier,'fig')
%       saveas(gcf,Fichier,'png')

end

%% Moyenne entre T_deb et T_fin

v=zeros(4,1);u=zeros(4,1); %Une valeur pour chaque mouillage
figure(3),axis('equal'),axis xy,hold on
if(~isempty(Photo))
    image(Ylong,Xlat,Photo)
end

for i = 1:size(Nom,1);
      Nom(i,:);DonneesCampagne(Nom(i,:))
   u(i)=nanmean(VitesseMoy(i).u);
   v(i)=nanmean(VitesseMoy(i).v);
   plot(PositionMouillage.long,PositionMouillage.lat,'*r')
   vectX=[PositionMouillage.long ...
       PositionMouillage.long+u(i)*section(i)/ech];
   vectY=[PositionMouillage.lat ...
       PositionMouillage.lat+v(i)*section(i)/ech];
   plot(vectX,vectY)
end

 % pause
% 
% EllipseCarte
%   xlabel('Longitude')
%   ylabel('Latitude')
%   Titre=[cellstr('Ellipse durant toute la campagne'),...
%       cellstr(['echelle : 1/' num2str(ech)])];
%   title(Titre)
%   Fichier=[fich 'Ellipse'];
%       saveas(gcf,Fichier,'fig')
%       saveas(gcf,Fichier,'png')
% 

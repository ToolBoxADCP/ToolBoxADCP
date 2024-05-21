addpath ../../Mayotte/ProgrammesTraitementGlobal_sept09/ProgCommun/DessinRobert
fich='./DessinRobert/VitesseGlobaleCampagne/VitessesNonIntegrees/';
dir='./DessinRobert/VitesseGlobaleCampagne/VitessesNonIntegrees';[a,b]=mkdir (dir);

if(strcmp(Campagne,'Tulear1') || strcmp(Campagne,'Tulear2'))
  load DatePrelev.txt;
  decalTemps=[3;3;0;1.5]/24;
  t_Prelev=datum(DatePrelev(:,3),DatePrelev(:,1),DatePrelev(:,2),...
    DatePrelev(:,4),DatePrelev(:,5),0*DatePrelev(:,1));
end
DT=1; %jours
%DT=0.5/24; %jours
ech=5000;

%close all,
%% Recherche des jours de chaque pr�l�vement pour le mois �tudi�
if(~(strcmp(Campagne,'Tulear1') || strcmp(Campagne,'Tulear2')))
tmin=10000000;
tmax=-10000000;
  for i = 1:size(Nom,1);
    Nom(i,:);DonneesCampagne(Nom(i,:))
    load(MouillagePropre)
    time1=datum_str(Temps);
    tmin=min(min(time1),tmin);
    tmax=max(max(time1),tmax);
    tmin=Tmin;tmax=Tmax;
  end
  nPrelev=floor((tmax-tmin)/DT);
  t_Prelev=(tmax-nPrelev*DT:DT:tmax)';
  ind_min=1;
  ind_max=size(t_Prelev,2); 
  decalTemps=[0;0;0;0];
end
       

indice=zeros(size(Nom,1),size(t_Prelev,1));
for i = 1:size(Nom,1);
  Nom(i,:);DonneesCampagne(Nom(i,:))
  load(MouillagePropre)
  N_t(i)=MaxProf(Nom(i,:));
  time1=datum_str(Temps);
  
     VitMoyenne(i).u=zeros(size(t_Prelev,1),size(vitesse.u,2));
     VitMoyenne(i).v=zeros(size(t_Prelev,1),size(vitesse.v,2));
  %Recherche des vitesses moyenne pour tous les pr�l�vements
  for ind=1:size(t_Prelev,1) 
    plot(t_Prelev,t_Prelev,'*r')
    ii=find(time1<=t_Prelev(ind) & time1>t_Prelev(ind)-DT);
    if(isempty(ii)==0 & ii(end)<=size(time1,1))
     plot(time1(ii),time1(ii),'.c')   
     VitMoyenne(i).u(ind,:)=nanmean(vitesse.u(ii,:),1);
     VitMoyenne(i).v(ind,:)=nanmean(vitesse.v(ii,:),1);
     indice(i,ind)=1;
    end
  end
  %pause
end

i_indice=find(sum(indice~=0));
for i = 1:size(Nom,1);
     VitesseMoyenne(i).u=VitMoyenne(i).u(i_indice,:);
     VitesseMoyenne(i).v=VitMoyenne(i).v(i_indice,:);
end

for ind=1:size(i_indice,2)
   t_Prelev(ind)-T0

%% Figure (1)
  figure(1),
  clf,axis('equal'),axis xy,hold on,
  if(~isempty(Photo))
    image(Ylong,Xlat,Photo)
  end

  for i = 1:size(Nom,1);
    DonneesCampagne(Nom(i,:))
    plot(PositionMouillage.long,PositionMouillage.lat,'.r')
    N=N_t(i);
    dn=floor(max((N-1)/2,1));
    quiver(PositionMouillage.long,PositionMouillage.lat,...
        VitesseMoyenne(i).u(ind,1)/ech,VitesseMoyenne(i).v(ind,1)/ech,0,'w','LineWidth',2)
    quiver(PositionMouillage.long,PositionMouillage.lat,...
        VitesseMoyenne(i).u(ind,1+dn)/ech,VitesseMoyenne(i).v(ind,1+dn)/ech,0,'c','LineWidth',2)
    quiver(PositionMouillage.long,PositionMouillage.lat,...
        VitesseMoyenne(i).u(ind,N)/ech,VitesseMoyenne(i).v(ind,N)/ech,0,'m','LineWidth',2)
  end
  Limites=axis;axis([Limites(1) Limites(2) Limites(3) Limites(4)+0.05])
  axis([axe_glob]),axis equal
  xlabel('Longitude')
  ylabel('Latitude')
  if(strcmp(Campagne,'Tulear1')||strcmp(Campagne,'Tulear2'))
    Titre=[cellstr(['Pr�l�vement ',num2str(ind)])...
        cellstr(['echelle : 1/' num2str(ech)])];
  else
      if (DT>=1)
        Titre=[cellstr([datestr(t_Prelev(ind))])...
               cellstr([' - Moyenne sur ' num2str(DT) ...
               ' jours avant - echelle: 1/' num2str(ech)])];
      else 
        Titre=[cellstr([datestr(t_Prelev(ind))])...
               cellstr([' - Moyennee sur ' num2str(DT*24) ...
               ' heures avant - echelle : 1/' num2str(ech)])]; 
      end 
  end
  title(Titre)
  
      Fichier=[fich 'Prel_',num2str(i_indice(ind)),'_Vitesse'];
      saveas(gcf,Fichier,'fig')
      saveas(gcf,Fichier,'png')

%%Figure(3)
  figure(3)

  clf,hold on,
  hh=detrend(P.depth);
  plot(time1 - T0,hh,'b') % Niveau du dernier mouillage, soit le mouillage Nord
  ii=find(time1<t_Prelev(ind) & time1>t_Prelev(ind)-DT);
  if(isempty(ii)==0 & ii(end)<=size(time1,1))
    plot(time1(ii)-T0,hh(ii),'r')
  end
 axis([tmin-T0-2*DT tmax-T0+2*DT -1 1]) 
 Titre=[cellstr(['Prelevement du :' datestr(t_Prelev(ind))])]; 
 title(Titre)
 Fichier=[fich 'Prel_',num2str(ind),'_Niveau'];
 saveas(gcf,Fichier,'fig')
 saveas(gcf,Fichier,'png')

 figure(1)
 %pause
end

EllipseCarte
  xlabel('Longitude')
  ylabel('Latitude')
  Titre=[cellstr('Ellipse durant toute la campagne'),...
      cellstr(['echelle : 1/' num2str(ech)])];
  title(Titre)
  Fichier=[fich 'Ellipse'];
      saveas(gcf,Fichier,'fig')
      saveas(gcf,Fichier,'png')


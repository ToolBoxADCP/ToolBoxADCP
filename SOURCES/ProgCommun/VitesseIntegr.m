%addpath ../../Mayotte/ProgrammesTraitementGlobal_sept09/ProgCommun/DessinRobert
fich='./DessinRobert/VitesseGlobaleCampagne/VitessesNonIntegrees/';
dir='./DessinRobert/VitesseGlobaleCampagne//VitessesNonIntegrees';[a,b]=mkdir (dir);
dir='./DessinRobert/VitesseGlobaleCampagne/VitessesNonIntegrees/Vitesse';
        [a,b]=mkdir (dir);
 dir='./DessinRobert/VitesseGlobaleCampagne/VitessesNonIntegrees/VitesseTidale';
        [a,b]=mkdir (dir);
 dir='./DessinRobert/VitesseGlobaleCampagne/VitessesNonIntegrees/Niveau';
        [a,b]=mkdir (dir);
 dir='./DessinRobert/VitesseGlobaleCampagne/VitessesNonIntegrees/Profil';
        [a,b]=mkdir (dir);

nb_ligne=3;
c1=['y';'c';'m'];

if(strcmp(Campagne,'Tulear1')||strcmp(Campagne,'Tulear2'))
  load DatePrelev.txt;
  decalTemps=[3;3;0;1.5]/24;
  t_Prelev=datum(DatePrelev(:,3),DatePrelev(:,1),DatePrelev(:,2),...
    DatePrelev(:,4),DatePrelev(:,5),0*DatePrelev(:,1));
end
%DT=0.5/24; %jours
DT=1; %jours
%DT=1/24; %jours
ech=2500;

%close all,
%% Recherche des jours de chaque pr�l�vement pour le mois �tudi�
if(~strcmp(Campagne,'Tulear1'|~strcmp(Campagne,'Tulear2')))
tmin=10000000;
tmax=-10000000;
  for i = 1:size(Nom,1);
    Nom(i,:);DonneesCampagne(Nom(i,:))
    load(MouillagePropre)
    time1=datum_str(Temps);
    tmin=min(min(time1),tmin);
    tmax=max(max(time1),tmax);
  end
% tmin=datenum(11,7,15);
% tmax=tmin+4;
  nPrelev=floor((tmax-tmin)/DT);
  t_Prelev=tmax-nPrelev*DT:DT:tmax;
  ind_min=1;
  ind_max=size(t_Prelev,2); 
  decalTemps=[0;0;0;0];
end
       
t_Prelev=t_Prelev';
indice=zeros(size(Nom,1),size(t_Prelev,1));
for i = 1:size(Nom,1);
  Nom(i,:);DonneesCampagne(Nom(i,:))
  N_t(i)=MaxProf(Nom(i,:));hh=floor(linspace(1,N_t(i),nb_ligne));

  load(MouillagePropre_proj)
  Vitesse_proj=vitesse;
  load(MouillagePropre)
  time1=datum_str(Temps);
  load(MouillageAnalyse)

  
  for h_index=1:nb_ligne;
      Vit(i,h_index).u=zeros(size(t_Prelev,1),1);
      Vit(i,h_index).v=zeros(size(t_Prelev,1),1);
      Vit(i,h_index).u_=zeros(size(t_Prelev,1),1);
      Vit(i,h_index).v_=zeros(size(t_Prelev,1),1);
  end
  
  clear u_ v_
  for h_index=1:nb_ligne;
     h=hh(h_index);
     u_(:,h_index)=VitesseCalculeeAvecHarmonique(NbOndes,HarmoniqueU(h),...
        (datum_str(Temps)-T0)*24,T0);
     v_(:,h_index)=VitesseCalculeeAvecHarmonique(NbOndes,HarmoniqueV(h),...
        (datum_str(Temps)-T0)*24,T0);
     %Recherche des vitesses moyenne pour tous les prelevements
     for ind=1:size(t_Prelev,1) 
        %clf,plot(time1,time1,'.'),hold on,plot(t_Prelev,t_Prelev,'*r')
        ii=find(time1<=t_Prelev(ind) & time1>t_Prelev(ind)-DT);
        if(isempty(ii)==0 & ii(end)<=size(time1,1))
          %plot(time1(ii),time1(ii),'.c')   
          Vit(i,h_index).u(ind)=nanmean(vitesse.u(ii,h));
          Vit(i,h_index).v(ind)=nanmean(vitesse.v(ii,h));
          Vit(i,h_index).u_(ind)=nanmean(u_(ii,h_index));
          Vit(i,h_index).v_(ind)=nanmean(v_(ii,h_index));
          indice(i,ind)=1;
        end
     end
  end
  
  Vit_proj(i).u=zeros(size(t_Prelev,1),size(Vitesse_proj.u(1,:),2));
  Vit_proj(i).v=zeros(size(t_Prelev,1),size(Vitesse_proj.u(1,:),2));
  for ind=1:size(t_Prelev,1) 
     %clf,plot(time1,time1,'.'),hold on,plot(t_Prelev,t_Prelev,'*r')
     ii=find(time1<=t_Prelev(ind) & time1>t_Prelev(ind)-DT);
     if(isempty(ii)==0 & ii(end)<=size(time1,1))
        Vit_proj(i).u(ind,:)=nanmean(Vitesse_proj.u(ii,:));
        Vit_proj(i).v(ind,:)=nanmean(Vitesse_proj.v(ii,:));
     end
  end
end

% for i = 1:size(Nom,1); 
%      Nom(i,:);DonneesCampagne(Nom(i,:)) 
%      load(MouillagePropre)
%      Mouillage(i).long=PositionMouillage.long;
%      Mouillage(i).lat=PositionMouillage.lat;
%      T=t_Prelev;
%      Mouillage(i).depth=P.depth;
%      
%      load(MouillageMoy)
%      HarmU(i)=HarmoniqueMoyU;
%      HarmV(i)=HarmoniqueMoyV;
%      
% end

%% Dessins

for ind=1:size(t_Prelev,1)
    
  figure(1)
  clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on
  
  figure(2)
  clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on
  
  for i = 1:size(Nom,1);
    DonneesCampagne(Nom(i,:))
    for h_index=1:nb_ligne;
       figure(1)
       quiver(PositionMouillage.long,PositionMouillage.lat,...
            Vit(i,h_index).u(ind)/ech,Vit(i,h_index).v(ind)/ech,0,c1(h_index,:),'LineWidth',2)
       plot(PositionMouillage.long,PositionMouillage.lat,'.w')
       
       figure(2)
       DonneesCampagne(Nom(i,:))
       quiver(PositionMouillage.long,PositionMouillage.lat,...
            Vit(i,h_index).u_(ind)/ech,Vit(i,h_index).v_(ind)/ech,0,c1(h_index,:),'LineWidth',2)
       plot(PositionMouillage.long,PositionMouillage.lat,'.w')
    end
    
    figure(4),clf
    subplot(1,2,1), 
      %plot(Vit_proj(i).u(ind,:)',1:size(Vit_proj(i).u(ind,:),2),'r')
      plot(Vit_proj(i).u(ind,:)',P_Adcp.fond_f(ind(1),:),'r')
      axis([-250 800 0 7])
      grid
    subplot(1,2,2), 
      %plot(Vit_proj(i).v(ind,:)',1:size(Vit_proj(i).u(ind,:),2),'r')
      plot(Vit_proj(i).v(ind,:)',P_Adcp.fond_f(ind(1),:),'r')
      axis([-250 800 0 7])
      grid
    %pause
  end

  %% Mise en forme et sauvegarde des images
  figure(1)
  Limites=axis;axis([Limites(1) Limites(2) Limites(3) Limites(4)+0.05])
  xlabel('Longitude')
  ylabel('Latitude')
  if(strcmp(Campagne,'Tulear1')||strcmp(Campagne,'Tulear2'))
      Titre=[cellstr(['Vitesse Brute'])...
          cellstr(['Pr�l�vement ' num2str(ind) 'echelle : 1/' num2str(ech)])];
    else
      if (DT>=1)
          Titre=[cellstr([' Vitesse Brute - Moyennee sur ' num2str(DT)])...
                 cellstr([datestr(t_Prelev(ind))  ...
                 ' jours avant - echelle: 1/' num2str(ech)])];
        else 
          Titre=[cellstr([ ' Vitesse Brute - Moyennee sur ' num2str(DT*24) ])...
                 cellstr([datestr(t_Prelev(ind)) ' heures avant - echelle : 1/' num2str(ech)])]; 
      end 
  end
  title(Titre)
  Fichier=[fich 'Vitesse/' 'Prel_',num2str(ind),'_Vitesse'];
  saveas(gcf,Fichier,'fig')
  saveas(gcf,Fichier,'png')

  figure(2)
  Limites=axis;axis([Limites(1) Limites(2) Limites(3) Limites(4)+0.05])
  xlabel('Longitude')
  ylabel('Latitude')
  if(strcmp(Campagne,'Tulear1')||strcmp(Campagne,'Tulear2'))
      Titre=[cellstr([' Vitesse Tidale Moyennee '])...
          cellstr(['Pr�l�vement ' num2str(ind) ' - echelle : 1/' num2str(ech)])];
   else
        if (DT>=1)
          Titre=[cellstr([' Vitesse Tidale Moyenne sur ' num2str(DT)])...
                 cellstr([ datestr(t_Prelev(ind)) ' - echelle: 1/' num2str(ech)])];
        else 
          Titre=[cellstr([' Vitesse Tidale Moyennee sur ' num2str(DT*24) ' heures'])...
                 cellstr([datestr(t_Prelev(ind)) ' - echelle : 1/' num2str(ech)])]; 
        end 
  end
  title(Titre)
  Fichier=[ fich 'VitesseTidale/' 'Prel_',num2str(ind),'_TidaleVitesse'];
  saveas(gcf,Fichier,'fig')
  saveas(gcf,Fichier,'png')
 
 
  %% Niveau de la Surface libre
  figure(3)
  % Validation -inutile en regle generale -
  %  h=quiver(t_Prelev(ind)-T0,0,VitMoyenne(i).u(ind)/50,VitMoyenne(i).v(ind)/50,0,'r')
  %  axis('equal')
  %  axis([0 32 -7.5 7.5])
  clf,hold on,
  hh=detrend(P.depth);
  plot(time1 - T0,hh,'b') % Niveau du dernier mouillage, soit le mouillage Nord
  ii=find(time1<t_Prelev(ind) & time1>t_Prelev(ind)-DT);
  if(isempty(ii)==0 & ii(end)<=size(time1,1))
    plot(time1(ii)-T0,hh(ii),'r')
  end
  if(DT<1)
     axis([tmin-T0-2*DT tmax-T0+2*DT -1 1]) 
  else
     axis([tmin-T0 tmax-T0 -1 1]) 
  end
 Titre=[cellstr(['Prelevement du :' datestr(t_Prelev(ind))])];
 title(Titre)
 
 Fichier=[fich 'Niveau/' 'Prel_',num2str(ind),'_Niveau'];
 saveas(gcf,Fichier,'fig')
 saveas(gcf,Fichier,'png')
  
 figure(4)
 subplot(1,2,1)
  xlabel('vitesse long')
  ylabel('cellule')
  if(strcmp(Campagne,'Tulear1')||strcmp(Campagne,'Tulear2'))
      Titre=[cellstr(['Vitesse : Pr�l�vement ' num2str(ind)])];
    else
      if (DT>=1)
          Titre=[cellstr([' Profil Vitesse - Moyennee sur ' ...
                          num2str(DT) ' jours avant le '])]
        else 
          Titre=[cellstr([ ' Profil Vitesse - Moyennee sur ' ...
                  num2str(DT*24) ' heures avant le ' ])]; 
      end 
  end
  title(Titre)
 subplot(1,2,2)
  xlabel('vitesse ortho')
  ylabel('cellule')
  if(strcmp(Campagne,'Tulear1')||strcmp(Campagne,'Tulear2'))
      Titre=[cellstr(['echelle : 1/' num2str(ech)])];
    else
      if (DT>=1)
          Titre=[ cellstr([datestr(t_Prelev(ind))])];
        else 
          Titre=[cellstr([datestr(t_Prelev(ind))])]; 
      end 
  end
  title(Titre)
  Fichier=[fich 'Profil/' 'Prel_',num2str(ind),'_Profil'];
  saveas(gcf,Fichier,'fig')
  saveas(gcf,Fichier,'png')

 
 figure(1)
 
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


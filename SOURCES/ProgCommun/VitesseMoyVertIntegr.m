%addpath ../../Mayotte/ProgrammesTraitementGlobal_sept09/ProgCommun/DessinRobert
fich='./DessinRobert/VitesseGlobaleCampagne/VitessesIntegreesSurVerticale/';
dir='./DessinRobert/VitesseGlobaleCampagne//VitessesIntegreesSurVerticale';[a,b]=mkdir (dir);
dir='./DessinRobert/VitesseGlobaleCampagne/VitessesIntegreesSurVerticale/Vitesse';
        [a,b]=mkdir (dir);
dir='./DessinRobert/VitesseGlobaleCampagne/VitessesIntegreesSurVerticale/VitesseTidale';
        [a,b]=mkdir (dir);
dir='./DessinRobert/VitesseGlobaleCampagne/VitessesIntegreesSurVerticale/Niveau';
        [a,b]=mkdir (dir);
dir='./DessinRobert/VitesseGlobaleCampagne/VitessesIntegreesSurVerticale/NiveauZoom';
        [a,b]=mkdir (dir);
dir='./DessinRobert/VitesseGlobaleCampagne/VitessesIntegreesSurVerticale/FluxBrut';
        [a,b]=mkdir (dir);

DT=1/24; %jours
%DT=10; %jours
%DT=3/24; %jours
ech1=10000;
ech2=5000;
ech3=100000;

%% Recherche des jours de chaque pr�l�vement pour le mois �tudi�
tmin=10000000;
tmax=-10000000;
for i = 1:size(Nom,1);
    Nom(i,:);DonneesCampagne(Nom(i,:))
    load(MouillagePropre)
    time1=datum_str(Temps);
    tmin=min(min(time1),tmin);
    tmax=max(max(time1),tmax);
end
tmin=737092;
nPrelev=floor((tmax-tmin)/DT);
t_Prelev=floor(tmax-nPrelev*DT):DT:tmax;
ind_min=1;
ind_max=size(t_Prelev,2); 
decalTemps=[0;0;0;0];
  
if(strcmp(Campagne,'Tulear1')||strcmp(Campagne,'Tulear2'))
  load DatePrelev.txt;
  decalTemps=[3;3;0;1.5]/24;
  t_Prelev=datum(DatePrelev(:,3),DatePrelev(:,1),DatePrelev(:,2),...
    DatePrelev(:,4),DatePrelev(:,5),0*DatePrelev(:,1));
end
       
t_Prelev=t_Prelev';
indice=zeros(size(Nom,1),size(t_Prelev,1));
for i = 1:size(Nom,1);
  Nom(i,:);DonneesCampagne(Nom(i,:))
  N_t(i)=MaxProf(Nom(i,:));
     VitMoyenne(i).u=zeros(size(t_Prelev,1),1);
     VitMoyenne(i).v=zeros(size(t_Prelev,1),1);
     VitMoyenne_(i).u=zeros(size(t_Prelev,1),1);
     VitMoyenne_(i).v=zeros(size(t_Prelev,1),1);
     FluxMoyen(i).u=zeros(size(t_Prelev,1),1);
     FluxMoyen(i).v=zeros(size(t_Prelev,1),1);
     VitMoyenne(i).u_=zeros(size(t_Prelev,1),1);
     VitMoyenne(i).v_=zeros(size(t_Prelev,1),1);

  load(MouillagePropre)
  load(MouillageMoy)
  time1=datum_str(Temps);
  time1=time1(1:end-1);
  
  u_=VitesseCalculeeAvecHarmonique(NbOndes,HarmoniqueMoyU,...
        (datum_str(Temps)-T0)*24,T0);
  v_=VitesseCalculeeAvecHarmonique(NbOndes,HarmoniqueMoyV,...
        (datum_str(Temps)-T0)*24,T0);
    
  %Recherche des vitesses moyenne pour tous les pr�l�vements
  for ind=1:size(t_Prelev,1) 
  %clf,plot(time1,time1,'.'),hold on,plot(t_Prelev,t_Prelev,'*r')
    ii=find(time1<=t_Prelev(ind) & time1>t_Prelev(ind)-DT);
    if(isempty(ii)==0 & ii(end)<=size(time1,1))
         %plot(time1(ii),time1(ii),'.c')   
         VitMoyenne_(i).u(ind)=nanmean(VitMoy.u(ii));
         VitMoyenne_(i).v(ind)=nanmean(VitMoy.v(ii));
         VitMoyenne(i).u(ind)=nanmean(HarmoniqueMoyU.res(ii));
         VitMoyenne(i).v(ind)=nanmean(HarmoniqueMoyV.res(ii));
         FluxMoyen(i).u(ind)=nanmean(P.depth(ii).*VitMoy.u(ii));
         FluxMoyen(i).v(ind)=nanmean(P.depth(ii).*VitMoy.v(ii));
         VitMoyenne(i).u_(ind)=nanmean(u_(ii));
         VitMoyenne(i).v_(ind)=nanmean(v_(ii));
         indice(i,ind)=1;
    end
  end
end
% 
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
% VitesseMoyenne=VitMoyenne;
% save('RomsComp2','T0','t_Prelev','VitesseMoyenne','Mouillage','HarmU', 'HarmV')
i=3;DonneesCampagne(Nom(i,:));load(MouillagePropre),
hh=detrend(P.depth);
time1=datum_str(Temps);
load DonneesMouillage/Houle.mat

%% Dessins

% figure(3),clf,hold on,
% quiver(t_Prelev-T0,0*t_Prelev,VitMoyenne(i).u/50,VitMoyenne(i).v/50,0,'b')

for ind=1:size(t_Prelev,1)
    figure(1)
    clf,
    if (isempty(Photo)==0)
        image(Ylong,Xlat,Photo)
    end
    axis('equal'),axis xy,hold on

    figure(2)
    clf,
    if (isempty(Photo)==0)
        image(Ylong,Xlat,Photo)
    end
    axis('equal'),axis xy,hold on

    figure(3)
    clf,
    if (isempty(Photo)==0)
        image(Ylong,Xlat,Photo)
    end
    axis('equal'),axis xy,hold on

  for i = 1:size(Nom,1);
        figure(1)
        DonneesCampagne(Nom(i,:))
        quiver(PositionMouillage.long,PositionMouillage.lat,...
            VitMoyenne(i).u(ind)/ech1,VitMoyenne(i).v(ind)/ech1,0,'r','LineWidth',2)
        plot(PositionMouillage.long,PositionMouillage.lat,'.w')

        figure(2)
        DonneesCampagne(Nom(i,:))
        quiver(PositionMouillage.long,PositionMouillage.lat,...
            VitMoyenne(i).u_(ind)/ech2,VitMoyenne(i).v_(ind)/ech2,0,'r','LineWidth',2)
        plot(PositionMouillage.long,PositionMouillage.lat,'.w')

        figure(3)
        DonneesCampagne(Nom(i,:))
        quiver(PositionMouillage.long,PositionMouillage.lat,...
            FluxMoyen(i).u(ind)/ech3,FluxMoyen(i).v(ind)/ech3,0,'r','LineWidth',2)
        plot(PositionMouillage.long,PositionMouillage.lat,'.w')
  end
  
  %% Mise en forme et sauvegarde des images
      figure(1)
     if (isempty(Photo)==0)
         Limites=axis;axis([Limites(1) Limites(2) Limites(3) Limites(4)+0.05])
     end
      xlabel('Longitude')
      ylabel('Latitude')
        if(strcmp(Campagne,'Tulear1')||strcmp(Campagne,'Tulear2'))
          Titre=[cellstr(['Vitesse Brute'])...
              cellstr(['Pr�l�vement ' num2str(ind) 'echelle : 1/' num2str(ech1)])];
        else
            if (DT>=1)
              Titre=[cellstr([' Vitesse Brute - Moyennee sur ' num2str(DT) ' jours'])...
                     cellstr([datestr(t_Prelev(ind))  ...
                     ' jours avant - echelle: 1/' num2str(ech1)])];
            else 
              Titre=[cellstr([ ' Vitesse Brute - Moyennee sur ' num2str(DT*24) ' heures avant' ])...
                     cellstr([datestr(t_Prelev(ind)) ' - echelle : 1/' num2str(ech1)])]; 
            end 
        end
      title(Titre)
      Fichier=[fich 'Vitesse/' 'Prel_',num2str(ind),'_Vitesse'];
      saveas(gcf,Fichier,'fig')
      saveas(gcf,Fichier,'png')

      figure(2)
      if (isempty(Photo)==0)
         Limites=axis;axis([Limites(1) Limites(2) Limites(3) Limites(4)+0.05])
      end
      xlabel('Longitude')
      ylabel('Latitude')
        if(strcmp(Campagne,'Tulear1')||strcmp(Campagne,'Tulear2'))
          Titre=[cellstr([' Vitesse Tidale Moyennee '])...
              cellstr(['Pr�l�vement ' num2str(ind) ' - echelle : 1/' num2str(ech2)])];
        else
            if (DT>=1)
              Titre=[cellstr([' Vitesse Tidale Moyenne sur ' num2str(DT) ' jours'])...
                     cellstr([ datestr(t_Prelev(ind)) ' - echelle: 1/' num2str(ech2)])];
            else 
              Titre=[cellstr([' Vitesse Tidale Moyennee sur ' num2str(DT*24) ' heures'])...
                     cellstr([datestr(t_Prelev(ind)) ' - echelle : 1/' num2str(ech2)])]; 
            end 
        end
      title(Titre)
      Fichier=[ fich 'VitesseTidale/' 'Prel_',num2str(ind),'_TidaleVitesse'];
      saveas(gcf,Fichier,'fig')
      saveas(gcf,Fichier,'png')

      figure(3)
      if (isempty(Photo)==0)
         Limites=axis;axis([Limites(1) Limites(2) Limites(3) Limites(4)+0.05])
      end
      xlabel('Longitude')
      ylabel('Latitude')
        if(strcmp(Campagne,'Tulear1')||strcmp(Campagne,'Tulear2'))
          Titre=[cellstr([' Flux Brut Moyenne '])...
              cellstr(['Pr�l�vement ' num2str(ind) ' - echelle : 1/' num2str(ech3)])];
        else
            if (DT>=1)
              Titre=[cellstr([' Flux Brut Moyenne sur ' num2str(DT) ' jours'])...
                     cellstr([ datestr(t_Prelev(ind)) ' - echelle: 1/' num2str(ech3)])];
            else 
              Titre=[cellstr([' Flux Brut Moyenne sur ' num2str(DT*24) ' heures'])...
                     cellstr([datestr(t_Prelev(ind)) ' - echelle : 1/' num2str(ech3)])]; 
            end 
        end
      title(Titre)
      Fichier=[ fich 'FluxBrut/' 'Prel_',num2str(ind),'_FluxBrut'];
      saveas(gcf,Fichier,'fig')
      saveas(gcf,Fichier,'png')


      %% Niveau de la Surface libre
      figure(4)
      % Validation -inutile en regle generale -
      %  h=quiver(t_Prelev(ind)-T0,0,VitMoyenne(i).u(ind)/50,VitMoyenne(i).v(ind)/50,0,'r')
      %  axis('equal')
      %  axis([0 32 -7.5 7.5])
      clf,
      subplot(2,1,1),hold on,
      plot(time1 - T0,hh,'b') % Niveau du dernier mouillage, soit le mouillage Nord
      ii=find(time1<t_Prelev(ind) & time1>t_Prelev(ind)-DT);
      if(isempty(ii)==0 & ii(end)<=size(time1,1))
        plot(time1(ii)-T0,hh(ii),'r')
      end
      if(DT<1)
         axis([tmin-T0-2*DT tmax-T0+2*DT -1 1]) 
      else
         axis([tmin-T0 tmax-T0 min(hh) max(hh)]) 
      end

      %% Houle
      subplot(2,1,2),hold on,
      plot(T_Houle-T0_Houle-T0,Hs_Nord,'b',T_Houle-T0_Houle-T0,Hs_Sud,'k')
      ii=find(T_Houle-T0_Houle<t_Prelev(ind) & T_Houle-T0_Houle>t_Prelev(ind)-DT);
      if(isempty(ii)==0 & ii(end)<=size(T_Houle,1))
        plot(T_Houle(ii)-T0_Houle-T0,Hs_Nord(ii),'r',T_Houle(ii)-T0_Houle-T0,Hs_Sud(ii),'r')
      end
      if(DT<1)
         axis([tmin-T0-2*DT tmax-T0+2*DT 0 4]) 
      else
         axis([tmin-T0 tmax-T0 0 4]) 
      end
      Titre=[cellstr(['Prelevement du :' datestr(t_Prelev(ind))])];
      title(Titre)
      Fichier=[fich 'Niveau/' 'Prel_',num2str(ind),'_Niveau'];
      saveas(gcf,Fichier,'fig')
      saveas(gcf,Fichier,'png')
      
      if(DT<1)
          subplot(2,1,1),
             axis([t_Prelev(ind)-T0-10 t_Prelev(ind)-T0+10 -1 1]) 
          subplot(2,1,2),
             axis([t_Prelev(ind)-T0-10 t_Prelev(ind)-T0+10 0 4]) 
          Fichier=[fich 'NiveauZoom/' 'Prel_',num2str(ind),'_Niveau'];
          saveas(gcf,Fichier,'fig')
          saveas(gcf,Fichier,'png')
      end
    %   figure(1)

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


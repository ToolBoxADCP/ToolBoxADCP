AA=1:size(Nom,1);
%%Modif de AA en fonction du dossier :
  % Dossier Validation Tulear
  dossier='C:\Documents and Settings\Chevalier\Mes documents\Tulear\Transect Particulier Tulear_sept09';
  if(strcmp(pwd,dossier)==1),AA=[1 3];end
  
  % Dossier Mayotte
  if (strcmp(Campagne,'Mayotte1')==1),AA=[1 3 4];end
  
  % Dossier Tulear
  
for ind_nom = AA;%:size(Nom,1);
    Nom(ind_nom,:)
  DonneesCampagne(Nom(ind_nom,:));
%  TronconValidation=1
%    form_mouillageC
%    Transect
close all

%% Initialisation
dist_pr_min=10000; 
dist_min=400; 

load(Ftransth)  % récupérer p_TS --> ref du transect théo
%load (MouillagePropre_proj)
load (MouillagePropre)

%% Loops sur transect et Troncon
%for Tronc=1:nbTronc;
Tronc=TronconValidation;
A=[dfile(Tronc,:) '*'];a=ls(A);NbTrans(Tronc)=size(a,1);

for j=1:NbTrans(Tronc);j
    clear Tr_ADCP Tr_vitesse Tr_Temps M_vitesse
    clear M_Temps Tr_depth M_depth Tr_niv
  %Tfile_th=[dfile_th(Tronc,:) num2str(j)];load (Tfile_th);
  Tfile=[dfile(Tronc,:) num2str(j)];Tfile,load(Tfile);
  Validationfile=[DonneeValidation Campagne '_' nom '_' num2str(j)];
  
%% Positionnement Transect/mouillage :
  % Calcul Projection :
  [T_ADCPpr(Tronc).long,T_ADCPpr(Tronc).lat]=projection_ortho(T_ADCP.long,T_ADCP.lat,p_TS(Tronc,1),p_TS(Tronc,2));
  [PosMouilpr(Tronc).long,PosMouilpr(Tronc).lat]=projection_ortho(PositionMouillage.long,-PositionMouillage.lat,p_TS(Tronc,1),p_TS(Tronc,2));

  
  % Ditance au mouillage :
  dist_mouil=sqrt(((T_ADCP.long-PositionMouillage.long).*dLong).^2+ ...
      ((-T_ADCP.lat-PositionMouillage.lat)*dLat).^2);
  dist_pr=sqrt(((T_ADCPpr(Tronc).long-PosMouilpr(Tronc).long).*dLong).^2+ ...
      ((-T_ADCPpr(Tronc).lat+PosMouilpr(Tronc).lat)*dLat).^2);

  %ii=find(dist_pr<dist_pr_min);
  ii=find(dist_mouil<dist_min);
  
  %% Dessins :
  figure(1),clf
   clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on
  plot(T_ADCP.long,-T_ADCP.lat,'.b') % Position exacte du transect
  hold on 
  plot(T_ADCPpr(Tronc).long,-T_ADCPpr(Tronc).lat,'.k') % Projection du transect
  plot(PositionMouillage.long,PositionMouillage.lat,'+m')% Position du mouillage
  plot(PosMouilpr(Tronc).long,-PosMouilpr(Tronc).lat,'or')% Projection du mouillage
  plot(T_ADCPpr(Tronc).long(ii),-T_ADCPpr(Tronc).lat(ii),'.r')% Position des points sélectionnés 
  plot(T_ADCP.long(ii),-T_ADCP.lat(ii),'.m')% Position des points sélectionnés 
  axis equal,axis(axe),
  num=0;
%% Vitesse :
  if(isempty(ii)~=1)
      for index=1:size(ii,1)
         i=ii(index);
         
          figure(1)
          plot(T_ADCP.long(i),-T_ADCP.lat(i),'.g') % Position exacte du transect
          %Determination mouillage
          t_transect=(datum_str(T_Temps)-T0)*24;% en heure
          t_mouillage=((datum_str(Temps))-T0)*24;
          dt_min=min(diff(t_mouillage))/2.;
          deltat=t_mouillage-t_transect(i);
          jj=find(abs(deltat)<=dt_min);
          
          %Dessin
            %Donnée transect :
           figure(2),clf
            subplot(1,2,1),plot(Tvitesse.u(i,:),dfond(i,:),'b')
            grid,hold on,%axis([-350 100 0 30])
            title(['vitesse U et V ' ])
            subplot(1,2,2),plot(Tvitesse.v(i,:),dfond(i,:),'b')
            grid,hold on,%axis([-350 100 0 30])
            title(['jour ' num2str(T_Temps.day(i)) ' Heure :' ...
                num2str(T_Temps.hour(i)) 'h' num2str(T_Temps.minute(i))])

           figure(3),clf
            %Donnée transect :
            [cap,module]=uv2dirspeed(Tvitesse.u(i,:),Tvitesse.v(i,:));
            subplot(1,2,1),plot(module,dfond(i,:),'b')
            grid,hold on,%axis([0 500 0 30])
            title(['Module et angle' ])
            subplot(1,2,2),plot(cap,dfond(i,:),'b')
            grid,hold on,%axis([0 360 0 30])
            title(['jour ' num2str(T_Temps.day(i)) ...
                '/' num2str(T_Temps.month(i)) ' Heure :' ...
                num2str(T_Temps.hour(i)) 'h' num2str(T_Temps.minute(i))])

            %Donnée mouillage :
            if(isempty(jj)~=1)
              for ind=1:size(jj,1)
                  num=num+1;
                u=(vitesse.u(jj(ind),:));
                v=(vitesse.v(jj(ind),:));
               figure(2)
                subplot(1,2,1),plot(u,P_Adcp.fond_f(jj(ind),:),'r')
                subplot(1,2,2),plot(v,P_Adcp.fond_f(jj(ind),:),'r')
               figure(3)
                [cap,module]=uv2dirspeed(u,v);
                subplot(1,2,1),plot(module,P_Adcp.fond_f(jj(ind),:),'r')
                subplot(1,2,2),plot(cap,P_Adcp.fond_f(jj(ind),:),'r')
%Tdepth(i)
                pause
      
%% Sauvegarde des valeurs :
% Variables:
% Campagne : Nom de la campagne
% nomM : nom du mouillage
% PositionMouillage : Position du mouillage
% nomT : nom du transect
% pp_TS : transect theorique
% NbEnr : nombre de point de transect
% Pour chaque point i de transect et chaque valeur du mouillage :
    % num : numero de l'enr
    % Tr_ADCP(i) : position du point de mesure du transect
    % Tr_depth(i): profondeur de mesure du transect
    % Tr_niv(i) : Hauteur de la marée à l'instant de la mesure
    % Tr_z(i) : altitude des mesures du transect
    % Tr_temps(i) : heure de la mesure
    % Tr_vitesse(i) : Vitesse du transect
    % M_z(i) : altitude des mesures du mouillage
    % M_vitesse(i) : Vitesse du mouillage
    % M_temps(i) : heure de la mesure
        
    Tr_ADCP(num).long=T_ADCP.long(i);
    Tr_ADCP(num).lat=T_ADCP.lat(i);
    
    Tr_vitesse(num).z=dfond(i,:);
    Tr_vitesse(num).u=Tvitesse.u(i,:);
    Tr_vitesse(num).v=Tvitesse.v(i,:);
    Tr_vitesse(num).ubt=Tvitesse.ubt(i);
    Tr_vitesse(num).vbt=Tvitesse.vbt(i);
    
    Tr_Temps(num).year=T_Temps.year(i,:);
    Tr_Temps(num).month=T_Temps.month(i,:);
    Tr_Temps(num).day=T_Temps.day(i,:);
    Tr_Temps(num).hour=T_Temps.hour(i,:);
    Tr_Temps(num).minute=T_Temps.minute(i,:);
    Tr_Temps(num).seconde=T_Temps.seconde(i,:);
    
    M_vitesse(num).z= P_Adcp.fond_f(jj(ind),:);
    M_vitesse(num).u=vitesse.u(jj(ind),:);
    M_vitesse(num).v=vitesse.v(jj(ind),:);
    
    M_Temps(num).year=Temps.year(jj(ind),:);
    M_Temps(num).month=Temps.month(jj(ind),:);
    M_Temps(num).day=Temps.day(jj(ind),:);
    M_Temps(num).hour=Temps.hour(jj(ind),:);
    M_Temps(num).minute=Temps.minute(jj(ind),:);
    M_Temps(num).seconde=Temps.seconde(jj(ind),:);

    Tr_depth(num)=Tdepth(i);
    M_depth(num)=P.depth(jj(ind));
    tempo=detrend(P.depth);
    Tr_niv(num)=tempo(jj(ind));
    
             end
           end
%             pause
          figure(1)
          plot(T_ADCP.long(i),-T_ADCP.lat(i),'.m') % Position exacte du transect
      end
  end

  if(num~=0)
    NomT=j;
   NomM=nom;
   PositionMouillage.long=P.long;
   PositionMouillage.lat=P.lat;
   Campagne;
   p_TS;
   NbEnr=num;
%   'validation',pause
save(Validationfile,'NomT','NomM','PositionMouillage',...
    'Campagne','p_TS','NbEnr','Tr_depth','M_depth',...
    'Tr_niv','M_Temps','M_vitesse','Tr_Temps','Tr_vitesse',...
    'Tr_ADCP','dist_pr','dist_mouil')

  end
%pause
end
%end
  
  

end

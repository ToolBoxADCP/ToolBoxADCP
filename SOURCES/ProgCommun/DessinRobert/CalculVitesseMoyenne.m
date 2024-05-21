for i = 1:size(Nom,1);
  close all
  DonneesCampagne(Nom(i,:));
  load(MouillagePropre)
  
%% Vitesse Moyenne :
  NivMax=MaxProf(Nom(i,:));
  VitMoy.u=nansum(...
       (P_Adcp.fond_f(:,2:NivMax)-P_Adcp.fond_f(:,1:NivMax-1))/2.....
       .*(vitesse.u(:,1:NivMax-1)+vitesse.u(:,1:NivMax-1))...
       ,2)...
       ./(P_Adcp.fond_f(:,NivMax)-P_Adcp.fond_f(:,1))   ;
 
  VitMoy.v=nansum(...
       (P_Adcp.fond_f(:,2:NivMax)-P_Adcp.fond_f(:,1:NivMax-1))/2.....
       .*(vitesse.v(:,1:NivMax-1)+vitesse.v(:,1:NivMax-1))...
       ,2)...
       ./(P_Adcp.fond_f(:,NivMax)-P_Adcp.fond_f(:,1))   ;

%% Ellipse et Vitesse projet�e :
  [EllipseMoy VitMoy_proj]=ellipse...
      (1,size(VitMoy.u,1),VitMoy.u,VitMoy.v,0,char(Nom(i,:)));
  tetaMoy=EllipseMoy.teta;

  if(SigneVit==-1)
      tetaMoy=tetaMoy+pi;
      VitMoy_proj.u=-VitMoy_proj.u;
      VitMoy_proj.v=-VitMoy_proj.v;
  end
  
%% Harmoniques
  HarmoniqueForemanMoyenne
[a,b]=mkdir (Dir_MouillageIntegreVert);  
  save(MouillageMoy,'Temps','VitMoy','VitMoy_proj',...
      'tetaMoy','NivMax','EllipseMoy',...
      'HarmoniqueMoyU','HarmoniqueMoyV',...
      'HarmoniqueMoyU_proj','HarmoniqueMoyV_proj')
%  disp('appuyer sur une touche'),pause
end

%% ECRITURE
if(BolCalcul_fait==1)
 Entree_Foreman
 ValAmplPhase_proj
end
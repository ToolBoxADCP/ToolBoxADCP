BolFig=0;

%% Inscription du nom du mouillage
fid1=fopen(fichierGlobal,'at');
fprintf(fid1,'\n \n     Mouillage :');
fprintf(fid1,'%s \n ',nom);
fclose(fid1)
    
%% Initialisation variables communes
  load (MouillagePropre)
  t=(datum_str(Temps));% en jour
  Jour=floor(t)-T0;max(Jour),Heure=(t-T0-Jour)*24;
  fichierE=[Dir 'TempE'];
  fichierScommun=[Dir 'Harmonique/HarmoniqueForeman/'];

%% Niveau
  fichierS=[num2str(fichierScommun) 'Niveau' num2str(nom)];

  if (strcmp(FichPression,'Non  ')==0)
    H=P.depth-nanmean(P.depth);
  else
    H=0*Jour;
  end
  courant=[Jour Heure H];
  save(fichierE,'courant')
  
  if size(find(H~=0),1)>0
      MareeMouillage
  end

%    i,'niveau',pause

%% Vitesse U proj
  load(MouillageMoy)
  fichierS=[num2str(fichierScommun) 'Courant' num2str(nom)];

%  courant=[Jour Heure VitMoy_proj.u];
  DT_MoyGlissante=2;
  [MoyGliss,Vit_]=MoyGlissante(Jour+Heure/24,VitMoy_proj.u,...
                                        DT_MoyGlissante,BolFig);
  courant=[Jour Heure Vit_];
  save(fichierE,'courant')
  if size(find(isnan(Vit_)==0),1)>0
    MareeMouillage
  end
%      i,'vitesse',pause
  
  fclose all

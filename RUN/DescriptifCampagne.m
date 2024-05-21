addpath /home/cristele/Documents/ProgrammesTraitementDonnees/ProgCommun/smartquad
addpath /home/cristele/Documents/ProgrammesTraitementDonnees/ProgCommun/DessinRobert
addpath /home/cristele/Documents/ProgrammesTraitementDonnees/ProgCommun/TraitementTransect
addpath /home/cristele/Documents/ProgrammesTraitementDonnees/ProgCommun
addpath /home/cristele/Documents/ProgrammesTraitementDonnees/Foreman
GlobaleVar

Dir=[pwd '/'];


%% Campagne
  Campagne='UECOCOT';
    
% Mouillage::
 %Nom=[{'POUANGA'};{'POINT_FIXE'};{'PASSE'};{'VAVOUTO'};{'LAGON_SUD'};{'SUD'};{'Recif'}];
 %Nom=[{'LAGON_SUD'}];
 Nom=[{'PASSE'}];


 
% Début de campagne : MILIEU DE LA CARTE !!!!
  LongM=164; LatM=-21;
  dLat=111000; % en m�tres, 1 degr� de latitude
  dLong=111000*cos(LatM/180*pi);
 
 % limites g�ographiques de la carte
 axe_glob=[164.48 164.75 -21.07 -20.915];

%  La veille du 1 janvier 2018, Comme ca, les jours correspondent aux 
%  jours julien
  T0=(datum(2018,1,1,0,0,0))-1;   
      
% Traitement
   NbOndes=5;   % Nombre d'onde d'interpolation
     
% Carte:
  %carte=['./Photo/carteTeremba'];
  photo=['./Photo/PhotoYlongXlat.mat'];
  %photo=[];
  load(photo)
    
  % Declinaison Magnetique (Head Bias) 
  errM=11.4;

% Validation
    DonneeValidation=['./Validation/'];
    
   

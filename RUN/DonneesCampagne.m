function DonneesCampagne(i)

DescriptifCampagne
nom=char(i);
Dir_DonneesMouillage=[Dir 'DonneesMouillage/'];
Dir_DonneesPropres=[Dir 'DonneesPropres/'];
Dir_BorneMouillage=[Dir 'BorneMouillage/'];
Dir_MouillageIntegreVert=[Dir 'MouillageIntegreVert/'];
Dir_MouillageAnalyse=[Dir 'MouillageAnalyse/'];
%%=======================================================================
% MOUILLAGE SUD UECOCOT
% ADCP RDI 1.2 MHz 
% prof 3m
%=======================================================================
if strcmp(char(nom),'SUD')
    SigneVit=1; % convention Crist�le: mettre 1 au d�part pour marquer entrant/sortant lagon

% Positionnement :    
    PositionMouillage.long=164+39.762/60;
    PositionMouillage.lat=-(21+02.436/60);
    
  % Caract�ristiques mat�riel :
    errM=0; % Déclinaison corrigée dans le process ADCP
    hadcpM=0;
    blankM=0.95;
    celM=0.4;   
    % nb mailles = (13.80-3.74)/1.5+1+1=9

  %type d'ADCP : 'SONTEK' ou 'RDI   '
  %Type de fichier li� � la pression : 'ascii' ou 'ADCP ' ou 'donne'
    NomADCP='RDI   ';  
    FichPression='ADCP '; LissagePression='Non';
    NomTemp='RDI';  
    NomEcho='RDI';  
   
  % Fichiers de donn�es
    DonneesMouillage=[Dir_DonneesMouillage 'SUD.mat'];  %Fichier fourni 
    DonneesPression=[Dir_DonneesMouillage 'SUD.mat'];	  %Fichier fourni 
    
  % Fichiers r�sultats 
    BorneMouillage=[Dir_BorneMouillage 'SUD' '.mat'];
    MouillagePropre=[Dir_DonneesPropres 'Vit_SUD'];
    MouillageMoy=[Dir_MouillageIntegreVert 'Vit_SUD'];
    MouillageAnalyse=[Dir_MouillageAnalyse 'Vit_SUD'];
    MouillagePropre_proj=[Dir_DonneesPropres 'VitProj_SUD'];
    MouillageAnalyse_proj=[Dir_MouillageAnalyse 'VitProj_SUD'];

  % Temperature:
    TemperaturePropre=[Dir_DonneesPropres 'Temp_SUD'];
    TemperatureAnalyse=[Dir_MouillageAnalyse 'Temp_SUD'];

  % Echo:
    EchoPropre=[Dir_DonneesPropres 'Echo_SUD'];
    EchoAnalyse=[Dir_MouillageAnalyse 'Echo_SUD'];
end

%%=======================================================================
% MOUILLAGE LAGON_SUD UECOCOT
% ADCP RDI 300 kHz 
% prof 44m
%=======================================================================
if strcmp(char(nom),'LAGON_SUD')
    SigneVit=1; % convention Crist�le: mettre 1 au d�part pour marquer entrant/sortant lagon

% Positionnement :    
    PositionMouillage.long=164+37.344/60;
    PositionMouillage.lat=-(20+59.925/60);
    ProfMoy=44.; % Mesure Plongeur : Indispensable si pas de donnes pression
    
  % Caract�ristiques mat�riel :
    errM=0; % Déclinaison corrigée dans le process ADCP
    hadcpM=0;
    blankM=4.23;
    celM=2;   
    % nb mailles = (13.80-3.74)/1.5+1+1=9

  %type d'ADCP : 'SONTEK' ou 'ADI   '
  %Type de fichier li� � la pression : 'ascii' ou 'ADCP ' ou 'donne'
    NomADCP='RDI   ';  
    FichPression='Autre'; LissagePression='Non';
    NomTemp='RDI';  
    NomEcho='RDI';  
   
  % Fichiers de donn�es
    DonneesMouillage=[Dir_DonneesMouillage 'LAGON_SUD.mat'];  %Fichier fourni 
    DonneesPression=[Dir_DonneesPropres 'Vit_POINT_FIXE'];	  %Fichier fourni 
    
  % Fichiers r�sultats 
    BorneMouillage=[Dir_BorneMouillage 'LAGON_SUD' '.mat'];
    MouillagePropre=[Dir_DonneesPropres 'Vit_LAGON_SUD'];
    MouillageMoy=[Dir_MouillageIntegreVert 'Vit_LAGON_SUD'];
    MouillageAnalyse=[Dir_MouillageAnalyse 'Vit_LAGON_SUD'];
    MouillagePropre_proj=[Dir_DonneesPropres 'VitProj_LAGON_SUD'];
    MouillageAnalyse_proj=[Dir_MouillageAnalyse 'VitProj_LAGON_SUD'];

  % Temperature:
    TemperaturePropre=[Dir_DonneesPropres 'Temp_LAGON_SUD'];
    TemperatureAnalyse=[Dir_MouillageAnalyse 'Temp_LAGON_SUD'];

  % Echo:
    EchoPropre=[Dir_DonneesPropres 'Echo_LAGON_SUD'];
    EchoAnalyse=[Dir_MouillageAnalyse 'Echo_LAGON_SUD'];
end


%%=======================================================================
% MOUILLAGE POUANGA UECOCOT
% ADCP RDI 600 kHz 
% prof 44m
%=======================================================================
if strcmp(char(nom),'POUANGA')
    SigneVit=1; % convention Crist�le: mettre 1 au d�part pour marquer entrant/sortant lagon

% Positionnement :    
    PositionMouillage.long=164+33.643/60;
    PositionMouillage.lat=-(20+56.274/60);
    
  % Caract�ristiques mat�riel :
    errM=0; % Déclinaison corrigée dans le process ADCP
    hadcpM=0;
    blankM=1.62;
    celM=0.5;   
    % nb mailles = (13.80-3.74)/1.5+1+1=9

  %type d'ADCP : 'SONTEK' ou 'ADI   '
  %Type de fichier li� � la pression : 'ascii' ou 'ADCP ' ou 'donne'
    NomADCP='RDI   ';  
    FichPression='ADCP '; LissagePression='Non';
    NomTemp='RDI';  
    NomEcho='RDI';  
   
  % Fichiers de donn�es
    DonneesMouillage=[Dir_DonneesMouillage 'POUANGA.mat'];  %Fichier fourni 
    DonneesPression=[Dir_DonneesMouillage 'POUANGA.mat'];	  %Fichier fourni 
    
  % Fichiers r�sultats 
    BorneMouillage=[Dir_BorneMouillage 'POUANGA' '.mat'];
    MouillagePropre=[Dir_DonneesPropres 'Vit_POUANGA'];
    MouillageMoy=[Dir_MouillageIntegreVert 'Vit_POUANGA'];
    MouillageAnalyse=[Dir_MouillageAnalyse 'Vit_POUANGA'];
    MouillagePropre_proj=[Dir_DonneesPropres 'VitProj_POUANGA'];
    MouillageAnalyse_proj=[Dir_MouillageAnalyse 'VitProj_POUANGA'];

  % Temperature:
    TemperaturePropre=[Dir_DonneesPropres 'Temp_POUANGA'];
    TemperatureAnalyse=[Dir_MouillageAnalyse 'Temp_POUANGA'];

  % Echo:
    EchoPropre=[Dir_DonneesPropres 'Echo_POUANGA'];
    EchoAnalyse=[Dir_MouillageAnalyse 'Echo_POUANGA'];
end


%%=======================================================================
% MOUILLAGE PASSE UECOCOT
% ADCP RDI 300 kHz 
% prof 56m
%=======================================================================
if strcmp(char(nom),'PASSE')
    SigneVit=1; % convention Crist�le: mettre 1 au d�part pour marquer entrant/sortant lagon

% Positionnement :    
    PositionMouillage.long=164+36.176/60;
    PositionMouillage.lat=-(21+00.164/60);
    
  % Caract�ristiques mat�riel :
    errM=0; % Déclinaison corrigée dans le process ADCP
    hadcpM=0;
    blankM=4.23;
    celM=2;   
    % nb mailles = (13.80-3.74)/1.5+1+1=9

  %type d'ADCP : 'SONTEK' ou 'ADI   '
  %Type de fichier li� � la pression : 'ascii' ou 'ADCP ' ou 'donne'
    NomADCP='RDI   ';  
    FichPression='ADCP '; LissagePression='Non';
    NomTemp='RDI';  
    NomEcho='RDI';  
   
  % Fichiers de donn�es
    DonneesMouillage=[Dir_DonneesMouillage 'PASSE.mat'];  %Fichier fourni 
    DonneesPression=[Dir_DonneesMouillage 'PASSE.mat'];	  %Fichier fourni 
    
  % Fichiers r�sultats 
    BorneMouillage=[Dir_BorneMouillage 'PASSE' '.mat'];
    MouillagePropre=[Dir_DonneesPropres 'Vit_PASSE'];
    MouillageMoy=[Dir_MouillageIntegreVert 'Vit_PASSE'];
    MouillageAnalyse=[Dir_MouillageAnalyse 'Vit_PASSE'];
    MouillagePropre_proj=[Dir_DonneesPropres 'VitProj_PASSE'];
    MouillageAnalyse_proj=[Dir_MouillageAnalyse 'VitProj_PASSE'];

  % Temperature:
    TemperaturePropre=[Dir_DonneesPropres 'Temp_PASSE'];
    TemperatureAnalyse=[Dir_MouillageAnalyse 'Temp_PASSE'];

  % Echo:
    EchoPropre=[Dir_DonneesPropres 'Echo_PASSE'];
    EchoAnalyse=[Dir_MouillageAnalyse 'Echo_PASSE'];
end



%%=======================================================================
% MOUILLAGE VAVOUTO UECOCOT
% ADCP RDI 300 kHz 
% prof 15m
%=======================================================================
if strcmp(char(nom),'VAVOUTO')
    SigneVit=1; % convention Crist�le: mettre 1 au d�part pour marquer entrant/sortant lagon

% Positionnement :    
    PositionMouillage.long=164+38.571/60;
    PositionMouillage.lat=-(20+59.445/60);
    
  % Caract�ristiques mat�riel :
    errM=0; % Déclinaison corrigée dans le process ADCP
    hadcpM=0;
    blankM=4.23;
    celM=2;   
    % nb mailles = (13.80-3.74)/1.5+1+1=9

  %type d'ADCP : 'SONTEK' ou 'ADI   '
  %Type de fichier li� � la pression : 'ascii' ou 'ADCP ' ou 'donne'
    NomADCP='RDI   ';  
    FichPression='ADCP '; LissagePression='Non';
    NomTemp='RDI';  
    NomEcho='RDI';  
   
  % Fichiers de donn�es
    DonneesMouillage=[Dir_DonneesMouillage 'VAVOUTO.mat'];  %Fichier fourni 
    DonneesPression=[Dir_DonneesMouillage 'VAVOUTO.mat'];	  %Fichier fourni 
    
  % Fichiers r�sultats 
    BorneMouillage=[Dir_BorneMouillage 'VAVOUTO' '.mat'];
    MouillagePropre=[Dir_DonneesPropres 'Vit_VAVOUTO'];
    MouillageMoy=[Dir_MouillageIntegreVert 'Vit_VAVOUTO'];
    MouillageAnalyse=[Dir_MouillageAnalyse 'Vit_VAVOUTO'];
    MouillagePropre_proj=[Dir_DonneesPropres 'VitProj_VAVOUTO'];
    MouillageAnalyse_proj=[Dir_MouillageAnalyse 'VitProj_VAVOUTO'];

  % Temperature:
    TemperaturePropre=[Dir_DonneesPropres 'Temp_VAVOUTO'];
    TemperatureAnalyse=[Dir_MouillageAnalyse 'Temp_VAVOUTO'];

  % Echo:
    EchoPropre=[Dir_DonneesPropres 'Echo_VAVOUTO'];
    EchoAnalyse=[Dir_MouillageAnalyse 'Echo_VAVOUTO'];
end


%%=======================================================================
% MOUILLAGE POINT FIXE UECOCOT
% ADCP RDI 300 kHz 
% prof 37m
%=======================================================================
if strcmp(char(nom),'POINT_FIXE')
    SigneVit=1; % convention Crist�le: mettre 1 au d�part pour marquer entrant/sortant lagon

% Positionnement :    
    PositionMouillage.long=164+36.860/60;
    PositionMouillage.lat=-(20+58.338/60);
    
  % Caract�ristiques mat�riel :
    errM=0; % Déclinaison corrigée dans le process ADCP
    hadcpM=0;
    blankM=4.23;
    celM=2;   
    % nb mailles = (13.80-3.74)/1.5+1+1=9

  %type d'ADCP : 'SONTEK' ou 'ADI   '
  %Type de fichier li� � la pression : 'ascii' ou 'ADCP ' ou 'donne'
    NomADCP='RDI   ';  
    FichPression='ADCP '; LissagePression='Non';
    NomTemp='RDI';  
    NomEcho='RDI';  
   
  % Fichiers de donn�es
    DonneesMouillage=[Dir_DonneesMouillage 'POINT_FIXE.mat'];  %Fichier fourni 
    DonneesPression=[Dir_DonneesMouillage 'POINT_FIXE.mat'];	  %Fichier fourni 
    
  % Fichiers r�sultats 
    BorneMouillage=[Dir_BorneMouillage 'POINT_FIXE' '.mat'];
    MouillagePropre=[Dir_DonneesPropres 'Vit_POINT_FIXE'];
    MouillageMoy=[Dir_MouillageIntegreVert 'Vit_POINT_FIXE'];
    MouillageAnalyse=[Dir_MouillageAnalyse 'Vit_POINT_FIXE'];
    MouillagePropre_proj=[Dir_DonneesPropres 'VitProj_POINT_FIXE'];
    MouillageAnalyse_proj=[Dir_MouillageAnalyse 'VitProj_POINT_FIXE'];

  % Temperature:
    TemperaturePropre=[Dir_DonneesPropres 'Temp_POINT_FIXE'];
    TemperatureAnalyse=[Dir_MouillageAnalyse 'Temp_POINT_FIXE'];

  % Echo:
    EchoPropre=[Dir_DonneesPropres 'Echo_POINT_FIXE'];
    EchoAnalyse=[Dir_MouillageAnalyse 'Echo_POINT_FIXE'];
end


%%=======================================================================
% Récif :
%  – ADCP Sontek + RBR DUO (oubli)
% Profondeur : 3m
%=======================================================================
if strcmp(char(nom),'Recif')
    SigneVit=-1;
    errM= 0; % Déclinaison corrigée dans le process post-traitement Sontek

  % Caract�ristiques mat�riel :

% Positionnement :    
    PositionMouillage.long=164+37.473/60;
    PositionMouillage.lat=-(21+1.861/60);
    ProfMoy=4.; % Mesure Plongeur : Indispensable si pas de donnes pression
    

  % Caract�ristiques mat�riel :
    hadcpM=0.4;
    blankM=0.2;
    celM=0.25;

  %type d'ADCP : 'SONTEK' ou 'ADI   '
  %Type de fichier li� � la pression : 'ascii' ou 'ADCP ' ou 'donne'
    NomADCP='SONTEK';  ANNEE=2018;
    %FichPression='Non  '; LissagePression='Non';
    FichPression='Autre'; LissagePression='Non';
    NomTemp='ADCP ';
    NomEcho='ADCP ';  
   
  % Fichiers de donn�es
    DonneesMouillage=[Dir_DonneesMouillage 'Recif/SUD001'];  %Fichier fourni 
    DonneesPression=[Dir_DonneesPropres 'Vit_POINT_FIXE'];	  %Fichier fourni 
    
  % Fichiers r�sultats 
    BorneMouillage=[Dir_BorneMouillage 'Recif' '.mat'];
    MouillagePropre=[Dir_DonneesPropres 'Vit_Recif'];
    MouillageMoy=[Dir_MouillageIntegreVert 'Vit_Recif'];
    MouillageAnalyse=[Dir_MouillageAnalyse 'Vit_Recif'];
    MouillagePropre_proj=[Dir_DonneesPropres 'VitProj_Recif'];
    MouillageAnalyse_proj=[Dir_MouillageAnalyse 'VitProj_Recif'];

  % Temperature:
     TemperaturePropre=[Dir_DonneesPropres 'Temp_Recif'];
    TemperatureAnalyse=[Dir_MouillageAnalyse 'Temp_Recif'];

  % Echo:
    EchoPropre=[Dir_DonneesPropres 'Echo_Recif'];
    EchoAnalyse=[Dir_MouillageAnalyse 'Echo_Recif'];
end

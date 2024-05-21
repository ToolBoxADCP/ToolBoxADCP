%% Ouverture Fichier d'�criture
dirGlobal=[Dir 'Harmonique/Recapitulation'];
[a,b]=mkdir (dirGlobal);
fichierGlobal=[dirGlobal '/Mouillage'];
fid1=fopen(fichierGlobal,'wt');

%% D�finition boucle


for i = 1:size(Nom,1);
%% Travail dans la boucle
% lecture des variables
    Nom(i,:),DonneesCampagne(Nom(i,:))
    close all

    load (MouillageMoy),load(MouillageAnalyse)
    fprintf(fid1,'\n\n\n     Mouillage :');
    fprintf(fid1,'%s \n ',nom);


% Calcul de la vitesse U
    disp(' ')
    disp('Vitesse U')
    fprintf(fid1,'\n     Vitesse U :  \n');
    if (size(HarmoniqueMoyU,1)>0)
        [amplU,phU]=Ecri_Ampl(HarmoniqueMoyU,fid1,1);
    end
    
% Calcul de la vitesse V
    disp(' ')
    disp('Vitesse V')
    fprintf(fid1,'\n     Vitesse V :  \n');
    if (size(HarmoniqueMoyU,1)>0)
        [amplV,phV]=Ecri_Ampl(HarmoniqueMoyV,fid1,1);
    end

% Calcul du niveau
    if (strcmp(FichPression,'Non  ')==0)
       disp(' ')
       disp('Niveau')
       fprintf(fid1,'\n     Niveau :  \n');
        if (size(HarmoniqueMoyU,1)>0)
           [amplH,phH]=Ecri_Ampl(HarmoniqueH,fid1,0);
        end

       dphU=phH-phU;
       fprintf(fid1,'\n Dephase Niveau/vitesse U  en heure : ');
       for k=1:size(amplH,2)
         fprintf(fid1,'%8.2f ',dphU(k));
         fprintf(fid1,'%t ');
       end

       dphV=phH-phV;
       fprintf(fid1,'\n Dephase Niveau/vitesse V  en heure : ');
       for k=1:size(amplH,2)
         fprintf(fid1,'%8.2f ',dphV(k));
         fprintf(fid1,'%t ');
       end
    end

% Calcul de la vitesse U_proj
    disp(' ')
    disp('Vitesse U_proj')
    fprintf(fid1,'\n     Vitesse U_proj :  \n');
    if (size(HarmoniqueMoyU,1)>0)
        [amplU,phU]=Ecri_Ampl(HarmoniqueMoyU_proj,fid1,1);
    end
    
% Calcul de la vitesse V_proj
    disp(' ')
    disp('Vitesse V_proj')
    fprintf(fid1,'\n     Vitesse V_proj :  \n');
    if (size(HarmoniqueMoyU,1)>0)
        [amplV,phV]=Ecri_Ampl(HarmoniqueMoyV_proj,fid1,1);
    end

% Calcul du niveau
    if (strcmp(FichPression,'Non  ')==0)
       disp(' ')
       disp('Niveau')
       fprintf(fid1,'\n     Niveau :  \n');
        if (size(HarmoniqueMoyU,1)>0)
           [amplH,phH]=Ecri_Ampl(HarmoniqueH,fid1,0);
        end

       dphU=phH-phU;
       fprintf(fid1,'\n Dephase Niveau/vitesse U  en heure : ');
       for k=1:size(amplH,2)
         fprintf(fid1,'%8.2f ',dphU(k));
         fprintf(fid1,'%t ');
       end

       dphV=phH-phV;
       fprintf(fid1,'\n Dephase Niveau/vitesse V  en heure : ');
       for k=1:size(amplH,2)
         fprintf(fid1,'%8.2f ',dphV(k));
         fprintf(fid1,'%t ');
       end
    end


%% Fin de la boucle
end
fclose(fid1);

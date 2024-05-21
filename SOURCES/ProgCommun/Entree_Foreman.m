
%addpath ../Foreman
dirGlobal=[Dir 'Harmonique/HarmoniqueForeman'];
[a,b]=mkdir (dirGlobal);
fichierGlobal=[dirGlobal '/Mouillage'];
fid1=fopen(fichierGlobal,'wt');
    fprintf(fid1,'\n Tidal amplitude and phase with 95%% CI estimates\n');
fclose(fid1)

close all

for i = 1:size(Nom,1);
    DonneesCampagne(Nom(i,:))
    
    Entree_Foreman_mouillage
end


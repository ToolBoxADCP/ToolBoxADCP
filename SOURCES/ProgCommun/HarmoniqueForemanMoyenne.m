%% Choix de Ondes
Ondes=ChoixOndes(NbOndes);

%% Creation du fichier � lire par Foreman
t=(datum_str(Temps));% en jour
Jour=floor(t)-T0;Heure=(t-Jour-T0)*24;
fichierE=['TempE'];
fichierS=['TempS'];
  
clear HarmoniqueMoyU HarmoniqueMoyV
clear HarmoniqueMoyU_proj HarmoniqueMoyV_proj
clear U

%% Vitesse U :  
if (size(find(isnan(VitMoy.u)==0),1)>1)
    HarmoniqueMoyU=DefHarmonique(Jour,Heure,VitMoy.u,...
                        NbOndes,Ondes,T0,fichierE,fichierS,0);
else
    HarmoniqueMoyU=[];
end

%% Vitesse V :  
if (size(find(isnan(VitMoy.v)==0),1)>1)
    HarmoniqueMoyV=DefHarmonique(Jour,Heure,VitMoy.v,...
                        NbOndes,Ondes,T0,fichierE,fichierS,0);
else
    HarmoniqueMoyV=[];
end


%% Vitesse U_proj :  
if (size(find(isnan(VitMoy_proj.u)==0),1)>1)
    HarmoniqueMoyU_proj=DefHarmonique(Jour,Heure,VitMoy_proj.u,...
                        NbOndes,Ondes,T0,fichierE,fichierS,0);
else
    HarmoniqueMoyU_proj=[];
end


%% Vitesse V_proj :  
if (size(find(isnan(VitMoy_proj.v)==0),1)>1)
    HarmoniqueMoyV_proj=DefHarmonique(Jour,Heure,VitMoy_proj.v,...
                        NbOndes,Ondes,T0,fichierE,fichierS,0);
else
    HarmoniqueMoyV_proj=NaN;
end



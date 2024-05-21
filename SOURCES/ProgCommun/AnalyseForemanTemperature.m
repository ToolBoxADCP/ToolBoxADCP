%% Choix de Ondes
Ondes=ChoixOndes(NbOndes);

%% Creation du fichier à lire par Foreman
t=(datum_str(Temps));% en jour
Jour=floor(t)-T0;Heure=(t-Jour-T0)*24;
fichierE=['TempE'];
fichierS=['TempS'];

clear HarmoniqueTemperature 
if (strcmp(NomTemp,'Non  ')==0)
     [HarmoniqueTemperature]=DefHarmonique(Jour,Heure,Temperature,...
          NbOndes,Ondes,T0,fichierE,fichierS,1);
else
    HarmoniqueTemperature=[];
end

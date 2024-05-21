legendOn=1;
%% DESSIN POUR TOUS LES MOIS
%% Recherche des différents Mois
SepareMois


%% Plot
fichMouillage='.\DessinRobert\Temperature\Plot\';
dirMouillage='.\DessinRobert\Temperature\Plot';
[a,b]=mkdir (dirMouillage);

mois=0;
    Umoy=0;
for ind=PremMes.month:DerMes.month
    mois=mois+1;
    Tmes=datum_str(DebDessin(mois))-1;
    T_fin=datum_str(FinDessin(mois))-Tmes;
    for i = 1:size(Nom,1);
       DonneesCampagne(Nom(i,:));Nom(i,:)
       load(TemperaturePropre)
       time1=(datum_str(Temps)-Tmes);
       ii=find(time1<T_fin & time1>1);
       if(isempty(ii)==0)
         if (strcmp(NomTemp,'Non   ')==0)
             signe=1;
            Ymin=21.5;Ymax=29;
            Ymin_res=-2;Ymax_res=2;
            load(TemperaturePropre)
            load(TemperatureAnalyse)
            Harm=HarmoniqueTemperature;vit=(Temperature);DessNom='Temperature';
            DessResVitPlot
         end
         %pause
       end
    end
end


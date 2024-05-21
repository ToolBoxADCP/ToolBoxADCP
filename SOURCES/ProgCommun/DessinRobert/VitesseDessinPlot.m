fichMouillage='./DessinRobert/PlotVitesse/';
dirMouillage='./DessinRobert/PlotVitesse';
[a,b]=mkdir (dirMouillage);
NbNiv=3;

%% Recherche des diff�rents Mois
SepareMois


%% Plot
mois=0;
for ind=PremMes.month:PremMes.month+NbMois
    mois=mois+1;
    Tmes=datum_str(DebDessin(mois))-1;
    T_fin=datum_str(FinDessin(mois))-Tmes;
    for i = 1:size(Nom,1);
       DonneesCampagne(Nom(i,:));
       load(MouillagePropre)
       load(MouillageAnalyse)
       time1=(datum_str(Temps)-Tmes);
       ii=find(time1<T_fin & time1>1);
       if(isempty(ii)==0)
           
         NivMax=MaxProf(Nom(i,:));
         vit=vitesse.u; harm=HarmoniqueU;  DessNom='U';VitPlot
         vit=vitesse.v; harm=HarmoniqueV;  DessNom='V';VitPlot
  
         load(MouillagePropre_proj)
         load(MouillageAnalyse_proj)
         vit=vitesse.u; harm=HarmoniqueU;  DessNom='Uproj';VitPlot
         vit=vitesse.v; harm=HarmoniqueV;  DessNom='Uortho';VitPlot
       end
    end
end
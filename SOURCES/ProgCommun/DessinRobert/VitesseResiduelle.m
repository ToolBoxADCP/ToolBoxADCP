fichMouillage='./DessinRobert/VitessesResiduelles/';
dirMouillage='./DessinRobert/VitessesResiduelles';
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
       load(MouillageAnalyse)
       time1=((HarmoniqueU(1).temps/24+T0)-Tmes);
       ii=find(time1<T_fin & time1>1);
       if(isempty(ii)==0)
         Harm=HarmoniqueU;DessNom='U';DessRes
         Harm=HarmoniqueV;DessNom='V';DessRes
       load(MouillageAnalyse_proj)
         Harm=HarmoniqueU;DessNom='Uproj';DessRes
         Harm=HarmoniqueV;DessNom='Uortho';DessRes
       end
    end
end
%% Choix de Ondes
Ondes=ChoixOndes(NbOndes);

%% Creation du fichier à lire par Foreman
Jour=floor(time1);Heure=(time1-Jour)*24;
fichierE=['TempE'];
fichierS=['TempS'];

clear Harmonique HarmoniqueU HarmoniqueV
Nom(i,:),N=MaxProf(Nom(i,:));    
Hcellule=NaN*ones(1,N);

%% Vitesse U : Pour chaque niveau on execute Foreman 
      courant=[Jour Heure Umoy_];
      save(fichierE,'courant')
      HarmoniqueU_glis=DefHarmonique(NbOndes,Ondes,T0,fichierE,fichierS,1);

%% Plot
fichMouillage='.\DessinRobert\VitesseMoyenne\Plot\';
mois=0;
    
for ind=PremMes.month:DerMes.month
    mois=mois+1;
    Tmes=datum_str(DebDessin(mois))-1;
    T_fin=datum_str(FinDessin(mois))-Tmes;
    for i = 1:size(Nom,1);
       DonneesCampagne(Nom(i,:));
       load(MouillageMoy)
       time1=(datum_str(Temps)-Tmes);
       ii=find(time1<T_fin & time1>1);
       if(isempty(ii)==0)
         Ymin=VitMin;Ymax=VitMax;
         NbNiv=1;
         Harm=HarmoniqueU_glis;vit=Umoy_+Umoy;DessNom='U';
         signe=1;
         DessResVitPlot
       end
    end
end

%% Recherche des diff�rents Mois
SepareMois

%% Dessins tous les mois, mouillage apr�s mouillage 
for i = 1:size(Nom,1);
  Nom(i,:),DonneesCampagne(Nom(i,:))
  load(MouillagePropre_proj);vitesse_proj=vitesse;
  load(MouillagePropre)
  if (MaxProf(Nom(i,:))>1);
      mois=0;
      for ind=PremMes.month:PremMes.month+NbMois
          mois=mois+1;
        Tmes=datum_str(DebDessin(mois))-1;
        time1=(datum_str(Temps)-Tmes);
        T_fin=datum_str(FinDessin(mois))-Tmes;

        ii=find(time1<T_fin & time1>1);
        if(isempty(ii)==0)
            Pcol
            Stick

        end
      end
  end
end


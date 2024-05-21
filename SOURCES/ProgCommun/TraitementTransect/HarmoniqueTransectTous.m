for index_nom = 1:size(Nom,1);
  Nom(index_nom,:)
  
  close all
  DonneesCampagne(Nom(index_nom,:))
  HarmoniqueTransect
end

for index_nom = 1:size(Nom,1);
   DonneesCampagne(Nom(index_nom,:))
   DessinHarmoniqueTransect
end
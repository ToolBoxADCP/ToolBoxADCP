
for i = 1:size(Nom,1);
  Nom(i,:)
  close all
  DonneesCampagne(Nom(i,:))
  AnalyseMouillage         % Calcul  Harmonique (avec calcul des harmoniques par moindre carré), ellipse et la dir princ à chaque niveau  
  VitesseProj_surEllipse   % Calcul la proj sur la direction moyennée sur la verticale
  AnalyseMouillage_proj
end

for i = 2:size(Nom,1);
  Nom(i,:)
  load (MouillageAnalyse)
  nanmean(abs(HarmoniqueH.res))
end

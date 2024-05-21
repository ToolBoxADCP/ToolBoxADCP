for i = 1:size(Nom,1);
  Nom(i,:)
  
  close all
  DonneesCampagne(Nom(i,:))
  AnalyseForemanMouillage
  VitesseProj_surEllipse
  AnalyseForemanMouillage_proj
 %pause
end

disp('R�siduelle Niveau - Niveau moyen')
for i = 1:size(Nom,1);
   DonneesCampagne(Nom(i,:))
  if (strcmp(FichPression,'Non  ')==0),
   load (MouillageAnalyse)
   nanmean(abs(HarmoniqueH.res))
  end
end

%% 04.67.14.84.98
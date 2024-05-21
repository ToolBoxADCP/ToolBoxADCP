clf,
for i = 1:size(Nom);
   Nom(i,:);  DonneesCampagne(Nom(i,:))
   hold on%subplot(4,1,i)
   if (strcmp(NomTemp,'Non   ')==0)
        Nom(i,:)
     form_Temp
     xlabel(Nom(i,:))
     AnalyseForemanTemperature
     save (TemperatureAnalyse,'Temps','HarmoniqueTemperature')
   end
end
DessinTemperature
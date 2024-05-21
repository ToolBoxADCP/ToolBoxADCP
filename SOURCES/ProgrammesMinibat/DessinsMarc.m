
close all,clear all
DossierMarc='Dessins/DossierMarc/';[a,b]=mkdir(DossierMarc);
load DonneesTransect

for NumTrans = 1:size(TransectData,2)
  indTrans =TransectData(NumTrans).indTrans
  JourTransect = TransectData(NumTrans).JourTransect
  
  figure,plot(TransectPoint(indTrans).d,nanmean(TransectData(NumTrans).Temperature))
      title(['Temperature Moyenne, transect ' num2str(indTrans) ' le :' ...
            num2str(JourTransect)])
        xlabel('Distance')
        ylabel('Temperature')
        Fich=[DossierMarc 'TemperatureMoyenne' num2str(indTrans) 'Jour' ...
            num2str(JourTransect)];
            saveas(gcf,Fich,'fig')
            saveas(gcf,Fich,'png')          
  
   figure,plot(TransectPoint(indTrans).d,max(TransectData(NumTrans).Temperature))
      title(['Temperature Maximale, transect ' num2str(indTrans) ' le :' ...
            num2str(JourTransect)])
        xlabel('Distance')
        ylabel('Temperature')
        Fich=[DossierMarc 'TemperatureMax' num2str(indTrans) 'Jour' ...
            num2str(JourTransect)];
            saveas(gcf,Fich,'fig')
            saveas(gcf,Fich,'png')          
  
  figure,plot(TransectPoint(indTrans).d,nanmean(TransectData(NumTrans).Salinite))
      title(['Salinite Moyenne, transect ' num2str(indTrans) ' le :' ...
            num2str(JourTransect)])
        xlabel('Distance')
        ylabel('Salinite')
        Fich=[DossierMarc 'SaliniteMoyenne' num2str(indTrans) 'Jour' ...
            num2str(JourTransect)];
            saveas(gcf,Fich,'fig')
            saveas(gcf,Fich,'png')          
  
   figure,plot(TransectPoint(indTrans).d,max(TransectData(NumTrans).Salinite))
      title(['Salinite Maximale, transect ' num2str(indTrans) ' le :' ...
            num2str(JourTransect)])
        xlabel('Distance')
        ylabel('Salinite')
        Fich=[DossierMarc 'SaliniteMax' num2str(indTrans) 'Jour' ...
            num2str(JourTransect)];
            saveas(gcf,Fich,'fig')
            saveas(gcf,Fich,'png')          
  
  figure,plot(TransectPoint(indTrans).d,nanmean(TransectData(NumTrans).Fluorimetrie))
      title(['Fluorimetrie Moyenne, transect ' num2str(indTrans) ' le :' ...
            num2str(JourTransect)])
        xlabel('Distance')
        ylabel('Fluorimetrie')
        Fich=[DossierMarc 'FluorimetrieMoyenne' num2str(indTrans) 'Jour' ...
            num2str(JourTransect)];
            saveas(gcf,Fich,'fig')
            saveas(gcf,Fich,'png')          
  
   figure,plot(TransectPoint(indTrans).d,max(TransectData(NumTrans).Fluorimetrie))
      title(['Fluorimetrie Maximale, transect ' num2str(indTrans) ' le :' ...
            num2str(JourTransect)])
        xlabel('Distance')
        ylabel('Fluorimetrie')
        Fich=[DossierMarc 'FluorimetrieMax' num2str(indTrans) 'Jour' ...
            num2str(JourTransect)];
            saveas(gcf,Fich,'fig')
            saveas(gcf,Fich,'png')          
  
  figure,plot(TransectPoint(indTrans).d,nanmean(TransectData(NumTrans).Turbidite))
      title(['Turbidite Moyenne, transect ' num2str(indTrans) ' le :' ...
            num2str(JourTransect)])
        xlabel('Distance')
        ylabel('Turbidite')
        Fich=[DossierMarc 'TurbiditeMoyenne' num2str(indTrans) 'Jour' ...
            num2str(JourTransect)];
            saveas(gcf,Fich,'fig')
            saveas(gcf,Fich,'png')          
  
   figure,plot(TransectPoint(indTrans).d,max(TransectData(NumTrans).Turbidite))
      title(['Turbidite Maximale, transect ' num2str(indTrans) ' le :' ...
            num2str(JourTransect)])
        xlabel('Distance')
        ylabel('Turbidite')
        Fich=[DossierMarc 'TurbiditeMax' num2str(indTrans) 'Jour' ...
            num2str(JourTransect)];
            saveas(gcf,Fich,'fig')
            saveas(gcf,Fich,'png')          
   
   figure,plot(TransectPoint(indTrans).d,nanmean(TransectData(NumTrans).Densite))
      title(['Densite Moyenne, transect ' num2str(indTrans) ' le :' ...
            num2str(JourTransect)])
        xlabel('Distance')
        ylabel('Densite')
        Fich=[DossierMarc 'DensiteMoyenne' num2str(indTrans) 'Jour' ...
            num2str(JourTransect)];
            saveas(gcf,Fich,'fig')
            saveas(gcf,Fich,'png')          
  
   figure,plot(TransectPoint(indTrans).d,max(TransectData(NumTrans).Densite))
      title(['Densite Maximale, transect ' num2str(indTrans) ' le :' ...
            num2str(JourTransect)])
        xlabel('Distance')
        ylabel('Densite')
        Fich=[DossierMarc 'DensiteMax' num2str(indTrans) 'Jour' ...
            num2str(JourTransect)];
            saveas(gcf,Fich,'fig')
            saveas(gcf,Fich,'png')          
  

end

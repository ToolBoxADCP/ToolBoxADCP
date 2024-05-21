     [a,b]=mkdir(['DessinProfils']);
%close all
figure(1) 
subplot(1,2,1),plot(Salinite,-Pression)
 title([{'Salinite'} Fichier])
 subplot(1,2,2),plot(Temperature,-Pression)
 title([{'Temperature'} Fichier])
     fichM=['DessinProfils/SalTemp1_' Fichier(1:end-4)];
    saveas(gcf,fichM,'fig')
%     saveas(gcf,fichM,'png') 
    
figure(2) 
 ii=find(Pression>=0);
 subplot(1,2,1),plot(Salinite(ii),-Pression(ii))
 title([{'Salinite'} Fichier])
 subplot(1,2,2),plot(Temperature(ii),-Pression(ii))
 title([{'Temperature'} Fichier])

     fichM=['DessinProfils/SalTemp2_' Fichier(1:end-4)];
    saveas(gcf,fichM,'fig')
%     saveas(gcf,fichM,'png')

figure(3) 
subplot(1,2,1),plot(Fluorimetrie,-Pression)
 title([{'Fluorimetrie'} Fichier])
 subplot(1,2,2),plot(Turbidite,-Pression)
 title([{'Turbidite'} Fichier])
     fichM=['DessinProfils/FluoTurb1_' Fichier(1:end-4)];
    saveas(gcf,fichM,'fig')
%     saveas(gcf,fichM,'png') 
    
figure(4) 
 ii=find(Pression>=0);
 subplot(1,2,1),plot(Fluorimetrie(ii),-Pression(ii))
 title([{'Fluorimetrie'} Fichier])
 subplot(1,2,2),plot(Turbidite(ii),-Pression(ii))
 title([{'Turbidite'} Fichier])

     fichM=['DessinProfils/FluoTurb2_' Fichier(1:end-4)];
    saveas(gcf,fichM,'fig')
%     saveas(gcf,fichM,'png')

%Parametre=Salinite;NomDossier='Salinite';ColGlob=linspace(45,39,10);
%Parametre=Temperature; NomDossier='Temperature';ColGlob=linspace(27.,26.5,10);
%Parametre=Fluorimetrie; NomDossier='Fluorimetre';ColGlob=linspace(2.,0,10);

     DossierDessin=['Dessins/DessinTransect_' NomDossier];
     [a,b]=mkdir(DossierDessin);

     figure(4)
     plot(Parametre,-Pression,'.')
        fichM=[DossierDessin '/TPression_' Fichier(1:end-4)];
        saveas(gcf,fichM,'fig')
%         saveas(gcf,fichM,'png')

    figure(2)
        fichM=[DossierDessin '/ParametreT_' Fichier(1:end-4)];
        plot(T_Heure,Parametre,'.')
        saveas(gcf,fichM,'fig')
%         saveas(gcf,fichM,'png')

    figure(3),clf
    Dessin2DV
        fichM=[DossierDessin '/2DV_' Jour];
        saveas(gcf,fichM,'fig')
%         saveas(gcf,fichM,'png')
    
    figure(4),clf
    FichInt=Fichier(1:end-4);
    Dessin2DVbis
%         fichM=[DossierDessin '/2DVbis_' Jour];
    figure(4),
        fichM=[DossierDessin '/2DVbis_' Fichier(1:end-4)];
        saveas(gcf,fichM,'fig')
%         saveas(gcf,fichM,'png')
    
    figure (1),clf,
    Dessin2DH
%         fichM=[DossierDessin '/2DH_' Jour];
        fichM=[DossierDessin '/2DH_' Fichier(1:end-4)];
        saveas(gcf,fichM,'fig')
%         saveas(gcf,fichM,'png')
    
    %disp('Appuyer sur une touche ...'),pause


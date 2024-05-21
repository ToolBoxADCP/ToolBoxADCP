% Carte:
   Initialisation
   dessinPhotoTulearInit;
   clear Trajet

  load DataProfil
%      DossierDessin=['DessinCompilTransect_' NomDossier];
%      [a,b]=mkdir(DossierDessin);
close all
%% Dessins Récapitulatif sur l'ensemble de la campagne
figure(1)
    Parametre=DataTot.Temperature; NomDossier='Temperature';ColGlob=linspace(.5,0,10);
    DessinsDataCompil
    Parametre=DataTot.Salinite; NomDossier='Salinite';ColGlob=linspace(.5,0,10);
    DessinsDataCompil
    Parametre=DataTot.Turbidite; NomDossier='Turbidite';ColGlob=linspace(.5,0,10);
    DessinsDataCompil
    Parametre=DataTot.Fluorimetrie; NomDossier='Fluorimetrie';
    DessinsDataCompil

    
%     fichM=[DossierDessin '/BilanSalinite'];
%     saveas(gcf,fichM,'fig')
%     saveas(gcf,fichM,'png')

%% Dessins Transect par transect
DT=diff(T_Data);
iiTr=find(DT>DTmax/24);iiTr=[0;iiTr;size(T_Data,1)];
for ind=1:size(iiTr,1)-1;
    T_Heure=(T_Data(iiTr(ind)+1:iiTr(ind+1))-floor(T_Data(iiTr(ind)+1)))*24;
    Pression=DataTot.Pression(iiTr(ind)+1:iiTr(ind+1));
    Jour=datestr(datenum(tempsData.year(iiTr(ind)+1),...
                tempsData.month(iiTr(ind)+1),tempsData.day(iiTr(ind)+1)))
    Lon=PositionData.lon(iiTr(ind)+1:iiTr(ind+1));
    Lat=PositionData.lat(iiTr(ind)+1:iiTr(ind+1));
    Trajet(ind).Jour=Jour;
    Trajet(ind).Lon=Lon;
    Trajet(ind).Lat=Lat;
    NomDossier='Temperature';
    Parametre=DataTot.Temperature(iiTr(ind)+1:iiTr(ind+1));
    DossierDessin=['Dessins/DessinCompilTransect_' NomDossier];
    [a,b]=mkdir(DossierDessin);
    figure(1),clf
    Dessin2DV
        fichM1=[DossierDessin '/2DV_' Jour '_' num2str(ind)];

    figure(2),clf
    FichInt=['_' num2str(ind)];;
    Dessin2DVbis
        fichM2=[DossierDessin '/2DVbis_' Jour  '_' num2str(ind)];

    figure(3),clf
    Dessin2DH
        fichM3=[DossierDessin '/2DH_' Jour '_' num2str(ind) ];
    
    NomDossier='Salinite';
    Parametre=DataTot.Salinite(iiTr(ind)+1:iiTr(ind+1));
    DossierDessin=['Dessins/DessinCompilTransect_' NomDossier];
    [a,b]=mkdir(DossierDessin);
    figure(4),clf
    Dessin2DV
        fichM4=[DossierDessin '/2DV_' Jour '_' num2str(ind) ];

        figure(5),clf
    FichInt=['_' num2str(ind)];;
    Dessin2DVbis
        fichM5=[DossierDessin '/2DVbis_' Jour '_' num2str(ind) ];
%     figure(18),
%         fich=[DossierDessin '/2DH_Moy_' Jour '_' num2str(ind)];
%         saveas(gcf,fich,'fig')
%     figure(16),
%         fich=[DossierDessin '/2DH_Max_' Jour '_' num2str(ind)];
%         saveas(gcf,fich,'fig')

        figure(6),clf
    Dessin2DH
        fichM6=[DossierDessin '/2DH_' Jour  '_' num2str(ind)];
    
    NomDossier='Fluorimetrie';
    Parametre=DataTot.Fluorimetrie(iiTr(ind)+1:iiTr(ind+1));
    DossierDessin=['Dessins/DessinCompilTransect_' NomDossier];
    [a,b]=mkdir(DossierDessin);
    figure(7),clf
    Dessin2DV
        fichM7=[DossierDessin '/2DV_' Jour '_' num2str(ind) ];

        figure(8),clf
    FichInt=['_' num2str(ind)];;
    Dessin2DVbis
        fichM8=[DossierDessin '/2DVbis_' Jour  '_' num2str(ind)];
%     figure(18),
%         fich=[DossierDessin '/2DH_Moy_' Jour '_' num2str(ind)];
%         saveas(gcf,fich,'fig')
%     figure(16),
%         fich=[DossierDessin '/2DH_Max_' Jour '_' num2str(ind)];
%         saveas(gcf,fich,'fig')

        figure(9),clf
    Dessin2DH
    title([NomDossier ' le ' Jour])
        fichM9=[DossierDessin '/2DH_' Jour  '_' num2str(ind)];

    NomDossier='Turbidite';
    Parametre=DataTot.Turbidite(iiTr(ind)+1:iiTr(ind+1));
    DossierDessin=['Dessins/DessinCompilTransect_' NomDossier];
    [a,b]=mkdir(DossierDessin);
    figure(10),clf
    Dessin2DV
        fichM10=[DossierDessin '/2DV_' Jour  '_' num2str(ind)];

        figure(11),clf
    FichInt=['_' num2str(ind)];;
    Dessin2DVbis
        fichM11=[DossierDessin '/2DVbis_' Jour '_' num2str(ind)];
%     figure(18),
%         fich=[DossierDessin '/2DH_Moy_' Jour '_' num2str(ind)];
%         saveas(gcf,fich,'fig')
%     figure(16),
%         fich=[DossierDessin '/2DH_Max_' Jour '_' num2str(ind)];
%         saveas(gcf,fich,'fig')

        figure(12),clf
    Dessin2DH
        fichM12=[DossierDessin '/2DH_' Jour '_' num2str(ind)];
 
    NomDossier='Densite';
    Parametre=CalculDensite(DataTot.Salinite(iiTr(ind)+1:iiTr(ind+1)),...
                            DataTot.Temperature(iiTr(ind)+1:iiTr(ind+1)));
    DossierDessin=['Dessins/DessinCompilTransect_' NomDossier];
    [a,b]=mkdir(DossierDessin);
    figure(13),clf
    Dessin2DV
        fichM13=[DossierDessin '/2DV_' Jour '_' num2str(ind)];

        figure(14),clf
    FichInt=['_' num2str(ind)];;
    Dessin2DVbis
        fichM14=[DossierDessin '/2DVbis_' Jour '_' num2str(ind)];
%     figure(18),
%         fich=[DossierDessin '/2DH_Moy_' Jour '_' num2str(ind)];
%         saveas(gcf,fich,'fig')
%     figure(16),
%         fich=[DossierDessin '/2DH_Max_' Jour '_' num2str(ind)];
%         saveas(gcf,fich,'fig')

        figure(15),clf
    Dessin2DH
        fichM15=[DossierDessin '/2DH_' Jour '_' num2str(ind)];
 
    for fig=1:15
        figure(fig),saveas(gcf,eval(['fichM' num2str(fig)]),'fig')
    end
    for fig=1:15
%         figure(fig),saveas(gcf,eval(['fichM' num2str(fig)]),'png')
    end
close all
end
for ind=1:size(iiTr,1)-1;
    T_Heure=(T_Data(iiTr(ind)+1:iiTr(ind+1))-floor(T_Data(iiTr(ind)+1)))*24;
    Pression=DataTot.Pression(iiTr(ind)+1:iiTr(ind+1));
    Lon=PositionData.lon(iiTr(ind)+1:iiTr(ind+1));
    Lat=PositionData.lat(iiTr(ind)+1:iiTr(ind+1));
    Jour=datestr(datenum(tempsData.year(iiTr(ind)+1),...
                tempsData.month(iiTr(ind)+1),tempsData.day(iiTr(ind)+1)))

    Parametre=DataTot.Temperature(iiTr(ind)+1:iiTr(ind+1));
    DossierDessin=['Dessins/DessinTemperatureHeure_'];
    [a,b]=mkdir(DossierDessin);
    figure(1),clf
    DessinTemperatureHeure
 
close all
end

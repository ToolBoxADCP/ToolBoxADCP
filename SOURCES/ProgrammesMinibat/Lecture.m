Initialisation
dessinPhotoTulearInit
      tempsData.year=[];
      tempsData.month=[];
      tempsData.day=[];
      tempsData.hour=[];
      tempsData.minute=[];
      tempsData.seconde=[];
      PositionData.lat=[];
      PositionData.lon=[];
      DataTot.Salinite=[];
      DataTot.Temperature=[];
      DataTot.Fluorimetrie=[];
      DataTot.Turbidite=[];
      DataTot.Pression=[];
close all

%% Lecture des positions des transects
if(carte==1)
    open Bathy.fig
end
% figure(1),clf,figure(2),clf
%pause
LectureT
if (size(Fich,1)~=0)
    if(Illisible==1)
        LectureTransectIllisible
    end
    TriTransect

    %% Lecture des données
    LectureFichiersData
    %pause
    close all
    if(carte==1)
        open Bathy.fig
    end
    LegendPoint
    for IndexFich=1:size(Fich,1)
        IndexFich
        Fichier=[cell2mat(Fich(IndexFich))];
        LectureData
        %Jour=mat2str(floor(T(1)-datenum(temps.year(1),1,1)+1));
        Jour=datestr(datenum(temps.year(1),...
                    temps.month(1),temps.day(1)))
        Parametre=Temperature; NomDossier='Temperature';ColGlob=linspace(.5,0,10);
        DessinsData
        Parametre=Salinite; NomDossier='Salinite';ColGlob=linspace(.5,0,10);
        DessinsData
        Parametre=Turbidite; NomDossier='Turbidite';ColGlob=linspace(.5,0,10);
        DessinsData
        Parametre=Fluorimetrie; NomDossier='Fluorimetrie';ColGlob=linspace(.5,0,10);
        DessinsData
        %pause
        ConcatenerData
    end
    NettoieConcatenerData
end

if(Profil==1)
    LectureProfils
end

if(CTD==1)
    LectureCTD
end

if(ODV==1)
    LectureODV
end

DessinCompil


figure
if(exist('TempsPosition','var')==1)
    plot(TempsPosition.hour+TempsPosition.minute/60+TempsPosition.seconde/3600,TempsPosition.day,'.b')
    hold on
    plot(tempsData.hour+tempsData.minute/60+tempsData.seconde/3600,tempsData.day,'.r')
    xlabel('Heure'),ylabel('Jour'),legend('Transects Localisation','Transect Donnees')
    axis([0 24 0 31])
    DossierDessin=['Dessins/'];
    [a,b]=mkdir(DossierDessin);
    fichM=[DossierDessin 'BilanMesureTransects'];
    saveas(gcf,fichM,'fig')
    saveas(gcf,fichM,'png')
end
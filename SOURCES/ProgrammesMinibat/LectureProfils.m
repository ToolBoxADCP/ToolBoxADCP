%      tempsData.year=[];
%      tempsData.month=[];
%      tempsData.day=[];
%      tempsData.hour=[];
%      tempsData.minute=[];
%      tempsData.seconde=[];
%      PositionData.lat=[];
%      PositionData.lon=[];
%      DataTot.Salinite=[];
%      DataTot.Temperature=[];
%      DataTot.Turbidite=[];
%      DataTot.Fluorimetrie=[];
%      DataTot.Pression=[];

LectureFichiersProfils
for IndexFich=1:size(PositionFichier.Nom,1)
    Fichier=[cell2mat(PositionFichier.Nom(IndexFich))]
    Lon0=PositionFichier.Lon(IndexFich);Lat0=PositionFichier.Lat(IndexFich);

    LectureDataProfil
    DessinsProfils
    ConcatenerData
    %pause
end
NettoieConcatenerData

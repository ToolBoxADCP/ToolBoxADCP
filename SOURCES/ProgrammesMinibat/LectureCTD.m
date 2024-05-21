LectureFichiersCTD
for IndexFich=1:size(Fich,1)
    Fichier=[cell2mat(Fich(IndexFich))]
    LectureDataCTD
    DessinsProfils
    ConcatenerData
    %pause
end
NettoieConcatenerData

LectureFichiersODV
for IndexFich=1:size(Fich,1)
    Fichier=[cell2mat(Fich(IndexFich))]
    LectureDataODV
    DessinsProfils
    ConcatenerData
    %pause
end
NettoieConcatenerData

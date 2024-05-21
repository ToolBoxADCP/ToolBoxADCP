      tempsTot.year=[];
      tempsTot.month=[];
      tempsTot.day=[];
      tempsTot.hour=[];
      tempsTot.minute=[];
      tempsTot.seconde=[];
      PositionTot.lat=[];
      PositionTot.lon=[];

LectureFichiersTransects
for IndexFich=1:size(Fich,1)
    if (IndexFich==9)
        disp('coucou')
    end
    Fichier=[cell2mat(Fich(IndexFich))]
    if (FormatNav==1)
        LectureTransects
    end
    if (FormatNav==2)
        LectureTransects2
    end
    ConcatenerTansects
    figure(1),clf
    %image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on%
    plot(Position.lon,Position.lat,'.w')
    figure(2),clf
    %image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on%
    plot(PositionTot.lon,PositionTot.lat,'.w')
%    pause
end

% 27 février et fin aout; 22 semaines mini...

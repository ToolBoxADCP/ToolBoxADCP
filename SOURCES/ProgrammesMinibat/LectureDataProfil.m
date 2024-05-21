    temp=importdata([Dossier '/' Fichier]);

    Text=temp.textdata(4:end,:);
    Data=temp.data;
    
    LectureHeure
    LectureDonnees
    
    T_=datum_str(temps)-datenum(2016,1,1)+1;
    T=(T_-floor(T_))*24;

    Lon=Lon0*ones(size(T));
    Lat=Lat0*ones(size(T));
    if size(find(isnan(Lat)==0),1)==0
        disp(Fichier)
    end

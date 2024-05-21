    temp=importdata([DossierData '/' Fichier]);


    Text=temp.textdata(4:end,:);
    Data=temp.data;
    
    %Text=temp(4:end,:);
    
    LectureHeure
    LectureDonnees
    
    
    T_=T;
    T_Heure=(T_-floor(T_(1)))*24;

    Lon=interp1(T_Position,Position.lon,T_);
    Lat=interp1(T_Position,Position.lat,T_);
    if size(find(isnan(Lat)==0),1)==0
        disp(Fichier)
    end

    %figure(3),clf,plot(Lon,Lat)temp
    
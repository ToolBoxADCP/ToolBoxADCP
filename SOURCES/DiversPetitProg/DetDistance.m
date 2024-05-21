function [d]=DetDistance;
    [Lon1,Lat1]=ginput(1);
    [Lon2,Lat2]=ginput(1);
    d=Distance(Lon1,Lat1,Lon2,Lat2);
    disp(['Distance : ' num2str(d) 'm'])
end
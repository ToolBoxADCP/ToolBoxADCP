function [I]=Transect_CalcDist(lon0,lonI,lat0,latI,Lat2Metre);
    Lon0=ones(size(lonI,2),1)*lon0;
    LonI=lonI'*ones(1,size(lon0,2));
    Lat0=ones(size(latI,2),1)*lat0;
    LatI=latI'*ones(1,size(lat0,2));
    LatMean=mean(mean(Lat0));
    dd=(sqrt((LatI-Lat0).^2 + (LonI-Lon0).^2).*cos(pi/180*(LatMean)))*Lat2Metre;
[Dmin,I]=nanmin(dd',[],1);

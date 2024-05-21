function [ M0,N0 ] = MinimiseDistance(lon,lat,Lon0,Lat0)
%Recherche le point le plus près de la source positionnée en LonSource et
%LatSource

    d=Distance(lon,lat,Lon0,Lat0);
    [M,N]=size(d);d_=reshape(d,M*N,1);
    [Dmin,I]=min(d_);
    N0=floor(I/M)+1;M0=I-(N0-1)*M;
end


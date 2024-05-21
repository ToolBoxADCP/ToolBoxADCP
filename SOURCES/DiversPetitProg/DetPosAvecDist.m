function [ Lon,Lat ] = DetPosAvecDist( Lon0,Lat0,alpha,d )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

alpha=mod(alpha,360);
if(alpha~=90 || alpha~=270)
   alpha=alpha/180*pi;
   DLon = sign(cos(alpha))*d/110000/(sqrt((cos(Lat0*pi/180)).^2+(tan(alpha)).^2));
   %DLon = sign(cos(alpha))*d/110000/(sqrt(1+(tan(alpha)).^2));
   DLat=DLon*tan(alpha);
else
    if(alpha==90)
        DLon=0;
        DLat=-d/110000;
    else
        DLon=0;
        DLat=d/110000;
    end
end 

Lon=Lon0+DLon;
Lat=Lat0+DLat;
% 
% plot(Lon0,Lat0,'or')
% hold on, plot(Lon,Lat,'.k')

end


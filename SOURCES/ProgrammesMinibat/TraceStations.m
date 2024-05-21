StationsNew

plot(Station.Lon,Station.Lat,'*g')
for indStat=1:size(Station.Lon,1)
%   plot(Station.Lon(ind),Station.Lat(ind),'*r')
clear text
   text(Station.Lon(indStat)-0.01,Station.Lat(indStat)+0.01,Station.Nom(indStat,:),...
     'BackgroundColor','k','Color','g')
end

StationsNew
Lat2Metre=110000;
pas=50; %m
TransectsPoints

for indTrans = 1:size(TransectStation,2)
        TransectPoint(indTrans).Lon=[];
        TransectPoint(indTrans).Lat=[];
        TransectPoint(indTrans).d=[];
    X0=TransectCentre(indTrans).Lon;
    Y0=TransectCentre(indTrans).Lat;
    
    D(1)=0;
    for indStat = 1:size(TransectStation(indTrans).Lon,1)-1
        X1=TransectStation(indTrans).Lon(indStat);
        Y1=TransectStation(indTrans).Lat(indStat);
        X2=TransectStation(indTrans).Lon(indStat+1);
        Y2=TransectStation(indTrans).Lat(indStat+1);
        D(indStat+1)=D(indStat)...
          + (sqrt((Y2-Y1).^2 + (X2-X1).^2)*cos(pi/180*(Y1+Y2)/2))*Lat2Metre;
        if(isnan(D(indStat+1))==1)
            [X2,Y2]
        end
    end 
    TransectStation(indTrans).D=D-D(TransectCentre(indTrans).Indice);
    
    for indStat = 1:size(TransectStation(indTrans).Lon,1)-1
        D1=TransectStation(indTrans).D(indStat);
        X1=TransectStation(indTrans).Lon(indStat);
        Y1=TransectStation(indTrans).Lat(indStat);
        D2=TransectStation(indTrans).D(indStat+1);
        X2=TransectStation(indTrans).Lon(indStat+1);
        Y2=TransectStation(indTrans).Lat(indStat+1);

        N=max(round((D2-D1)/pas),2);
        X=linspace(X1,X2,N);
        Y=linspace(Y1,Y2,N);
        D=linspace(D1,D2,N);
        TransectPoint(indTrans).Lon=[TransectPoint(indTrans).Lon X];
        TransectPoint(indTrans).Lat=[TransectPoint(indTrans).Lat Y];
        TransectPoint(indTrans).d=[TransectPoint(indTrans).d D];
        
    end 
    figure(indTrans),image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on%
    plot(TransectPoint(indTrans).Lon,TransectPoint(indTrans).Lat,'*k', ...
        'MarkerSize', 2)
    plot(TransectCentre(indTrans).Lon,TransectCentre(indTrans).Lat,'og', ...
        'MarkerSize', 2)
    Fich=[DossierTransect 'TransectTheo' num2str(indTrans)];
            saveas(gcf,Fich,'fig')
            saveas(gcf,Fich,'png')
end

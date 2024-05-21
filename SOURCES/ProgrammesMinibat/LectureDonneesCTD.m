Lon=Data(:,2);
Lat=Data(:,1);
Pression=Data(:,4); %profondeur
Temperature=Data(:,6);
Fluorimetrie=Data(:,8);
Turbidite=Data(:,9);
Salinite=Data(:,7);

    ii=find(Pression<SeuilPression);
    Pression(ii)=SeuilPression;
    Salinite(ii)=NaN;
    Fluorimetrie(ii)=NaN;
    Turbidite(ii)=NaN;
    Temperature(ii)=NaN;

    Turbidite(Turbidite<0)=NaN;
Lon=Data(:,1);
Lat=Data(:,2);
Pression=Data(:,4); %profondeur ou Data(:,5)
Temperature=Data(:,6); % et 7
Fluorimetrie=Data(:,13);
Turbidite=Data(:,12);
Salinite=Data(:,21); % et 9
Oxygene1=Data(:,10); 
Oxygene2=Data(:,11); 
Irradiance1=Data(:,14);
Irradiance2=Data(:,15); 
Densite=Data(:,23); % et 9


    ii=find(Pression<SeuilPression);
    Pression(ii)=SeuilPression;
    Salinite(ii)=NaN;
    Fluorimetrie(ii)=NaN;
    Turbidite(ii)=NaN;
    Temperature(ii)=NaN;

    Turbidite(Turbidite<0)=NaN;
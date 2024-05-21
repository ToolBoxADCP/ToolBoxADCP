SeuilPression=-0.1; SeuilMaxPression=30;
    Pression=Data(:,1);
    Temperature=Data(:,3);
    Turbidite=Data(:,4);
    Fluorimetrie=Data(:,5);
    Salinite=Data(:,6);

    ii=find(Pression<SeuilPression | Pression>SeuilMaxPression);
    Pression(ii)=SeuilPression;
    Salinite(ii)=NaN;
    Fluorimetrie(ii)=NaN;
    Turbidite(ii)=NaN;
    Temperature(ii)=NaN;

    Turbidite(Turbidite<0)=NaN;

Temperature=[];
Temps.day=[];
Temps.month=[];
Temps.year=[];
Temps.hour=[];
Temps.minute=[];
Temps.seconde=[];
if (NomADCP=='ADI   ' | NomADCP=='RDI   ')
    load (DonneesMouillage)
    %load (DonneeTemperature)
    if (size(t)==0); t=1:size(SerEmmpersec,1);end
    Temperature=AnT100thDeg(t);

    Temps.day=SerDay(t,:);
    Temps.month=SerMon(t,:);
    Temps.year=SerYear(t,:);
    Temps.hour=SerHour(t,:);
    Temps.minute=SerMin(t,:);
    Temps.seconde=SerSec(t,:);

elseif NomTemp=='Mikrel'
    end;





%     IndexFich=1;
%     Fichier=[cell2mat(Fich(IndexFich))]
     temp=importdata([DossierTransect1 '/' Fichier]);

    Text=temp.textdata(9:end,:);
    Data=temp.data;
    
    clear Temps temps Position
    for ind=1:size(Text,1)
        text=Text(ind,:);
        day=eval(cell2mat(text(2)));
        Temps(ind).year=eval(cell2mat(text(1)));
        
        jour_=datenum(Temps(ind).year,1,day);
        Temps(ind).month=eval(datestr(jour_,'mm'));
        Temps(ind).day=eval(datestr(jour_,'dd'));
        
        temp=cell2mat(text(3));
        p_=[];
        for i=1:size(temp,2)
            if(temp(i)==':')
                p_=[p_ i];
            end
        end

        Temps(ind).hour=eval(temp(:,1:p_(1)-1));
        Temps(ind).minute=eval(temp(:,p_(1)+1:p_(2)-1));
        Temps(ind).seconde=eval(temp(:,p_(2)+1:end));
        
        Position.lat(ind,1)=eval(cell2mat(text(4)))+eval(cell2mat(text(5)))/60;
        Position.lon(ind,1)=eval(cell2mat(text(7)))+eval(cell2mat(text(8)))/60;
    end
    

    for ind=1:size(Text,1)
      temps.year(ind,1)=Temps(ind).year;
      temps.month(ind,1)=Temps(ind).month;
      temps.day(ind,1)=Temps(ind).day;
      temps.hour(ind,1)=Temps(ind).hour;
      temps.minute(ind,1)=Temps(ind).minute;
      temps.seconde(ind,1)=(Temps(ind).seconde);
    end
    
T_=datum_str(temps);
if (strcmp(Campagne,'Cozomed1')==1)
    if (Temps(1).day==13)
        DecalGMT=0;
    else
        DecalGMT=0;
    end
end
T_=T_-DecalGMT/24;
    dt=mean(diff(T_));
    ii=find(diff(T_)<=dt+epsilon);ii=[ii;size(T_,1)];
    if (ii(1)~=1)
        ii=[1;ii];
    end
    ind=1:size(T_,1);T_=interp1(ind(ii),T_(ii),ind);
        
        temps.year=str2num(datestr(T_,'yyyy'));
        temps.month=str2num(datestr(T_,'mm'));
        temps.day=str2num(datestr(T_,'dd'));
        temps.hour=str2num(datestr(T_,'HH'));
        temps.minute=str2num(datestr(T_,'MM'));
        temps.seconde=str2num(datestr(T_,'SS'));
                
    T_=datum_str(temps);

    ii=find(Position.lon<LonMax & Position.lon > LonMin ...
          & Position.lat < LatMax & Position.lat > LatMin);
      
    if (size(ii,1)~=0)
         Position.lon=interp1(T_(ii),Position.lon(ii),T_);
         Position.lat=interp1(T_(ii),Position.lat(ii),T_);
         
    
        figure(1),clf,subplot(2,1,1),plot(Position.lon,Position.lat,'.')
        figure(2),clf

        ind=1:size(Position.lat,1);
        dlat=nanmean(abs(diff(Position.lat)));
        iiEnd=[0 0];
        while (size(iiEnd,1)~=0)
            ii=find(abs(diff(Position.lat))<=5*dlat);ii=[ii;size(Position.lat,1)];
            subplot(2,1,1),plot(T_(1:end-1),diff(Position.lat),'.')   
            hold on,plot(T_(ii(1:end-1)),diff(Position.lat(ii)),'.g')   
            Position.lat=interp1(T_(ii),Position.lat(ii),T_);
            dlat=nanmean(abs(diff(Position.lat)));
            iiEnd=find(abs(diff(Position.lat))>=5*dlat & dlat~=0);
        end

        dlon=nanmean(abs(diff(Position.lon)));
        iiEnd=[0 0];
        while (size(iiEnd,1)~=0)
            ii=find(abs(diff(Position.lon))<=dlon*5);ii=[ii;size(Position.lon,1)];
            subplot(2,1,2),plot(T_(1:end-1),diff(Position.lon),'.')   
            hold on,plot(T_(ii(1:end-1)),diff(Position.lon(ii)),'.r')   
            Position.lon=interp1(T_(ii),Position.lon(ii),T_);
            dlon=nanmean(abs(diff(Position.lon)));
            iiEnd=find(abs(diff(Position.lon))>=5*dlon & dlon~=0);
        end
    %hold on,plot(diff(Position.lon),'.r')   
              figure(1),subplot(2,1,2),plot(Position.lon,Position.lat,'.')
    %pause

         Position.lat=InverseLat*Position.lat;
    else
         Position.lon=[];
         Position.lat=[];
         T_=[];
         temps.year=[];
         temps.month=[];
         temps.day=[];
         temps.hour=[];
         temps.minute=[];
         temps.seconde=[];
 end

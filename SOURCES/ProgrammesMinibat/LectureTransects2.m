%     IndexFich=1;
%     Fichier=[cell2mat(Fich(IndexFich))]
    clear Temps temps Position
    
    nc=fopen([DossierTransect1 '/' Fichier]);
      c=textscan(nc,'%c %2c%2c%2c%2c%2c%2c %c%2c%5c %c%3c%5c %26c');
    fclose(nc);
      temps.year=2000+str2num(c{2});
      temps.month=str2num(c{3});
      temps.day=str2num(c{4});
      temps.hour=str2num(c{5});
      temps.minute=str2num(c{6});
      temps.seconde=str2num(c{7});
      Position.lat=str2num(c{9})+str2num(c{10})/1000/60;
      Position.lon=str2num(c{12})+str2num(c{13})/1000/60;
    
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
        if(strcmp(Fichier,'Merite-J2')==0);
            disp('Je traite les coordonnees si elles ne sont pas bonnes ... ')
            disp('...Ca peut etre long')
            disp('Latitude ... ')
            while (size(iiEnd,1)~=0)
                ii=find(abs(diff(Position.lat))<=5*dlat);ii=[ii;size(Position.lat,1)];
                subplot(2,1,1),plot(T_(1:end-1),diff(Position.lat),'.')   
                hold on,plot(T_(ii(1:end-1)),diff(Position.lat(ii)),'.g')   
                Position.lat=interp1(T_(ii),Position.lat(ii),T_);
                dlat=nanmean(abs(diff(Position.lat)));
                iiEnd=find(abs(diff(Position.lat))>=5*dlat & dlat~=0);
            end

            disp('Longitude ... ')
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
            disp('Coordonnees traitees ... ')
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

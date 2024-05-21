tn14=101:212; ts14=280:328; tb15=126:366; tn18=82:276; ts21=100:151; tb21=169:234; tn21=6:85;  tb22=84:208; ts22=67:138;
% if(strcmp(GPS_Transect(1,:),'./GPS_Transect/GPS_TS14.txt')==1)
%       GPS_TS14=load (GPS_Transect(1,:));Nb14=size(GPS_TS14,1);
%       GPS_TS21=load (GPS_Transect(2,:));Nb21=size(GPS_TS21,1);
%       GPS_TS22=load (GPS_Transect(3,:));Nb22=size(GPS_TS22,1);
%       GBmin=[62;Nb14+1;Nb14+Nb21+1];
%       GBmax=[Nb14;Nb21+Nb14-23;Nb22+Nb21+Nb14-150];
%       TBmin=[min(ts14);min(ts21);min(ts22)];
%       TBmax=[max(ts14);max(ts21);max(ts22)];
%     for nb=1:size(Jfile,1)
%       GPS_borne(nb).min=GBmin(nb);
%       GPS_borne(nb).max=GBmax(nb);
%       Trans_borne(nb).min=TBmin(nb);
%       Trans_borne(nb).max=TBmax(nb);
%       save (BorneTransect, 'GPS_borne','Trans_borne')
%     end
% end
         figure(ind+1),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,%axis(axe)
         hold on
         plot(fGPS.long(b1i:b2i),-fGPS.lat(b1i:b2i),c(ind,:))
         plot(PositionMouillage.long,PositionMouillage.lat,'+w')

% if(strcmp(GPS_Transect(1,:),'./GPS_Transect/GPS_TS14.txt')==1)
%       GPS_TN14=load (GPS_Transect(1,:));Nb14=size(GPS_TN14,1);
%       GPS_TN18=load (GPS_Transect(2,:));Nb18=size(GPS_TN18,1);
%       GPS_TN21=load (GPS_Transect(3,:));Nb21=size(GPS_TN21,1);
%       GBmin=[62;Nb14+1;Nb14+Nb21+1];
%       GBmax=[Nb14;Nb21+Nb14-23;Nb22+Nb21+Nb14-150];
%       TBmin=[min(ts14);min(ts21);min(ts22)];
%       TBmax=[max(ts14);max(ts21);max(ts22)];
%     for nb=1:size(Jfile,1)
%       GPS_borne(nb).min=GBmin(nb);
%       GPS_borne(nb).max=GBmax(nb);
%       Trans_borne(nb).min=TBmin(nb);
%       Trans_borne(nb).max=TBmax(nb);
%       save (BorneTransect, 'GPS_borne','Trans_borne')
%     end
% end

% if(strcmp(GPS_Transect(1,:),'./GPS_Transect/GPS_TS14.txt')==0)
load (BorneGPS)
load (GPS_Donnees)
T_GPS=datum_str(TempsGPS)-T0;
    for nb=1:size(Jfile,1)
       [Temps ,vitesse,depth]=lecture(Jfile(nb,:),1,0,sens(nb),BottomTrack(nb));
       t=datum_str(Temps)-T0;
       figure(ind+1),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,%axis(axe)
       hold on
       for nbGPS=1:size(borne,2)
          tGPS=T_GPS(borne(nbGPS).min:borne(nbGPS).max);
          tGPSmin=min(tGPS);tGPSmax=max(tGPS);
          ii=find(t>tGPSmin & t<tGPSmax);
          max(t),min(t),tGPSmin,tGPSmax
          if (size(ii,1)~=0)
              nb,nbGPS
              Trans_borne(nb).min=min(ii);
              Trans_borne(nb).max=max(ii);
              GPS_borne(nb)=borne(nbGPS);
        plot(fGPS.long(borne(nbGPS).min:borne(nbGPS).max),-fGPS.lat(borne(nbGPS).min:borne(nbGPS).max),c(ind,:))
        plot(PositionMouillage.long,PositionMouillage.lat,'+w')
         end
       end
       pause
    end
    
    save (BorneTransect, 'GPS_borne','Trans_borne')
% end


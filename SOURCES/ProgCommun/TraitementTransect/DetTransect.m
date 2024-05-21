borne=[];
c=['.m';'.g';'.r';'.b';'.k';'.c';'.y';'om';'og';'or';'ob';'ok';'oc';'oy'];
figure(1),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on
figure(2),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on
ind=1;
Te=[];
for i=1:size(GPS_Transect,1)
 Te_i=load (GPS_Transect(i,:));
 if(size(Te_i,2)<17)
    Te_i=[Te_i NaN*ones(size(Te_i,1),17-size(Te_i,2))];
 end     
 Te=[Te;Te_i];

end

 GPS.long= Te(:,3)+ Te(:,4)/60;           %longitude
 GPS.lat= Te(:,1)+ Te(:,2)/60;            %latitude

 TempsGPS.year=Te(:,7)-2000;
 TempsGPS.month=Te(:,6);
 TempsGPS.day=Te(:,5);
 TempsGPS.hour=Te(:,8);
 TempsGPS.minute=Te(:,9);
 TempsGPS.seconde=Te(:,10);
 
 DepthGPS=Te(:,11);
 SpeedGPS.int=Te(:,16);
     ii=find(SpeedGPS.int==0);
     if(size(ii,1)==size(SpeedGPS.int,1))
         SpeedGPS.int=SpeedGPS.int+3;
     end
 SpeedGPS.dir=Te(:,17);
 
 t=datum_str(TempsGPS)*24;ii=find(diff(t)>1);ii=[0; ii;length(t)];
 
 fGPS.long=GPS.long;fGPS.lat=GPS.lat;
 indnan=find((DepthGPS)<0);
    fGPS.long(indnan)=NaN*fGPS.long(indnan);
    fGPS.lat(indnan)=NaN*fGPS.lat(indnan);
    %t(indnan)=NaN*t(indnan);sum(isnan(t))
 indnan=find((SpeedGPS.int>=wi_sup) | (SpeedGPS.int<wi_inf));
    fGPS.long(indnan)=NaN*fGPS.long(indnan);
    fGPS.lat(indnan)=NaN*fGPS.lat(indnan);
    %t(indnan)=NaN*t(indnan);sum(isnan(t))


for j=1:size(ii)-1
%for j=2:size(ii)-1
    'Jour',TempsGPS.day(ii(j)+1)
     figure(1),plot(GPS.long(ii(j)+1:ii(j+1)),-GPS.lat(ii(j)+1:ii(j+1)),c(ind,:))
     reply='N';
     while (reply~='Y')
         b1i=ii(j)+1;
         while (isnan(fGPS.long(b1i))==1 | isnan(fGPS.lat(b1i))==1)
             b1i=b1i+1;
         end
         b2i=ii(j+1);
         while (isnan(fGPS.long(b2i))==1 | isnan(fGPS.lat(b2i))==1)
             b2i=b2i-1;
         end
         figure(ind+1),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,%axis(axe)
         hold on
         plot(fGPS.long(b1i:b2i),-fGPS.lat(b1i:b2i),c(ind,:))
         plot(PositionMouillage.long,PositionMouillage.lat,'+w')
         figure(ind+2)
         hold on
         plot(fGPS.long(b1i:b2i),-fGPS.lat(b1i:b2i),c(ind,:))
         plot(PositionMouillage.long,PositionMouillage.lat,'+k')
        bi = input('borne1 :');b1=b1i+bi;
        bi = input('borne2 :');b2=b2i-bi;
        if (b1>b1i),plot(fGPS.long(b1i:b1-1),-fGPS.lat(b1i:b1-1),'+k'),end
        if (b2<b2i),plot(fGPS.long(b2+1:b2i),-fGPS.lat(b2+1:b2i),'+r'),end
        
        reply = input('OK? Y/N [Y]: ','s');
     end
     borne(ind).min=b1;
     borne(ind).max=b2;
     zone(ind)=input('Zone ? 1; 2 ou 3 ');
     ind=ind+1
 end

 save (BorneGPS,'borne')
 save (GPS_Donnees,'GPS','fGPS','SpeedGPS','DepthGPS','TempsGPS','zone')


%% Initialisation :
load (BorneGPS)
load (GPS_Donnees)
load (BorneTransect)

nbfig=10;
%% Regroupement des transects :
GPSi.long=[];GPSi.lat=[];
fGPSi.long=[];fGPSi.lat=[];
SpeedGPSi.int=[];SpeedGPSi.dir=[];
TempsGPSi.year=[];    TempsGPSi.month=[];    TempsGPSi.day=[];
TempsGPSi.hour=[];    TempsGPSi.minute=[];    TempsGPSi.seconde=[];
DepthGPSi=[];
    
figure(1);clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on,
for nb=1:size(Jfile,1)
    bmin=GPS_borne(nb).min;bmax=GPS_borne(nb).max;
    plot(GPS.long(bmin:bmax),-GPS.lat(bmin:bmax))
    
    GPSi.long=[GPSi.long;GPS.long(bmin:bmax)];
    GPSi.lat=[GPSi.lat;GPS.lat(bmin:bmax)];
    fGPSi.long=[fGPSi.long;fGPS.long(bmin:bmax)];
    fGPSi.lat=[fGPSi.lat;fGPS.lat(bmin:bmax)];
    
    SpeedGPSi.int=[SpeedGPSi.int;SpeedGPS.int(bmin:bmax)];
    SpeedGPSi.dir=[SpeedGPSi.dir;SpeedGPS.dir(bmin:bmax)];
    
    TempsGPSi.year=[TempsGPSi.year;TempsGPS.year(bmin:bmax)];
    TempsGPSi.month=[TempsGPSi.month;TempsGPS.month(bmin:bmax)];
    TempsGPSi.day=[TempsGPSi.day;TempsGPS.day(bmin:bmax)];
    TempsGPSi.hour=[TempsGPSi.hour;TempsGPS.hour(bmin:bmax)];
    TempsGPSi.minute=[TempsGPSi.minute;TempsGPS.minute(bmin:bmax)];
    TempsGPSi.seconde=[TempsGPSi.seconde;TempsGPS.seconde(bmin:bmax)];
    
    DepthGPSi=[DepthGPSi;DepthGPS(bmin:bmax)];
end
i=find(isnan(fGPSi.long)==1);SpeedGPSi.dir(i)=SpeedGPSi.dir(i)*NaN;alpha=SpeedGPSi.dir;
alpha=mod(alpha,180);

%% Premiere def des tronçons :

figure(nbfig);clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on,
              plot(fGPSi.long,-fGPSi.lat)
figure(nbfig+1);clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on,
              plot(GPS.long(bmin:bmax),-GPS.lat(bmin:bmax))
X=1:size(alpha);
Troncon=0*ones(nbTronc,size(alpha));
for Tronc=1:nbTronc;
figure(nbfig);clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on,
              plot(fGPSi.long,-fGPSi.lat)
figure(nbfig+1);clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on,
              plot(GPS.long(bmin:bmax),-GPS.lat(bmin:bmax))
  OKtronc='N';
  while(OKtronc~='Y')
    OK='N';
    while(OK~='Y')
       clf,plot(X,abs(alpha),'.-k')
       disp('Troncon n°'),Tronc
       angleTronc=input('angle moyen du tronçon : ');
       hold on,plot(X,angleTronc*ones(size(alpha)),'r')
       dangleTronc=input('variabilité moyenne de cet angle : ');
       plot(X,(angleTronc+dangleTronc)*ones(size(alpha)),'b')
       plot(X,(angleTronc-dangleTronc)*ones(size(alpha)),'b')
       OK=input('OK : Y/N ','s');
    end
    i=find(abs(alpha)>=angleTronc-dangleTronc & abs(alpha)<=angleTronc+dangleTronc);
%      figure(nbfig);hold on,plot(fGPSi.long(i),-fGPSi.lat(i),'+k')
%      figure(nbfig+1);hold on,plot(X(i),abs(alpha(i)),'+b')
    %Troncon(Tronc,i)=Tronc*ones(size(Troncon(Tronc,i))),pause
    dj=diff(i);    ind=find(dj>1);ind=[0;ind;length(i)];'tronc1',size(ind,1)
        figure(3),clf,hold on,plot(fGPSi.long,-fGPSi.lat)
hold on

    if (size(ind,1)-1>=1)
    for jj=1:size(ind,1)-1
       fGPS.long(i(ind(jj)+1:ind(jj+1)));
       alpha(i(ind(jj)+1:ind(jj+1)))
       figure(nbfig);hold on,plot(fGPSi.long(i(ind(jj)+1):i(ind(jj+1))),-fGPSi.lat(i(ind(jj)+1):i(ind(jj+1))),'*m') 
       figure(nbfig+1);hold on,plot(X(i(ind(jj)+1):i(ind(jj+1))),abs(alpha(i(ind(jj)+1):i(ind(jj+1)))),'*b')
       Troncon
       Tr=input('Ces points font-il parti du tronçon concerné : Y/N ','s');
       if(Tr=='Y')
           Troncon(Tronc,i(ind(jj)+1):i(ind(jj+1)))=Tronc*ones(size(Troncon(Tronc,i(ind(jj)+1):i(ind(jj+1)))));
           figure(nbfig);plot(fGPSi.long(i(ind(jj)+1):i(ind(jj+1))),-fGPSi.lat(i(ind(jj)+1):i(ind(jj+1))),'og') 
           figure(nbfig+1);hold on,plot(X(i(ind(jj)+1):i(ind(jj+1))),abs(alpha(i(ind(jj)+1):i(ind(jj+1)))),'og')
           figure(nbfig);plot(fGPSi.long(i(ind(jj)+1):i(ind(jj+1))),-fGPSi.lat(i(ind(jj)+1):i(ind(jj+1))),'*w') 
           figure(nbfig+1);hold on,plot(X(i(ind(jj)+1):i(ind(jj+1))),abs(alpha(i(ind(jj)+1):i(ind(jj+1)))),'*w')
       else
           Troncon(Tronc,i(ind(jj)+1):i(ind(jj+1)))=Tronc*zeros(size(Troncon(Tronc,i(ind(jj)+1):i(ind(jj+1)))));
           figure(nbfig);plot(fGPSi.long(i(ind(jj)+1):i(ind(jj+1))),-fGPSi.lat(i(ind(jj)+1):i(ind(jj+1))),'or') 
           figure(nbfig+1);hold on,plot(X(i(ind(jj)+1):i(ind(jj+1))),abs(alpha(i(ind(jj)+1):i(ind(jj+1)))),'or')
       end
       
    ii=find(Troncon(Tronc,:)==Tronc);
figure(3),plot(fGPSi.long(ii),-fGPSi.lat(ii),'.r')
    end
    end
    j=find(abs(alpha)<angleTronc-dangleTronc | abs(alpha)>angleTronc+dangleTronc);
    dj=diff(j);    ind=find(dj>1);ind=[0;ind;length(j)];size(ind)
    if (size(ind,1)-1>1)
    for jj=1:size(ind,1)-1
       figure(nbfig);plot(fGPSi.long(j(ind(jj)+1):j(ind(jj+1))),-fGPSi.lat(j(ind(jj)+1):j(ind(jj+1))),'*k') 
       figure(nbfig+1);hold on,plot(X(j(ind(jj)+1):j(ind(jj+1))),abs(alpha(j(ind(jj)+1):j(ind(jj+1)))),'*k')
       Tr=input('Ces points faisaient-il parti du tronçon concerné : Y/N ','s');
       if(Tr=='Y')
           Troncon(Tronc,j(ind(jj)+1):j(ind(jj+1)))=Tronc*ones(size(Troncon(Tronc,j(ind(jj)+1):j(ind(jj+1)))));
           figure(nbfig);plot(fGPSi.long(j(ind(jj)+1):j(ind(jj+1))),-fGPSi.lat(j(ind(jj)+1):j(ind(jj+1))),'og') 
           figure(nbfig+1);hold on,plot(X(j(ind(jj)+1):j(ind(jj+1))),abs(alpha(j(ind(jj)+1):j(ind(jj+1)))),'og')
           figure(nbfig);plot(fGPSi.long(j(ind(jj)+1):j(ind(jj+1))),-fGPSi.lat(j(ind(jj)+1):j(ind(jj+1))),'*w') 
           figure(nbfig+1);hold on,plot(X(j(ind(jj)+1):j(ind(jj+1))),abs(alpha(j(ind(jj)+1):j(ind(jj+1)))),'*w')
       else
           figure(nbfig);plot(fGPSi.long(j(ind(jj)+1):j(ind(jj+1))),-fGPSi.lat(j(ind(jj)+1):j(ind(jj+1))),'or') 
           figure(nbfig+1);hold on,plot(X(j(ind(jj)+1):j(ind(jj+1))),abs(alpha(j(ind(jj)+1):j(ind(jj+1)))),'or')
       end
    ii=find(Troncon(Tronc,:)==Tronc);
figure(3),plot(fGPSi.long(ii),-fGPSi.lat(ii),'.r')
    end
    end
    close all
    ii=find(Troncon(Tronc,:)==Tronc);
    figure(3),plot(fGPSi.long,-fGPSi.lat)
hold on
plot(fGPSi.long(ii),-fGPSi.lat(ii),'.r')
  OKtronc=input('OK : Y/N ','s');
  end

end


%% Vérification :
interm=sum(Troncon)'
ii=find(isnan(alpha)==0 & interm==0);
figure(nbfig);clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on,
              plot(fGPSi.long,-fGPSi.lat)
figure(nbfig+1),clf,plot(X,abs(alpha),'.-k')
for i=1:length(ii)
     figure(nbfig);plot(fGPSi.long(ii(i)),-fGPSi.lat(ii(i)),'or')
     figure(nbfig+1);hold on,plot(X(ii(i)),abs(alpha(ii(i))),'or')
     Tr=input('Numéro de tronçon de ce point : ');
     Troncon(Tr,i)=Tr;
     figure(nbfig);plot(fGPSi.long(ii(i)),-fGPSi.lat(ii(i)),'+k')
     figure(nbfig+1);hold on,plot(X(ii(i)),abs(alpha(ii(i))),'+b')
end
     
    
save (GPStrans,'GPSi','fGPSi','SpeedGPSi','DepthGPSi','TempsGPSi','Troncon')

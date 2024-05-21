%% Transect théorique
clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,%axis(axe) 
hold on
 for Tronc=1:nbTronc;
     clf,
     indnan=find(isnan(fGPSi.long)==0 & Troncon(Tronc,:)'==Tronc);
    plot(GPSi.long(indnan),-GPSi.lat(indnan),'.r'),hold on
    a=polyfit(GPSi.long(indnan),GPSi.lat(indnan),1);%pause
    p_TS(Tronc,:)= a;
    [GPSth(Tronc).long,GPSth(Tronc).lat]=projection_ortho(GPSi.long,GPSi.lat,p_TS(Tronc,1),p_TS(Tronc,2));
    plot(GPSth(Tronc).long,-GPSth(Tronc).lat,'m')
    [GPSth_Deb(Tronc).long,ideb]=min(GPSth(Tronc).long);GPSth_Deb(Tronc).lat=GPSth(Tronc).lat(ideb);
    [GPSth_Fin(Tronc).long,ifin]=max(GPSth(Tronc).long);GPSth_Fin(Tronc).lat=GPSth(Tronc).lat(ifin);
plot(GPSth_Fin(Tronc).long,-GPSth_Fin(Tronc).lat,'.r')
plot(GPSth_Deb(Tronc).long,-GPSth_Deb(Tronc).lat,'.b')
    %Points théoriques
    T_transect=sqrt((((GPSth_Fin(Tronc).long-GPSth_Deb(Tronc).long)*dLong).^2+((GPSth_Fin(Tronc).lat-GPSth_Deb(Tronc).lat)*dLat).^2));
    Taille_transect(Tronc,:)=T_transect
    Npas=Taille_transect(Tronc)/pas;
    dx=(GPSth_Fin(Tronc).long-GPSth_Deb(Tronc).long)/Npas;
    dy=(GPSth_Fin(Tronc).lat-GPSth_Deb(Tronc).lat)/Npas;
    GPSth(Tronc).xpas=GPSth_Deb(Tronc).long:dx:GPSth_Fin(Tronc).long;
    GPSth(Tronc).ypas=GPSth_Deb(Tronc).lat:dy:GPSth_Fin(Tronc).lat;
    GPSth(Tronc).dpas=0:pas:Taille_transect(Tronc,:);
    disp('dpas'),GPSth(Tronc).dpas;
 end
% save(Ftransth,'dpas','xpas','ypas','Eth_Deb','Eth_Fin','Sth_Deb','Sth_Fin','p_TS')
 save(Ftransth,'GPSth','GPSth_Deb','GPSth_Fin','p_TS')
 

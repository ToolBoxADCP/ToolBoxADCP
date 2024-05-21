function Z0=CalculBathy(lon0,lat0);
Zmin=-0.1;

    tempo=load('/home/cristele/Documents/Tunisie/Cozomed/Bathymetrie/bathyGG_lonlatz');
    x=tempo(:,1);
    y=tempo(:,2);
    h=tempo(:,3);

    h(h<0)=-h(h<0);

    Z0=griddata(x,y,h,lon0,lat0);

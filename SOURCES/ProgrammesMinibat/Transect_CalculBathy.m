tempo=load('../../Bathymetrie/bathyGG_lonlatz');
x=tempo(:,1);
y=tempo(:,2);
h=tempo(:,3);

h(h<0)=-h(h<0);

Z0=griddata(x,y,h,lon0,lat0);Z0_=-ones(size(z,1),1)*Z0;size(Z0_)
      Temperature(z<Z0_)=NaN; 
      Salinite(z<Z0_)=NaN;
      Fluorimetrie(z<Z0_)=NaN;
      Turbidite(z<Z0_)=NaN;

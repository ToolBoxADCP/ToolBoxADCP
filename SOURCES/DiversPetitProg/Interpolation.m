function [MM,NN] = Interpolation(LonModis,LatModis,AfaiModis,Lon,Lat);

Modis=0*AfaiModis+1;

[N,M]=size(Lon);
[N_,M_]=size(LonModis);

x = 1:size(Lon,2);
y = 1:size(Lon,1);
[x,y]=meshgrid(x,y);

Lon_=reshape(Lon,1,N*M);
Lat_=reshape(Lat,1,N*M);
x=reshape(x,1,N*M);
y=reshape(y,1,N*M);
LonModis_=reshape(LonModis,1,N_*M_);
LatModis_=reshape(LatModis,1,N_*M_);

% LonModis=Lon(1,1):0.5:Lon(end,end);
% LatModis=Lat(1,1):0.5:Lat(end,end);
% [LonModis,LatModis]=meshgrid(LonModis,LatModis);

[N_,M_]=size(LonModis);
LonModis_=reshape(LonModis,1,N_*M_);
LatModis_=reshape(LatModis,1,N_*M_);

x_ = griddata(Lon_,Lat_,x,LonModis_,LatModis_);
y_ = griddata(Lon_,Lat_,y,LonModis_,LatModis_);

% x_=reshape(x_,1,N_*M_);
% y_=reshape(y_,1,N_*M_);

ii=find(isnan(Modis)==0);
    x_=x_(ii);y_=y_(ii);AfaiModis=AfaiModis(ii);
ii=find((isnan(x_)==0) & (isnan(y_)==0)); 
    x_=x_(ii);y_=y_(ii);AfaiModis=AfaiModis(ii);

[xy,a,b] = unique(floor([x_(:) y_(:)]),'rows');
 
m=histc(b,unique(b));
n= accumarray(b,AfaiModis);
% subplot(212)
 
NN=zeros(M,N);
MM=NaN*zeros(M,N);
idx = sub2ind(size(MM),xy(:,1),xy(:,2));
MM(idx) = m;
NN(idx) = n;

MM=MM';NN=NN';


end


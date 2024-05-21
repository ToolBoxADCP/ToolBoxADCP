m=100;fc=1/10;
k=-m:0.1:m;
y=sin(2*k*pi*fc)./(k*pi).*sin(k.*pi/m)./(k*pi/m);
hold on,plot(k,y,'m')
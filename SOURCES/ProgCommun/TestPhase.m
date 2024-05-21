T1=12.4;T2=12;
om1=2*pi/(T1);
om2=2*pi/(T2);
A=1;
phase=3+T/2;
phase=3*60;

x=0:3*24;
y=A*sin(om1*(x))+A*sin(om2*(x));
yb=A*sin(om1*(x+phase))+A*sin(om2*(x+phase));
plot(x/3600,y,'b',x/3600,yb,'--g')
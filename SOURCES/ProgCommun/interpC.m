function InterpC(C,i);

Y=C.u(i,:);X=1:size(C.u,2);
pp=polyfit(X,Y,7);y=polyval(pp,X);
figure,plot(X,Y,'r',X,y,'g')
errU=mean((Y-y).^2)*100;

Y=C.v(i,:);X=1:size(C.v,2);
pp=polyfit(X,Y,7);y=polyval(pp,X);
figure,plot(X,Y,'r',X,y,'g')
errV=mean((Y-y).^2)*100;

[errU errV]

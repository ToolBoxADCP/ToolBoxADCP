%open test.png
%image(test)
%save dessin test

load(carte)
%image(Tulear)

X=1:size(Tulear,1);
Y=1:size(Tulear,2);
figure,image(Y,X,Tulear),axis xy
axis equal

P(1).Y=937;P(2).Y=4523;
P(1).X=911;P(2).X=5852;
P(1).long=38;P(2).long=46;
P(1).lat=22;P(2).lat=32;

dY=P(2).Y-P(1).Y;dLong=P(2).long-P(1).long;
echY=dY/dLong
translation.Y(1)=P(1).Y/echY-P(1).long;
translation.Y(2)=P(2).Y/echY-P(2).long;

dX=P(2).X-P(1).X;dLat=P(2).lat-P(1).lat;
echX=dX/dLat
translation.X(1)=P(1).X/echX-P(1).lat;
translation.X(2)=P(2).X/echX-P(2).lat;

Xlat=-translation.X(1)+X/echX;
Ylong=-translation.Y(1)+Y/echY;

figure,image(Ylong,Xlat,Tulear),axis('equal'),axis xy
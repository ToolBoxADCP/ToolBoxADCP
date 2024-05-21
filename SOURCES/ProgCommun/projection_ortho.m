% 31/07/07 S.R. Projection orthogonale de points sur une droite
% x,y coordonnées des points
% droite déquation: y = a x + b
% Exemple test
% x=[2,3,5,6,7];
% y=[4,5,7,4,3];
% a=1; b=0;
% sortie: xp,yp: coordonnées des projection

function [xp,yp]=projection_ortho(x,y,a,b)
x1=x;
y1=y-b; % Projection dans le repère translaté de +b, R1

x2= x1*cos(atan(a))+y1*sin(atan(a));
y2=-x1*sin(atan(a))+y1*cos(atan(a));% Projection dans le repère de la droite, R2, rotation de +alpha

x2p=x2;

a=-a;
y2p=0;
x1p= x2p*cos(atan(a))+y2p*sin(atan(a));
y1p=-x2p*sin(atan(a))+y2p*cos(atan(a));% Projection de R2 à R1, rotation de -alpha

xr=0;
yr=-b;
xp=x1p-xr;
yp=y1p-yr;% Projection de R1 à R0, translation de -b


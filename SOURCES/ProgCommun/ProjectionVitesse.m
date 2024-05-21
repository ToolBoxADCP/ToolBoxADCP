function [Upr,Vpr]=ProjectionVitesse(u,v,P1,P2);
GlobaleVar

%% Détermination de l'angle de projection :
%dx=(P2.long-P1.long)*dLong;dy=(P2.lat-P1.lat)*dLat;
dx=(P2.long-P1.long);dy=(P2.lat-P1.lat);
teta=uv2dir(dx,dy);


%% Projection suivant l'angle teta :
[cap,module]=uv2dirspeed(u,v);
[Upr,Vpr]=dir2uv(cap-teta,module);

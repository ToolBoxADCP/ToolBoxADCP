function [Upr,Vpr]=ProjectionVitesse_surEllipse(u,v,teta);
GlobaleVar

%% Projection suivant l'angle teta :
[cap,module]=uv2dirspeed(u,v);
[Upr,Vpr]=dir2uv(cap+teta*180/pi,module);

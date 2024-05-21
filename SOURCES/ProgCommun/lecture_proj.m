function [Temps,vitesse,depth]=lecture_proj(Jfile,bmin,bmax,inv,Bt,teta);
inv
[Temps,vitesse,depth]=lecture(Jfile,bmin,bmax,inv,Bt);
[vitesse.u,vitesse.v]=ProjectionVitesse_surEllipse(vitesse.u,vitesse.v,teta);

load (MouillagePropre_proj)

t=(datum_str(Temps)-T0)*24*3600;
%clf
hold on
plot(t/3600,detrend(P.depth))
plot(t/3600,-vitesse.u(:,5)/500,'r')
plot(t/3600,vitesse.v(:,5)/500,'g')
box on
grid

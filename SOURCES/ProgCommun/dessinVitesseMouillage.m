load (MouillagePropre_proj)

t_M=(datum_str(Temps)-T0)*3600*24;
subplot(2,1,1),plot(t_M/3600/24,vitesse.u(:,5)),axis([2 9.5 -500 500]),grid,box on
subplot(2,1,2),plot(t_M/3600/24,vitesse.v(:,5)),axis([2 9.5 -500 500]),grid,box on

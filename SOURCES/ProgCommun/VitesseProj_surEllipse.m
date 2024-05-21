BolFig=0;
load(MouillageMoy)
load(MouillagePropre)
if(BolFig==1)
    figure(1),subplot(2,1,1),plot(vitesse.u(:,2))
    subplot(2,1,2),plot(vitesse.v(:,2))
end

[vitesse.u,vitesse.v]=...
    ProjectionVitesse_surEllipse(vitesse.u,vitesse.v,tetaMoy);
%load(VitReconst(Tronc,:))
if(BolFig==1)
    figure(2),subplot(2,1,1),plot(vitesse.u(:,2))
    subplot(2,1,2),plot(vitesse.v(:,2))
end
save(MouillagePropre_proj, 'P','tetaMoy',...
    'Temps','P_Adcp','vitesse')

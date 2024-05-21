DT_MoyGlissante=0.5;

figure(1),clf
figure(2),clf

DonneesCampagne('MS2')
load(FluxReconst(1,:))
[MoyGliss,Vit_]=MoyGlissante(FluxSection.temps/24,Flux.u,...
DT_MoyGlissante,0);
temps=FluxSection.temps+DT_MoyGlissante/2;
figure(1),plot(FluxSection.temps/24,(MoyGliss),'k')
% Décalage en temps pour mettre les jours (5 10 15) en face du sticker.
figure(2),plot(FluxSection.temps/24+1,(MoyGliss),'k') 
nanmean(MoyGliss)
figure(1),hold on
figure(2),hold on

DonneesCampagne('MN ')
load(FluxReconst(1,:))
[MoyGliss_,Vit_]=MoyGlissante(FluxSection.temps/24,Flux.u,...
DT_MoyGlissante,0);
temps_=FluxSection.temps;
figure(1),plot(FluxSection.temps/24,-(MoyGliss_),':k')
% Décalage en temps pour mettre les jours (5 10 15) en face du sticker.
figure(2),plot(FluxSection.temps/24+1,-(MoyGliss_),':k')
nanmean(MoyGliss)

MoyGliss_=interp1(temps_,MoyGliss_,temps);
figure(1),plot(temps/24,-MoyGliss+MoyGliss_,'c')
% Décalage en temps pour mettre les jours (5 10 15) en face du sticker.
figure(2),plot(temps/24+1,-MoyGliss+MoyGliss_,'c')
nanmean(MoyGliss)


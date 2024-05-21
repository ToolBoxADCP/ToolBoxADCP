%% recapitulatif campagne

%% Debut - fin campagne (choix des heures de début et fin des fichiers)
load (MouillageAnalyse)
[datestr(HarmoniqueU(1).temps(1)/24+T0) '   '  datestr(HarmoniqueU(1).temps(end)/24+T0)]

load (MouillagePropre)
[mean(P.depth) max(P.depth)-min(P.depth)]
[min(nanmean(vitesse.u')) max(nanmean(vitesse.u')) mean(nanmean(vitesse.u'))]/1000
[min(nanmean(vitesse.v')) max(nanmean(vitesse.v')) mean(nanmean(vitesse.v'))]/1000

load (MouillagePropre_proj)
[min(nanmean(vitesse.u')) max(nanmean(vitesse.u')) mean(nanmean(vitesse.u'))]/1000
[min(nanmean(vitesse.v')) max(nanmean(vitesse.v')) mean(nanmean(vitesse.v'))]/1000
tetaMoy*180/pi

%%
% 10/07/07 S.R. Mise en forme des données de mouillage
% num désigne le mouillage et les paramètres de l'appareil associés
% 1: MN1
% 2: MN2
% 3: MB
% 4: MS
% Sorties:
% day, month, year, hour , minute, seconde: date et heure de la mesure
% u_mmsec, v_mmsec,vitesse_mmsec, dir_deg : resp. vitesse Est, vitesse
% Nord, norme de la vitesse en mm/s, direction en degrés
% depth_adcp_m: immersion de l'adcp 
% dsurface_m, dfond_m: resp. distance de chaque cellule par rapport à la
% surface et par rapport au fond

%function [day, month, year, hour ,u_mmsec, v_mmsec, dir_deg, vitesse_mmsec, depth_adcp_m, dsurface_m, dfond_m,minute, seconde]=form_mouillage(num);
load (BorneMouillage)
param_form_temperature
time1=(datum_str(Temps)-T0);% en secondes

Temperature=Temperature/100;


%% Estimation du niveau d'eau pendant le temps d'immersion de l'ADCP
plot(time1,Temperature,'g')

save(TemperaturePropre,'Temps','Temperature')

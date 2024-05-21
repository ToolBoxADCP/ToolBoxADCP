% 10/07/07 S.R. Mise en forme des donn�es de mouillage
% num d�signe le mouillage et les param�tres de l'appareil associ�s
% 1: MN1
% 2: MN2
% 3: MB
% 4: MS
% Sorties:
% day, month, year, hour , minute, seconde: date et heure de la mesure
% u_mmsec, v_mmsec,vitesse_mmsec, dir_deg : resp. vitesse Est, vitesse
% Nord, norme de la vitesse en mm/s, direction en degr�s
% depth_adcp_m: immersion de l'adcp 
% dsurface_m, dfond_m: resp. distance de chaque cellule par rapport � la
% surface et par rapport au fond

%function [day, month, year, hour ,u_mmsec, v_mmsec, dir_deg, vitesse_mmsec, depth_adcp_m, dsurface_m, dfond_m,minute, seconde]=form_mouillage(num);
load (BorneMouillage)
param_form_temperature
time1=(datum_str(Temps)-T0);% en secondes

Temperature=Temperature/100;


%% Estimation du niveau d'eau pendant le temps d'immersion de l'ADCP
plot(time1,Temperature,'g')

save(TemperaturePropre,'Temps','Temperature')

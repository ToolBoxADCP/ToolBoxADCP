% Nettoyage des données ADCP

function [vitM]=nanmean(vit)

% seuil=input('Entrer la valeur seuil:');

ind=find(isnan(vit)==0);vitM=mean(vit(ind));

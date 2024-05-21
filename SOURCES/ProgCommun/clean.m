% Nettoyage des données ADCP

function [vitX,vitY]=clean(seuil, vitX,vitY)

% seuil=input('Entrer la valeur seuil:');

ind=find(abs(vitX)>seuil);vitX(ind)=NaN;vitY(ind)=NaN;
ind=find(abs(vitY)>seuil);vitX(ind)=NaN;vitY(ind)=NaN;
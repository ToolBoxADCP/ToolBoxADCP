% Nettoyage des données ADCP

function vit=clean(seuil, vit)

% seuil=input('Entrer la valeur seuil:');

ind=find(abs(vit.u)>seuil);vit.u(ind)=NaN;vit.v(ind)=NaN;
ind=find(abs(vit.v)>seuil);vit.u(ind)=NaN;vit.v(ind)=NaN;
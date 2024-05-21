load('TempLatLonT')
indice=1:size(Conserve,1);

%% Choix des valeurs et interpolation
% Valeur extrême à fixer à la main, tu peux aussi t'aider du fichier excel
ii=find(T<TMin | T>TMax);T(ii)=NaN;
T(TNaN)=NaN;
% Valeur à supprimer à la main
% Pour cela, tu traces plot(ii,T(ii),'*b') et tu reperes les points qui ne
% sont pas bon. En abcisse, tu auras l'indice de ce point que tu mets dans
% TNaN
ii=find(isnan(T)==0);
if (size(ii,2)~=0) 
  T_=interp1(ii,T(ii),indice);
else
    T_=NaN*ones(size(indice));
end
% figure(4),clf,plot(indice,T_,'.r')
% hold on,plot(ii,T(ii),'*b'),grid

% Valeur extrême à fixer à la main
ii=find(Lat<LatMin | Lat>LatMax);Lat(ii)=NaN;
% Valeur à supprimer à la main, tu recherches les valeurs comme pour le T
% et comme pour T, tu les mets dans LatNaN.
Lat(LatNaN)=NaN;
ii=find(isnan(Lat)==0);
if (size(ii,2)~=0) 
    Lat_=interp1(ii,Lat(ii),indice);
else
    Lat_=NaN*ones(size(indice));
end
% figure(2),clf,plot(indice,Lat_,'.r')
% hold on,plot(ii,Lat(ii),'*b'),grid

% Valeur extrême à fixer à la main
ii=find(Lon<LonMin | Lon>LonMax);Lon(ii)=NaN;
% Valeur à supprimer à la main, tu recherches les valeurs comme pour le T
% et comme pour T, tu les mets dans LonNaN.
Lon(LonNaN)=NaN;
ii=find(isnan(Lon)==0);
if (size(ii,2)~=0) 
    Lon_=interp1(ii,Lon(ii),indice);
else
    Lon_=NaN*ones(size(indice));
end
% figure(3),clf,plot(indice,Lon_,'.r')
% hold on,plot(ii,Lon(ii),'*b'),grid

%% Suppression de valeur NaN
ii=find(isnan(T_)==0 & isnan(Lon_)==0 & isnan(Lat_)==0);
    T_=T_(ii);Lon_=Lon_(ii);Lat_=Lat_(ii);
if (Campagne=='Cozomed1')
    if (Jour>5)
        DecalGMT=-1;
    else
        DecalGMT=0;
    end
end
T_=T_-DecalGMT;

%% Mise au bon format
temps.year=Annee*ones(size(T_'));
temps.month=Mois*ones(size(T_'));
temps.day=Jour*ones(size(T_'));
temps.hour=floor(T_');
temps.minute=floor((T_'-temps.hour)*60);
temps.seconde=floor(((T_'-temps.hour)*60-temps.minute)*60);
temps.hour=temps.hour+1;

Position.lat=Lat_';
Position.lon=Lon_';

save FichSauvegarde Lat Lon T Annee Mois Jour Heure Minute Seconde 

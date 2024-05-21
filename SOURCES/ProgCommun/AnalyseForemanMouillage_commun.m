%% Choix de Ondes
Ondes=ChoixOndes(NbOndes);

%% Creation du fichier � lire par Foreman
t=(datum_str(Temps));% en jour
Jour=floor(t)-T0;Heure=(t-Jour-T0)*24;
fichierE=['TempE'];
fichierS=['TempS'];

clear Harmonique HarmoniqueU HarmoniqueV
Nom(i,:),N=MaxProf(Nom(i,:));    
Hcellule=NaN*ones(1,N);

for niv=1:N;
      
%% Vitesse U : Pour chaque niveau on execute Foreman 
if (size(find(isnan(vitesse.u(:,niv))==0),1)>1)
      HarmoniqueU(niv)=DefHarmonique(Jour,Heure,vitesse.u(:,niv),...
          NbOndes,Ondes,T0,fichierE,fichierS,0);
else
    HarmoniqueU=[];
end

%% Vitesse V :  
if (size(find(isnan(vitesse.v(:,niv))==0),1)>1)
      HarmoniqueV(niv)=DefHarmonique(Jour,Heure,vitesse.v(:,niv),...
          NbOndes,Ondes,T0,fichierE,fichierS,0);
else
    HarmoniqueV=[];
end

%% Cellule :  
      Hcellule(niv)=blankM+hadcpM+(niv-1)*celM;
    
    
end
  
%% Niveau :  
if (strcmp(FichPression,'Non  ')==0)
if (size(find(isnan(P.depth(:,1))==0),1)>1)
     [HarmoniqueH]=DefHarmonique(Jour,Heure,(P.depth(:,1)-nanmean(P.depth(:,1))),...
          NbOndes,Ondes,T0,fichierE,fichierS,1);
else
    HarmoniqueH=[];
end
else
    HarmoniqueH=[];
end


cor=NaN*zeros(1,size(HarmoniqueU,2));j=i;
for ii=1:size(HarmoniqueU,2),
    corI(ii)=HarmoniqueU(ii).correlation;
    corJ(ii)=HarmoniqueV(ii).correlation;
end
disp('Correlation :'),[corI' corJ']


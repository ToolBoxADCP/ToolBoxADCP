DT=1;
fichierGlobal='FluxJour'   ; 

% dt=min(diff(temps))/24;
% clear FluxJour_Nord FluxJour_Sud Jour
% b='  ';a=[];
% for i=floor(temps(1)/24)-Jour0+1:floor(temps(end)/24)-Jour0+1
%     ii=find(temps/24>i+Jour0-1&temps/24<i+Jour0);
%     FluxJour_Sud(i)=sum(MoyGliss(ii)*dt*24*3600);
%     FluxJour_Nord(i)=-sum(MoyGliss_(ii)*dt*24*3600);
%     Jour(i)=i+Jour0-1;
%     a=[a;b];
% end
%% Bathymetrie
load Bath
Bath_=reshape(Bath,1,size(Bath,1)*size(Bath,2));
Bath_t=Bath_;
bath_t=Bath_t;
bath_t(isnan(Bath_t)==1)=0;
bath_t(bath_t<0)=0;

dx=0.0025*dLong;
dy=0.0025*dLat;
vol=sum(bath_t')*dx*(dy);

%% Initialisation
Nom_=['MS2';'MN '];
b='  ';
NbJour=0;
signe=[1 -1];
temps_min=9999999;
temps_max=0;


for i_nom = 1:size(Nom_,1);
    Nom_(i_nom,:);DonneesCampagne(Nom_(i_nom,:))
load(FluxReconst(1,:))
    temps=FluxSection.temps/24+T0;
    temps_min=min(temps_min,temps(1));
    temps_max=max(temps_max,temps(end));
end
NbJour=floor(temps_max)-floor(temps_min)+1;
Jour0=floor(temps_min);
Jour=1:NbJour;


%% Lecture des fichier et Calcul
IntegrTranspJour=NaN*ones(size(Nom_,1),NbJour);
for i_nom = 1:size(Nom_,1);
    Nom_(i_nom,:);DonneesCampagne(Nom_(i_nom,:))
    load(FluxReconst(1,:))
    temps=FluxSection.temps/24+T0;
    
    dt=min(diff(temps));

    a=[];
    for i=Jour;
        ii=find(temps>i+Jour0-1&temps<i+Jour0);
        FluxJour(i_nom,i)=signe(i_nom)*sum(Flux.u(ii))*dt*24*3600;
        FluxJour(i_nom,i)=signe(i_nom)*mean(Flux.u(ii))*24*3600;
        a=[a;b];
    end
end

%% Impression
FluxJour_Sud=FluxJour(1,:);
FluxJour_Nord=FluxJour(2,:);
FluxJour_Barriere=-(FluxJour(1,:)+FluxJour(2,:));
    
% plot(Jour,FluxJour_Nord/vol*100,Jour,FluxJour_Sud/vol*100,...
%      Jour,FluxJour_Barriere/vol*100)
figure
plot(Jour,FluxJour_Nord/24/3600,Jour,FluxJour_Sud/24/3600,...
     Jour,FluxJour_Barriere/24/3600)

Impr=[datestr(Jour+Jour0-1),a, ...
      num2str(FluxJour_Sud'/3600/24),a,...
      num2str(FluxJour_Nord'/3600/24),a,...
      num2str(FluxJour_Barriere'/3600/24),a,...
      num2str(FluxJour_Sud'/vol*100),a,...
      num2str(FluxJour_Nord'/vol*100),a,...
      num2str(FluxJour_Barriere'/vol*100)];

fid1=fopen(fichierGlobal,'wt');
fprintf(fid1,'Flux en m3/s \n ');
fprintf(fid1,'Renouvellement en pourcentage du vol global \n ');
fprintf(fid1,'Jour    Flux Passe Sud    Flux Passe Nord    Flux Passe Barriere    Renouvellement Passe Sud    Passe Nord    Passe Barriere \n');
for i=1:size(Impr,1);
   fprintf(fid1,'%s \n',Impr(i,:));
end
fclose(fid1);
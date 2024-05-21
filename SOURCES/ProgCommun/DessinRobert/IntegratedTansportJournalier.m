%% Initialisation
fichierGlobal='Test_VitMoy'   ; 

DT=1;

figure(2),clf,
hold on

b='  ';
NbJour=0;
signe=[1 1 -1 1];
temps_min=9999999;
temps_max=0;

for i_nom = 1:size(Nom,1);
    Nom(i_nom,:);DonneesCampagne(Nom(i_nom,:))
    load(MouillagePropre_proj)
    temps=datum_str(Temps);
    temps_min=min(temps_min,temps(1));
    temps_max=max(temps_max,temps(end));
end
NbJour=floor(temps_max)-floor(temps_min)+1;

Jour0=floor(temps_min);
Jour=1:NbJour;

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


%% Lecture des fichier et Calcul
IntegrTranspJour=NaN*ones(size(Nom,1),NbJour);
for i_nom = 1:size(Nom,1);
    Nom(i_nom,:);DonneesCampagne(Nom(i_nom,:))
    load(MouillagePropre_proj)
    temps=datum_str(Temps);
    
    NivMax=MaxProf('MS2');
    
    dt=min(diff(temps));
    IntegrTransport=signe(i_nom)*nanmean(vitesse.u(:,1:NivMax),2).*P.depth/1000;

    a=[];
    for i=Jour;
        ii=find(temps>i+Jour0-1&temps<i+Jour0);
        if(isempty(ii)==0)
           IntegrTranspJour(i_nom,i)=sum(IntegrTransport(ii))*dt*24*3600;
        end
        a=[a;b];
    end
end

%% Impression
Impr=datestr(Jour+Jour0-1); 
Entete=[b,' Jour',b];
for i_nom = 1:size(Nom,1);
    figure(2),plot(Jour+0.5+6,IntegrTranspJour(i_nom,:)/3600/24)
    Impr=[Impr,a,num2str(round(IntegrTranspJour(i_nom,:)'/3600/24*1000)/1000)];
    Entete=[Entete,b,b,' ',Nom(i_nom,:)];
end

%% Flux
%PASSE NORD
%On a une bonne correlation entre Flux, F2, et Vertical
%integrated transport, V2, :
% V2 = 0.0018*F2-0.2185
% ou
% F2 = 547.1355*V2+115.7883

%PASSE SUD
% La correlation entre Flux, F2, et Vertical integrated transport, V2, 
% est moins bonne :
% V2 = -0.000522*F1-0.0154 % Mis les 2 ne sont pas equivalent ...
% ou
% F1 = -674.4668*V1-177.2237

Flux_estime(1,:)=-674.4668*IntegrTranspJour(1,:)/3600/24-177.2237;
Flux_estime(2,:)=547.1355*IntegrTranspJour(3,:)/3600/24+115.7883;
Flux_estime(3,:)=-(Flux_estime(1,:)+Flux_estime(2,:));

Impr_Flux=[datestr(Jour+Jour0-1),a,a ... 
           num2str(round(Flux_estime(1,:))'),a,a,a,a,a,a,...
           num2str(round(Flux_estime(2,:))'),a,a,a,a,a,a,...
           num2str(round(Flux_estime(3,:))'),a,a,a,a,a,a,a,a, ...
      num2str(round(Flux_estime(1,:)'/vol*100*24*3600)),a,a,a,a,a,a,a,a,...
      num2str(round(Flux_estime(2,:)'/vol*100*24*3600)),a,a,a,a,a,a,a,a,...
           num2str(round(Flux_estime(3,:)'/vol*100*24*3600))];

Entete_Flux=['Jour',b,b,b,' ','Flux Passe Sud',b,' ','Flux Passe Nord',b,' ',...
             'Flux Barriere',b,' ',...
             'Renouv Passe Sud',b,' ','Renouv Passe Nord',b,' ',...
             'Renouv Barriere'];


fid1=fopen(fichierGlobal,'wt');
fprintf(fid1,'Transport Integr� sur la verticale en m2 /s \n ');
fprintf(fid1,' \n ');
fprintf(fid1,'%s \n',Entete);
fprintf(fid1,' \n');
for i=1:size(Impr,1);
   fprintf(fid1,'%s \n',Impr(i,:));
end
fprintf(fid1,' \n ');
fprintf(fid1,' \n ');
fprintf(fid1,'Flux estime en m3/s \n ');
fprintf(fid1,' \n ');
fprintf(fid1,'%s \n',Entete_Flux);
fprintf(fid1,' \n');
for i=1:size(Impr,1);
   fprintf(fid1,'%s \n',Impr_Flux(i,:));
end
fclose(fid1);
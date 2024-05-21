DT=1;
fichierGlobal='Niveau_interp4'   ; 
Date_deb=datenum(7,9,12); %12 septembre 2007
Date_fin=datenum(7,9,16); %16 septembre 2007 à 0h

% Date_deb=datenum(7,9,16); %16 septembre 2007
% Date_fin=datenum(7,9,21); %21 septembre 2007 à 0h
% 
% Date_deb=datenum(8,3,30); %30 mars 2008
% Date_fin=datenum(8,4,2); %2 avril 2008 à 0h
% 
Date_deb=datenum(8,4,6); % 6 avril 2008
Date_fin=datenum(8,4,9); % 9 avril 2008 à 0h

%% Lecture des fichier et Calcul
b='  ';
T=Date_deb:1/24:Date_fin;
a=[];
for i=T;
    a=[a;b];
end


Niv=NaN*ones(size(T,2));
U_proj=NaN*ones(size(T,2));

Impr=datestr(T);
for i_nom = 1:size(Nom,1)-1;
    Nom(i_nom,:);DonneesCampagne(Nom(i_nom,:))
%     load(MouillagePropre_proj)
%     load(MouillageMoy)
    load(MouillageAnalyse_proj)
%     figure,hold on
%     temps=datum_str(Temps);
%     Niv=interp1(temps,detrend(P.depth),T)';
%     plot(T,Niv,'r')
    Niv=VitesseCalculeeAvecHarmonique(NbOndes,HarmoniqueH,(T'-T0)*24,T0);
%     plot(T,Niv,'g')
    
%     figure,hold on
%     U_proj=interp1(temps,VitMoy_proj.u,T)';
%     plot(T,U_proj,'r')
    U_proj=VitesseCalculeeAvecHarmonique(NbOndes,HarmoniqueMoyU_proj,(T'-T0)*24,T0);
%     plot(T,U_proj,'g')
    Impr=[Impr a a a a a a num2str(round(Niv*100)/100) a a a a a a num2str(round(U_proj))];
end

%% Impression

fid1=fopen(fichierGlobal,'wt');
fprintf(fid1,'          Jour             Niveau en S2    Vitesse en S2       Niveau en S1    Vitesse en S1       Niveau en N    Vitesse en N    \n');
fprintf(fid1,'    \n');
for i=1:size(Impr,1);
   fprintf(fid1,'%s \n',Impr(i,:));
end
fclose(fid1);
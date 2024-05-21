DessinVitesseMoyenne_loc

c_e=[':r';':b';':k';':m';':c'];
c_f=['r';'b';'k';'m';'c';'g'];
c_e=['r';'b';'k';'m';'c';'g'];

x0=0;y0=0;

clf,

%% Tidal Ellipse
fichMouillage=[Dir 'DessinRobert/VitesseMoyenne/TidalEllipse/'];
dirMouillage=fichMouillage(:,1:end-1);
[a,b]=mkdir (dirMouillage);

for i = 1:size(Nom,1);
  figure(i),clf,hold on
  DonneesCampagne(Nom(i,:));
  load(MouillageMoy)
    HarmU=HarmoniqueMoyU;
    HarmV=HarmoniqueMoyV;
    if(size(HarmV,1)>0)
        niv=1;tid_ell
        fichM=[num2str(fichMouillage) num2str(char(cellstr(Nom(i,:))))];
        saveas(gcf,fichM,'fig')
        saveas(gcf,fichM,'png')
    end
end

%% Ellipse Carte
fichM=[Dir 'DessinRobert/VitesseMoyenne/DispersalEllipse/carte'];
dirMouillage=[Dir 'DessinRobert/VitesseMoyenne/DispersalEllipse'];
[a,b]=mkdir(dirMouillage);

if ((exist('Photo','var')) & (length(Photo)~=0))
figure(3),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on
else
figure(3),clf,axis('equal'),axis xy,hold on
end
for i = 1:size(Nom,1);
  Nom(i,:),DonneesCampagne(Nom(i,:))
  load(MouillageMoy)
      plot(PositionMouillage.long,PositionMouillage.lat,'.r')
      DessinEllipse(EllipseMoy,1,'c',ech,...
          PositionMouillage.long,PositionMouillage.lat)
end
saveas(gcf,fichM,'fig')
saveas(gcf,fichM,'png')

% DESSIN POUR TOUS LES MOIS
% Recherche des diff�rents Mois
SepareMois


% Plot
fichMouillage=[Dir 'DessinRobert/VitesseMoyenne/Plot/'];
dirMouillage=[Dir 'DessinRobert/VitesseMoyenne/Plot'];
[a,b]=mkdir (dirMouillage);

mois=0;
    Umoy=0;
for ind=PremMes.month:PremMes.month+NbMois
    mois=mois+1;
    Tmes=datum_str(DebDessin(mois))-1;
    T_fin=datum_str(FinDessin(mois))-Tmes;
    for i = 1:size(Nom,1);
       DonneesCampagne(Nom(i,:));
       load(MouillageMoy)
       time1=(datum_str(Temps)-Tmes);
       ii=find(time1<T_fin & time1>1);
       if(isempty(ii)==0)
         Ymin=VitMin;Ymax=VitMax;
         NbNiv=1;
%Vitesse N et E
         Harm=HarmoniqueMoyU;vit=VitMoy.u;DessNom='U';
         DessResVitPlot
         Harm=HarmoniqueMoyV;vit=VitMoy.v;DessNom='V';
         DessResVitPlot
%Vitesse proj et ortho
         Harm=HarmoniqueMoyU_proj;vit=VitMoy_proj.u;DessNom='Uproj';
         DessResVitPlot
         Harm=HarmoniqueMoyV_proj;vit=VitMoy_proj.v;DessNom='Uortho';
         DessResVitPlot
%Cap et module
         [cap,module]=uv2dirspeed(VitMoy.v,VitMoy.u);
         Harm=HarmoniqueMoyV_proj;vit=module;DessNom='module';
         Ymin=0;Ymax=sqrt(2)*VitMax;
         DessResVitPlot
         
         Ymin=-10;Ymax=370;
         Harm=HarmoniqueMoyV_proj;vit=cap;DessNom='cap';
         DessResVitPlot
%Niveau
         Ymin=NiveauMin;Ymax=NiveauMax;
         if (strcmp(FichPression,'Non  ')==0)
            load(MouillagePropre)
            load(MouillageAnalyse)
            Harm=HarmoniqueH;vit=detrend(P.depth);DessNom='Niveau';
            DessResVitPlot
         end
         %pause
       end
    end
end

%% Stickplot
fichMouillage=[Dir 'DessinRobert/VitesseMoyenne/Stick/'];
dirMouillage=[Dir 'DessinRobert/VitesseMoyenne/Stick'];
[a,b]=mkdir (dirMouillage);

stickplotMPP_loc
ech=ech_t(1);
echG=echG_t(1);

mois=0;    
for ind=PremMes.month:PremMes.month+NbMois
    mois=mois+1;
    Tmes=datum_str(DebDessin(mois))-1;
    T_fin=datum_str(FinDessin(mois))-Tmes;

    figure(1),clf,hold on%figure(2),clf
    i_=[1 2 4 3];
    for i = 1:size(Nom,1);
       DonneesCampagne(Nom(i,:));
       load(MouillageMoy)
       
       figure(floor((i-1)/2)+1)
       subplot(2,1,mod((i-1),2)+1),hold off


       time_loc=(datum_str(Temps)-Tmes)*24*3600;
       dt=min(diff(time_loc));nb_i=floor(DT/dt);
       [y_min,y_max]=stickplot(1,nb_i,VitMoy,time_loc,0,ech)
       grid on

       if (legendOn)
       legend(cellstr(['    Mouillage:',Nom(i,:)]))
       end
       xlabel('Jour')
    titre=[cellstr([nom ' - '...
                    char(NomMois(mod(DebDessin(mois).month-1,12)+1)) ' ' ...
                    num2str(floor(DebDessin(mois).month/12)+DebDessin(mois).year)...
              ]),...
            cellstr(['Ech: 1/',num2str(ech)])];
%     title(titre)
%        titre=[cellstr(NomMois(DebDessin(mois).month)) ...
%               cellstr(['    Ech: 1/',num2str(ech)])];
         y0=(y_max+y_min)/2;
         axis equal,axis([JourMin JourMax y0-5 y0+5])
       box on
       if(strcmp(Campagne,'Tulear1')| ...
          strcmp(Campagne,'Tulear2'))
              BarrePrelev(Tmes,T_fin,Nom(i,:))
       end
       %if(mod((i-1),2)+1==1);
           title(titre),
       %end
       if((mod((i-1),2)+1~=1)|i==size(Nom,1));
           fich=[num2str(fichMouillage)...
               num2str(char(cellstr(Nom(max(1,i-1),:)))) '_'...
               num2str(char(cellstr(Nom(i,:))))...
               '_Mois' num2str(DebDessin(mois).month)];
           saveas(gcf,fich,'fig')
           saveas(gcf,fich,'png')
       end
       end
end

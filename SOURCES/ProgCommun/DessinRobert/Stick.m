fich='./DessinRobert/stickplot/Vit_';
dir='./DessinRobert/stickplot';[a,b]=mkdir (dir);

% echG_t=[1;1;1;0.5];
% ech_t=[500;500;500;100];
% DT=60*60;%nb_i=5;
stickplotMPP_loc

clf
Nb_maille=3;

fich=[num2str(fich) num2str(char(cellstr(Nom(i,:)))) ...
    '_' char(NomMois(mod(DebDessin(mois).month-1,12)+1)) '_'...
      num2str(floor(DebDessin(mois).month/12)+DebDessin(mois).year) ];
echG=echG_t(i);ech=ech_t(i);
N=MaxProf(nom);

Vitesse_loc.u=vitesse.u(ii,:);
Vitesse_loc.v=vitesse.v(ii,:);
time_loc=time1(ii)*24*3600;
dt=min(diff(time_loc));nb_i=floor(DT/dt);
StickplotSerieVert

titre=[cellstr([char(NomMois(mod(DebDessin(mois).month-1,12)+1)) ' ' ...
                    num2str(floor(DebDessin(mois).month/12)+DebDessin(mois).year)])...
    cellstr(['    Mouillage:',Nom(i,:)]) ...
    cellstr(['    Ech: 1/',num2str(ech)])];
title(titre)
xlabel('Jour')
texte=['Profondeur/',num2str(echG)];ylabel(texte)

%axis([JourMin JourMax Zmin-(Zmax-Zmin)/3 Zmax+(Zmax-Zmin)/3]),axis equal
Z0=(Zmin+Zmax)/2;
%axis([JourMin JourMax Zmin-(Zmax-Zmin)/10 Zmax+(Zmax-Zmin)/10]),axis equal
axis([JourMin JourMax Z0-10 Z0+10]),axis equal
box on
if(strcmp(Campagne,'Tulear1')|strcmp(Campagne,'Tulear2'))
  BarrePrelev(Tmes,T_fin,Nom(i,:))
end

saveas(gcf,fich,'fig')
saveas(gcf,fich,'png')
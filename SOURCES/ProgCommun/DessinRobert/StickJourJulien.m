DonneesCampagne(Nom(1,:))
load(MouillagePropre)
Tmes=datenum(Temps.year(1),1,1)-1;
  Tmin=9999999;
  Tmax=-9999999;

%% Stickplot
fichMouillage='./DessinRobert/VitesseMoyenne/Stick/';
dirMouillage='./DessinRobert/VitesseMoyenne/Stick';
[a,b]=mkdir (dirMouillage);

stickplotJulien_loc
ech=ech_t(1);       echG=echG_t(1);
for i = 1:size(Nom,1);
  Nom(i,:);DonneesCampagne(Nom(i,:))
  load(MouillagePropre)
  T=datum_str(Temps);
  Tmin=min(min(T),Tmin);
  Tmax=max(max(T),Tmax);
end

figure(1),clf,hold on%figure(2),clf
i_=[1 2 4 3];
for i = 1:size(Nom,1);
   DonneesCampagne(Nom(i,:));
   load(MouillageMoy)
       
   figure(floor((i-1)/2)+1)
   subplot(2,1,mod((i-1),2)+1)


   time_loc=(datum_str(Temps)-Tmes)*24*3600;
   dt=min(diff(time_loc));nb_i=floor(DT/dt);
   stickplot(1,nb_i,VitMoy,time_loc,0,ech)
   grid on

   if (legendOn)
   legend(cellstr(['    Mouillage:',Nom(i,:)]))
   end
   xlabel('Julian day')
   titre=[cellstr(['    Ech: 1/',num2str(ech)])];
   axis equal,axis([JourMin(i) JourMax(i) Ymin(i) Ymax(i)])
   %axis([-1 33 3 8])
   box on
   if(strcmp(Campagne,'Tulear1')| ...
      strcmp(Campagne,'Tulear2'))
          BarrePrelev(Tmes,T_fin,Nom(i,:))
   end
   if(mod((i-1),2)+1==1);
       title(titre),
   end
   if((mod((i-1),2)+1~=1)|i==size(Nom,1));
       fich=[num2str(fichMouillage)...
           num2str(char(cellstr(Nom(i,:)))) '_'...
           num2str(char(cellstr(Nom(max(1,i-1),:))))];
%        saveas(gcf,fich,'fig')
%        saveas(gcf,fich,'png')
   end
end


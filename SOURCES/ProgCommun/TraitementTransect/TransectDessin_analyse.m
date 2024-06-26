fichTransect='.\DessinRobert\Transect\coupe\';

for i=1:size(Passe,1)
DonneesCampagne(Nom(ind_ref(i),:))
nbTronc
load(MouillageMoy)
if(~isempty(Ftransth))
load(Ftransth)

MinU=999;MinV=MinU;MinM=MinU;MinZ=999;
MaxU=-999;MaxV=MaxU;MaxM=MaxU;MaxZ=-999;
for Tronc=1:nbTronc;
A=[dfile_th(Tronc,:) '*'];a=ls(A);NbTrans(Tronc)=size(a,1);

 for j=1:NbTrans(Tronc);
  Tfile_th=[dfile_th(Tronc,:) num2str(j)];load (Tfile_th);
  
  MinU=min(MinU,min(min(Tvitesse_th.u)));
  MaxU=max(MaxU,max(max(Tvitesse_th.u)));

  MinV=min(MinV,min(min(Tvitesse_th.v)));
  MaxV=max(MaxV,max(max(Tvitesse_th.v)));

  [cap,module]=uv2dirspeed(Tvitesse_th.u',Tvitesse_th.v');
  MinM=min(MinM,min(min(module)));
  MaxM=max(MaxM,max(max(module)));
  
  ii=find(sum(1-isnan(Tvitesse_th.v))>=1);
  %MinZ=dsurface_th(1,ii(1));MaxZ=dsurface_th(1,ii(end));
  MinZ=min(MinZ,dsurface_th(1,ii(1)));
  MaxZ=max(MaxZ,dsurface_th(1,ii(end)));
 end
 MinX=min(GPSth(Tronc).dpas)/1000;
 MaxX=max(GPSth(Tronc).dpas)/1000;

 for j=1:NbTrans(Tronc);
  Tfile_th=[dfile_th(Tronc,:) num2str(j)];load (Tfile_th);

%% Vitesse U
  
  figure(1)
  subplot(1,2,1)
  pcolor(GPSth(Tronc).dpas'/1000,-dsurface_th',Tvitesse_th.u')
  ii=find(isnan(T_Temps_th.day)==0);
  if(~isempty(ii))
      titre=[cellstr(['U et V - Passe : '  Passe(i,:)]) ...
             cellstr(['du ' num2str(T_Temps_th.day(ii(1))) '/' ...
             num2str(T_Temps_th.month(ii(1))) '/'...
             num2str(T_Temps_th.year(ii(1))) ' - ' ...
             num2str(T_Temps_th.hour(ii(1))) 'h' ...
             num2str(T_Temps_th.minute(ii(1)))])]; 
  else
            titre=cellstr(['U - Passe : ' Passe(i,:)]);
  end
                
  title(titre)
  caxis([MinU MaxU])
  colorbar('horiz')
  axis([MinX MaxX -MaxZ -MinZ])
  xlabel('distance a la cote (km)'),ylabel('Profondeur (m)')

  subplot(1,2,2)
  pcolor(GPSth(Tronc).dpas'/1000,-dsurface_th',Tvitesse_th.v')
  colorbar('horiz')
  caxis([MinV MaxV])
  axis([MinX MaxX -MaxZ -MinZ])
  if(~isempty(ii))
  titre=[cellstr(['Transect ' num2str(j) ...
                  ' - Troncon ' num2str(Tronc)])...
         cellstr(['au ' num2str(T_Temps_th.day(ii(end))) '/' ...
             num2str(T_Temps_th.month(ii(end))) '/'...
             num2str(T_Temps_th.year(ii(end))) ' - ' ...
             num2str(T_Temps_th.hour(ii(end))) 'h' ...
             num2str(T_Temps_th.minute(ii(end)))])]; 
  else
            titre=cellstr(['Transect ' num2str(j) ...
                  ' - Troncon ' num2str(Tronc)]);
  end
  title(titre)
  xlabel('distance a la cote (km)'),ylabel('Profondeur (m)')
  
  fichM=[fichTransect ...
      num2str(char(cellstr(PasseDimi(i,:)))) '_Tronc'  num2str(Tronc) ...
      '\' num2str(char(cellstr(PasseDimi(i,:))))...
      '_Trans' num2str(j) '_Tronc'  ];
  
  saveas(gcf,fichM,'fig')
  saveas(gcf,fichM,'png')
  
%% Module et radian
[cap,module]=uv2dirspeed(Tvitesse_th.u',Tvitesse_th.v');

  %Module
  figure(2)
  subplot(1,2,1)
  pcolor(GPSth(Tronc).dpas'/1000,-dsurface_th',module)
  ii=find(isnan(T_Temps_th.day)==0);
  if(~isempty(ii))
      titre=[cellstr(['Module et Cap - Passe : ' Passe(i,:)]) ...
             cellstr(['du ' num2str(T_Temps_th.day(ii(1))) '/' ...
             num2str(T_Temps_th.month(ii(1))) '/'...
             num2str(T_Temps_th.year(ii(1))) ' - ' ...
             num2str(T_Temps_th.hour(ii(1))) 'h' ...
             num2str(T_Temps_th.minute(ii(1)))])]; 
  else
            titre=cellstr(['U - Passe : ' Passe(i,:)]);
  end
                
  title(titre)
  caxis([MinM MaxM])
  colorbar('horiz')
  axis([MinX MaxX -MaxZ -MinZ])
  xlabel('distance a la cote (km)'),ylabel('Profondeur (m)')

  subplot(1,2,2)
  pcolor(GPSth(Tronc).dpas'/1000,-dsurface_th',cap-tetaMoy*180/pi)
  colorbar('horiz')
  caxis([0-tetaMoy*180/pi 360-tetaMoy*180/pi])
  axis([MinX MaxX -MaxZ -MinZ])
  if(~isempty(ii))
  titre=[cellstr(['Transect ' num2str(j) ...
                  ' - Troncon ' num2str(Tronc)])...
         cellstr(['au ' num2str(T_Temps_th.day(ii(end))) '/' ...
             num2str(T_Temps_th.month(ii(end))) '/'...
             num2str(T_Temps_th.year(ii(end))) ' - ' ...
             num2str(T_Temps_th.hour(ii(end))) 'h' ...
             num2str(T_Temps_th.minute(ii(end)))])]; 
  else
            titre=cellstr(['Transect ' num2str(j) ...
                  ' - Troncon ' num2str(Tronc)]);
  end
  title(titre)
  xlabel('distance a la cote (km)'),ylabel('Profondeur (m)')
  
  fichM=[fichTransect ...
      num2str(char(cellstr(PasseDimi(i,:)))) '_Tronc'  num2str(Tronc) ...
      '\' 'CapModule' num2str(char(cellstr(PasseDimi(i,:))))...
      '_Trans' num2str(j) '_Tronc'  ];
  
  saveas(gcf,fichM,'fig')
  saveas(gcf,fichM,'png')
 end
end
end
end
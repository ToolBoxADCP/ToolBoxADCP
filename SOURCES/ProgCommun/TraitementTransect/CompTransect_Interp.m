fichTransect='./DessinRobert/Transect/Interpolation/';
dirTransect='./DessinRobert/Transect/Interpolation';[a,b]=mkdir(dirTransect);

DessinTransect_loc
RecalculVitesse=0;

for i_passe=1:size(Passe,1)
DonneesCampagne(Nom(ind_ref(i_passe),:))
load(Ftransth)
   if(RecalculVitesse==1)
       P0=P0_tous(i_passe);
       pre_traitement_dephasage
   else
       load(VitReconst(Tronc,:))
   end

MinU=999;MinV=MinU;
MaxU=-999;MaxV=MaxU;
for Tronc=1:1%nbTronc;
A=[dfile_th(Tronc,:) '*'];a=dir(A);%a=ls(A);
NbTrans(Tronc)=size(a,1);


 for j=1:NbTrans(Tronc);
  Tfile_th=[dfile_th(Tronc,:) num2str(j)];load (Tfile_th);

%% Calcul du cap et du module mesur�s
  [cap_th,module_th]=uv2dirspeed(Tvitesse_th.v,Tvitesse_th.u);
              cap_th=mod(cap_th+tetaMoy*180/pi,360);
              %ii=find(cap_th>180);cap_th(ii)=cap_th(ii)-360;


%% Vitesse Reconstituee
clear module cap U V
  Temps_interp=(nanmean(datum_str(T_Temps_th))-T0)*24;
  
  if(RecalculVitesse==1)
      ReconstitutionProfil
  else
      [dminTemps,ind_minTemps]=min(abs(Tr_reconst.Temps-Temps_interp));
      Temps_interp=Tr_reconst.Temps(ind_minTemps);
      U=squeeze(Tr_reconst.U(ind_minTemps,:,:));
      V=squeeze(Tr_reconst.V(ind_minTemps,:,:));
      [cap,module]=uv2dirspeed(V,U);cap=mod(cap+tetaMoy*180/pi,360);
  end

              %ii=find(cap>180);cap(ii)=cap(ii)-360;
 
%% Trouver les bornes
MinCap=min(min(min(cap_th)),min(min(cap)));
MaxCap=max(max(max(cap_th)),max(max(cap)));
MinCap=0;
MaxCap=360;
MinMod=min(min(min(module_th)),min(min(module)));
MaxMod=max(max(max(module_th)),min(max(module)));

%% Dessin Vitesse Theorique
  figure(1),clf
  subplot(1,2,1)
  pcolor(GPSth(Tronc).dpas'/1000,-dsurface_th',cap_th')
  ii=find(isnan(T_Temps_th.day)==0);
  if(~isempty(ii))
      titre=[cellstr(['Theorique - Passe : ' Passe(i_passe,:)]) ...
             cellstr(['du ' num2str(T_Temps_th.day(ii(1))) '/' ...
             num2str(T_Temps_th.month(ii(1))) '/'...
             num2str(T_Temps_th.year(ii(1))) ' - ' ...
             num2str(T_Temps_th.hour(ii(1))) 'h' ...
             num2str(T_Temps_th.minute(ii(1)))])]; 
  else
            titre=cellstr(['U - Passe : ' Passe(i,:)]);
  end
                
  title(titre)
  caxis([MinCap MaxCap])
  axis([Xmin(i_passe) Xmax(i_passe) Ymin(i_passe) Ymax(i_passe)])
  colorbar('horiz')
  xlabel('distance a la cote (km)'),ylabel('Profondeur (m)')

  subplot(1,2,2)
  pcolor(GPSth(Tronc).dpas'/1000,-dsurface_th',module_th')
  
  colorbar('horiz')
  caxis([MinMod MaxMod])
  axis([Xmin(i_passe) Xmax(i_passe) Ymin(i_passe) Ymax(i_passe)])  
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
      num2str(char(cellstr(PasseDimi(i_passe,:))))...
      '_Trans' num2str(j) '_Tronc' num2str(Tronc) 'Theo' ];
  
  saveas(gcf,fichM,'fig')
 % saveas(gcf,fichM,'png')

%% Dessin Vitesse Interpol�e/Reconstituée
  figure(2),clf
  subplot(1,2,1),
  
   if(RecalculVitesse==1)
     pcolor(GPSth(Tronc).dpas'/1000,-surface_interp',cap')
   else
       pcolor(Tr_reconst.dpas/1000,Tr_reconst.z,cap')
   end

   colorbar('horiz')
   if(~isnan(Temps_interp))
      titre=[cellstr(['Interp - Passe : ' Passe(i_passe,:)]) ...
             cellstr(['au ' datestr(Temps_interp/24+T0) ])]; 
   else
      titre=cellstr(['Interp - Passe : ' Passe(i_passe,:)]);
   end
   title(titre)
   colorbar('horiz')
   xlabel('distance a la cote (km)'),ylabel('Profondeur (m)')

   axis([Xmin(i_passe) Xmax(i_passe) Ymin(i_passe) Ymax(i_passe)])
   caxis([MinCap MaxCap])

   subplot(1,2,2),
   if(RecalculVitesse==1)
     pcolor(GPSth(Tronc).dpas'/1000,-surface_interp',module')
   else
       pcolor(Tr_reconst.dpas/1000,Tr_reconst.z,module')
   end
   colorbar('horiz')
    if(~isempty(ii))
           titre=[cellstr(['Transect ' num2str(j) ...
                  ' - Troncon ' num2str(Tronc)])]; 
   else
            titre=cellstr(['Transect ' num2str(j) ...
                  ' - Troncon ' num2str(Tronc)])
   end
  title(titre)
  xlabel('distance a la cote (km)'),ylabel('Profondeur (m)')
  caxis([MinMod MaxMod])
  axis([Xmin(i_passe) Xmax(i_passe) Ymin(i_passe) Ymax(i_passe)])

  fichM_interp=[fichTransect  ...
      num2str(char(cellstr(PasseDimi(i_passe,:))))...
      '_Trans' num2str(j) '_Tronc' num2str(Tronc) 'Interp'];
  
  saveas(gcf,fichM_interp,'fig')
%  saveas(gcf,fichM_interp,'png')
 
  
pause
 end
end
end
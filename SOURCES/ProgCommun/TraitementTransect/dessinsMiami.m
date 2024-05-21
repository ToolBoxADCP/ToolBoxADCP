%% Initialisation :
ech=50000;dt=1/60/24;
load (MouillagePropre_proj)

P_M=P(1);
load (MouillageAnalyse)
load (MouillageAnalyse_proj)

i_T=1;

       figure(3),clf,axis('equal'),axis xy,%axis(axe)
       echTemp=2000;
for Tronc=1:nbTronc;
   disp('Tron�on :'),disp(Tronc)
   load (Ftransth)
   load (point(Tronc,:))
   load(VitReconst(Tronc,:))

   
   A=[dfile_th(Tronc,:) '*'];a=dir(A);NbTrans(Tronc)=size(a,1);
   disp('nb de transect :'),disp(NbTrans)
   t_M=(datum_str(Temps)-T0)*24;
     
   for j=1:NbTrans(Tronc);
      Tfile_th=[dfile_th(Tronc,:) num2str(j)];load (Tfile_th);
      load (Tfile_th)
      'dessin',mean(P_M.depth)
      prof=mean(P_M.depth)-dsurface_th(1,i_T);

      dh=Hcellule-prof;i_M=find(abs(dh)==min(abs(dh)));
      prof=Hcellule(i_M);
   
   
      
%% Vitesse du transect :
      [cap,module]=uv2dirspeed(Tvitesse_th.v,Tvitesse_th.u);
      [v_tr,u_tr]=dir2uv(cap+tetaMoy*180/pi,module);
      figure(3*j+1),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on,%axis(axe)
      quiver(GPSth(Tronc).xpas',-GPSth(Tronc).ypas',u_tr(:,i_T)/ech,v_tr(:,i_T)/ech,0,'r')
%       figure(3*j+2),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on,%axis(axe)
%          quiver(GPSth(Tronc).xpas',-GPSth(Tronc).ypas',u_tr(:,i_T)/ech,v_tr(:,i_T)/ech,0,'r')
      
      t_th=(datum_str(T_Temps_th)-T0)*24;
      
      figure(3),quiver(GPSth(Tronc).dpas'/1000,t_th'/3600,u_tr(:,i_T)/echTemp,v_tr(:,i_T)/echTemp,0,'r')
      axis('equal'),axis xy,hold on,
             
      ii=find(isnan(t_th)==0);
      if (size(ii,2)~=0)

%% Vitesse du mouillage sur tout le temps de la manip :
          load (MouillagePropre)
          jj=find(isnan(vitesse.u(:,i_M))==0 | ...
                  isnan(vitesse.v(:,i_M))==0  );
          uM=interp1(t_M(jj),vitesse.u(jj,i_M),t_th(ii));
          vM=interp1(t_M(jj),vitesse.v(jj,i_M),t_th(ii));
          MinU=min(uM);MaxU=max(uM);
          MinV=min(vM);MaxV=max(vM);
          
          X=PositionMouillage.lat*ones(size(uM));
          Y=PositionMouillage.long*ones(size(uM));
          figure(3*j+1)
          plot(PositionMouillage.long,PositionMouillage.lat,'+r')
          
% Vitesses au mouillage à tous les instants du transect
          figure(1),clf
          subplot(2,1,1),plot(t_th(ii),uM,'b'),hold on
          subplot(2,1,2),plot(t_th(ii),vM,'b'),hold on

%           figure(3*j+2)
%           plot(PositionMouillage.long,PositionMouillage.lat,'+r')
%           quiver(Y,X,vitesse.u(t_th(ii),i_M)/ech,vitesse.v(t_th(ii),i_M)/ech,0,'r')

%% Boucle sur tous les points du transect (point numéro ind)
          for i=1:1:size(ii,2);
            ind=ii(i);

%             figure(2*j+1),quiver(Y(i),X(i),uM(i)/ech,vM(i)/ech,0,'r')
%             figure(2*(j+1)),quiver(Y(i),X(i),uM(i)/ech,vM(i)/ech,0,'r')

% Vitesses au mouillage à pour l'instant ind du transect (i.e. iieme valeur
% non-nulle)
           figure(3*j+1),quiver(Y(i),X(i),uM(i)/ech,vM(i)/ech,0,'r')
        
%% Vitesses interpolees :
   % Interpolation au point du transect et sur toute la durée du transect
           u=interp1(Tr_reconst.Temps,squeeze(Tr_reconst.U(:,ind,i_T)),...
                     t_th(ii));
           v=interp1(Tr_reconst.Temps,squeeze(Tr_reconst.V(:,ind,i_T)),...
                     t_th(ii));
           [cap,module]=uv2dirspeed(v,u);
           [v,u]=dir2uv(cap+tetaMoy*180/pi,module);
           
           figure(1),
           subplot(2,1,1),plot(t_th(ii),u,'.-m')
           subplot(2,1,2),plot(t_th(ii),v,'.-m')
           
            MinU=min(MinU,min(u));
            MaxU=max(MaxU,max(u));
            MinV=min(MinV,min(v));
            MaxV=max(MaxV,max(v));
          
   % Interpolation sur tout le transect a l'instant en question
           u=[];v=[];
           for index=1:size(Tr_reconst.U,2);
              jj=find(isnan(Tr_reconst.U(:,index,i_T))==0 | ...
                      isnan(Tr_reconst.U(:,index,i_T))==0  );
              if (isempty(jj)==0)
                 u(index)=interp1(Tr_reconst.Temps(jj),...
                            squeeze(Tr_reconst.U(jj,index,i_T)),t_th(ind));
                 v(index)=interp1(Tr_reconst.Temps(jj),...
                            squeeze(Tr_reconst.V(jj,index,i_T)),t_th(ind));
              end
           end
           [cap,module]=uv2dirspeed(v,u);
           [v,u]=dir2uv(cap+tetaMoy*180/pi,module);
           
           figure(3*j+1),quiver(GPSth(Tronc).xpas,-GPSth(Tronc).ypas,...
                                u/ech,v/ech,0,'w')
%          figure(3*j+2),
%          quiver(GPSth(Tronc).xpas,-GPSth(Tronc).ypas,u/ech,v/ech,0,'w')
           figure(3),quiver(GPSth(Tronc).dpas/1000,...
                            t_th(ind)*ones(size(GPSth(Tronc).dpas))/3600,...
                            u/echTemp,v/echTemp,0,'b')
          
          
%% Vitesses du transect :
            MinU=min(MinU,min(u_tr(ind,i_T)));MaxU=max(MaxU,max(u_tr(ind,i_T)));
            MinV=min(MinV,min(v_tr(ind,i_T)));MaxV=max(MaxV,max(v_tr(ind,i_T)));
          figure(1),
          subplot(2,1,1),plot(t_th(ind),u_tr(ind,i_T),'.k')
          axis([min(t_th(ii))-5E4/3600 max(t_th(ii))+5E4/3600 MinU-50 MaxU+50])
          subplot(2,1,2),plot(t_th(ind),v_tr(ind,i_T),'.k')
          axis([min(t_th(ii))-5E4/3600 max(t_th(ii))+5E4/3600 MinV-50 MaxV+50]),
          
         figure(3*j+1),quiver(GPSth(Tronc).xpas(ind)',-GPSth(Tronc).ypas(ind)',u_tr(ind,i_T)/ech,v_tr(ind,i_T)/ech,0,'b')
         title(datestr(T0+t_th(ind)/24))
%% on efface tout :
            figure(3*j+1),axis(axe)
         %pause
          figure(3*j+1),quiver(Y(i),X(i),uM(i)/ech,vM(i)/ech,0,'w')
          %quiver(GPSth(Tronc).xpas,-GPSth(Tronc).ypas,u/ech,v/ech,0,'k')
          %quiver(Y(i),X(i),u(i)/ech,v(i)/ech,0,'r')
          quiver(GPSth(Tronc).xpas(ind),-GPSth(Tronc).ypas(ind),u_tr(ind,i_T)/ech,v_tr(ind,i_T)/ech,0,'r')
          %A pr�sent, il faut calculer les vitesses � l'instant t_M(ii(ind)) et
          %la repr�senter sur le dessin en tous points.
         end
             figure(3),quiver(GPSth(Tronc).dpas'/1000,t_th',u_tr(:,i_T)/echTemp,v_tr(:,i_T)/echTemp,0,'r')
             axis('equal'),axis xy,hold on,

         pause
      end 
   end
   pause
end
  

%% Initialisation :
close all
ech=50000;dt=1/60/24;
load (MouillagePropre_proj)

P_M=P(1);
load (MouillageAnalyse)
load (MouillageAnalyse_proj)

i_T=1;


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
      t_th=(datum_str(T_Temps_th)-T0)*24;
      
             
      ii=find(isnan(t_th)==0);
      if (size(ii,2)~=0)

          figure(50+floor(min(t_th)/24)),axis('equal'),axis xy,hold on
          figure(3*j+1),axis xy,hold on,axis(axe)
            image(Ylong,Xlat,Photo),axis('equal')
%% Vitesse du mouillage sur tout le temps du transect :
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
          
%% Variation Temporelle en chaque point du transect
          figure(1),clf
          subplot(2,1,1),plot(t_th(ii),uM,'b'),hold on
          subplot(2,1,2),plot(t_th(ii),vM,'b'),hold on
          for i=1:1:size(ii,2); ind=ii(i);
             u=interp1(Tr_reconst.Temps,squeeze(Tr_reconst.U(:,ind,i_T)),...
                     t_th(ii));
             v=interp1(Tr_reconst.Temps,squeeze(Tr_reconst.V(:,ind,i_T)),...
                     t_th(ii));
             [cap,module]=uv2dirspeed(v,u);
             [v,u]=dir2uv(cap+tetaMoy*180/pi,module);
           
              MinU=min(MinU,min(u));MinU=min(MinU,min(u_tr(ind,i_T)));
              MaxU=max(MaxU,max(u));MaxU=max(MaxU,max(u_tr(ind,i_T)));
              MinV=min(MinV,min(v));MinV=min(MinV,min(v_tr(ind,i_T)));
              MaxV=max(MaxV,max(v));MaxV=max(MaxV,max(v_tr(ind,i_T)));

              subplot(2,1,1),
                plot(t_th(ii),u,'.-m')
                plot(t_th(ind),u_tr(ind,i_T),'.k')
                %axis([min(t_th(ii))-5E4/3600 max(t_th(ii))+5E4/3600 ...
                axis([min(t_th(ii)) max(t_th(ii)) ...
                      MinU-50 MaxU+50])
                
              subplot(2,1,2),
                plot(t_th(ii),v,'.-m')
                plot(t_th(ind),v_tr(ind,i_T),'.k')
                %axis([min(t_th(ii))-5E4/3600 max(t_th(ii))+5E4/3600 ...
                axis([min(t_th(ii)) max(t_th(ii)) ...
                     MinV-50 MaxV+50]),
          end
          


%% Boucle a tous les instant du transect (point numéro ind)
%            Vitesses au mouillage à l'instant ind du transect (i.e. 
%            iieme valeur non-nulle)
% Vitesses interpolees : Interpolation sur tout le transect a l'instant en question
          %A pr�sent, il faut calculer les vitesses � l'instant t_M(ii(ind)) et
          %la repr�senter sur le dessin en tous points.
          for i=1:1:size(ii,2); ind=ii(i);
             figure(3*j+1)
             quiver(Y(i),X(i),uM(i)/ech,vM(i)/ech,0,'b')
        
             u=[];v=[];
             for index=1:size(Tr_reconst.U,2);
                jj=find(isnan(Tr_reconst.U(:,index,i_T))==0 | ...
                      isnan(Tr_reconst.U(:,index,i_T))==0  );
                if (isempty(jj)==0)
                   u(index)=interp1(Tr_reconst.Temps(jj),...
                            squeeze(Tr_reconst.U(jj,index,i_T)),t_th(ind));
                   v(index)=interp1(Tr_reconst.Temps(jj),...
                            squeeze(Tr_reconst.V(jj,index,i_T)),t_th(ind));
                else
                    u(index)=NaN;
                    v(index)=NaN;
                end
             end
             [cap,module]=uv2dirspeed(v,u);
             [v,u]=dir2uv(cap+tetaMoy*180/pi,module);
           
             quiver(GPSth(Tronc).xpas,-GPSth(Tronc).ypas,...
                                u/ech,v/ech,0,'w')
             quiver(GPSth(Tronc).xpas(ind)',-GPSth(Tronc).ypas(ind)',...
                    u_tr(ind,i_T)/ech,v_tr(ind,i_T)/ech,0,'b')
             title(datestr(T0+t_th(ind)/24))

             quiver(Y(i),X(i),uM(i)/ech,vM(i)/ech,0,'r')
             quiver(GPSth(Tronc).xpas(ind),-GPSth(Tronc).ypas(ind),...
                    u_tr(ind,i_T)/ech,v_tr(ind,i_T)/ech,0,'r')
             
             figure(50+floor(min(t_th)/24)),
             quiver(GPSth(Tronc).dpas/1000,...
                    t_th(ind)*ones(size(GPSth(Tronc).dpas)),...
                    u/echTemp,v/echTemp,0,'b')
          
          end
         
          figure(3*j+1),
            quiver(GPSth(Tronc).xpas',-GPSth(Tronc).ypas',...
                  u_tr(:,i_T)/ech,v_tr(:,i_T)/ech,0,'r')
      
      
          figure(50+floor(min(t_th)/24)),
            quiver(GPSth(Tronc).dpas'/1000,t_th',...
                   u_tr(:,i_T)/echTemp,v_tr(:,i_T)/echTemp,0,'r')

          %pause
         % on efface tout :

      end 
   end
   pause
end
  

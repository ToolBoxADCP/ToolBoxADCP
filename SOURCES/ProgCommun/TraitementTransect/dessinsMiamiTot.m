function []=dessinsMiamiTot(nom_)

GlobaleVar
DessinTransect_loc
DonneesCampagne(nom_)
Nom_loc=Nom(ind_ref,:);
aa=[];
for ii=1:size(Nom_loc,1);aa(ii)=strcmp(Nom_loc(ii,:),nom_);end
i_passe=find(aa==1)

%% Initialisation :
ech=50000;dt=1/60/24;
T_deb=100;%1*24;
T_fin=15*24;
dT=1;
        MinCap=0;
        MaxCap=360;
        MinMod=0;
        MaxMod=ModMax(i_passe);

            if(strcmp(Pression,'Non  ')==1);
              load('./MouillagePropre/MNpr')
              Niv=detrend(P.depth);
              t_Niv=(datum_str(Temps)-T0)*24;
            else
              load(MouillagePropre)
              Niv=detrend(P.depth);
              t_Niv=(datum_str(Temps)-T0)*24;
            end    


%load (MouillagePropre_proj)
load (MouillagePropre)
t_M=(datum_str(Temps)-T0)*24;
i_M=MaxProf(vitesse);


P_M=P(1);
load (MouillageAnalyse)
load (MouillageAnalyse_proj)

i_T=1;

figure(1),clf,axis('equal'),axis xy,%axis(axe)
echTemp=2000;
% for Tronc=1:nbTronc;
%    disp('Tronçon :'),disp(Tronc)
%    load (Ftransth)
%    load (point(Tronc,:))
%    load(VitReconst(Tronc,:))

   
%    A=[dfile_th(Tronc,:) '*'];a=ls(A);NbTrans(Tronc)=size(a,1);
%    disp('nb de transect :'),disp(NbTrans)
   t_M=(datum_str(Temps)-T0)*24;
   
   T_deb=max(T_deb,min(t_M))
   T_fin=min(T_fin,max(t_M))
   for TT=T_deb:dT:T_fin;
       TT
%% Fleches  :
      figure(1),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on,%axis(axe)
   
      
% Mouillage : Vitesse du mouillage sur tout le temps de la manip :
%i_M=10;
          uM=interp1(t_M,vitesse.u(:,i_M),TT);
          vM=interp1(t_M,vitesse.v(:,i_M),TT);
          MinU=min(uM);MaxU=max(uM);
          MinV=min(vM);MaxV=max(vM);
          
          X=PositionMouillage.lat;
          Y=PositionMouillage.long;
          figure(1)
          plot(PositionMouillage.long,PositionMouillage.lat,'+r')

          figure(1),quiver(Y,X,uM/ech,vM/ech,0,'r')
        
% Transect :
   % Interpolation sur tout le transect à l'instant en question
for Tronc=1:nbTronc;
   disp('Tronçon :'),disp(Tronc)
   load (Ftransth)
   load (point(Tronc,:))
   load(VitReconst(Tronc,:))
            [dminTemps,ind_minTemps]=min(abs(Tr_reconst.Temps-TT));
            U=squeeze(Tr_reconst.U(ind_minTemps,:,:));
            V=squeeze(Tr_reconst.V(ind_minTemps,:,:));
            [cap,module]=uv2dirspeed(V,U);
            [v,u]=dir2uv(cap+tetaMoy*180/pi,module);
           
            figure(1),quiver(GPSth(Tronc).xpas',-GPSth(Tronc).ypas',u(:,i_T)/ech,v(:,i_T)/ech,0,'w')

            figure(1),axis(axe)
            
            titre=[cellstr([datestr(TT/24+T0) ])];
            title(titre)
            
%% Coupe :
            figure(2+Tronc),clf
            
            subplot(1,2,1),
            pcolor(Tr_reconst.dpas/1000,Tr_reconst.z,mod(cap'+tetaMoy*180/pi,360))
            colorbar('horiz')
            titre=[ cellstr(['Coupe au ' datestr(TT/24+T0) ])];
            title(titre)

            xlabel('distance a la cote (km)'),ylabel('Profondeur (m)')
            axis([Xmin(i_passe) Xmax(i_passe) Ymin(i_passe) Ymax(i_passe)])
            caxis([MinCap MaxCap])

            subplot(1,2,2),
            pcolor(Tr_reconst.dpas/1000,Tr_reconst.z,module')
            colorbar('horiz')
            
            titre=[cellstr(['Troncon ' num2str(Tronc)])];
            title(titre)
            xlabel('distance a la cote (km)'),ylabel('Profondeur (m)')
            caxis([MinMod MaxMod])
            axis([Xmin(i_passe) Xmax(i_passe) Ymin(i_passe) Ymax(i_passe)])
   end
                
%% Niveau :
            figure(2),clf
%             load(MouillagePropre)
%             if(strcmp(Pression,'Non  ')==1);
%               load('./MouillagePropre/MNpr')
%             end    
%             t=(datum_str(Temps)-T0)*24;
%             plot(t,P.depth-nanmean(P.depth)),hold on
%                 [dminTemps,ind_minTemps]=min(abs(t-TT));
%             plot(t(ind_minTemps),P.depth(ind_minTemps)-nanmean(P.depth),'or')
%             axis([T_deb-6 T_fin+6 -2 2 ])
%             pause
            
            t=(datum_str(Temps)-T0)*24;
            Niv_=interp1(t_Niv,Niv,t);
            plot(t,Niv_),hold on
                [dminTemps,ind_minTemps]=min(abs(t-TT));
            plot(t(ind_minTemps),Niv_(ind_minTemps),'or')
            axis([T_deb-6 T_fin+6 -2 2 ])
            pause

end
  

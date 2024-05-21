%% Initialisation :
ech=100000/2.5;dt=1/60/24;
load (MouillagePropre_proj)

P_M=P(1);
load (MouillageAnalyse)
load (MouillageAnalyse_proj)
i_T=1;

for Tronc=1:nbTronc;
   disp('Tronçon :');disp(Tronc);
   load (Ftransth)
   load (point(Tronc,:))
   
   A=[dfile_th(Tronc,:) '*'];a=ls(A);NbTrans(Tronc)=size(a,1);
   disp('nb de transect :');disp(NbTrans);
   t_M=(datum_str(Temps)-T0)*3600*24;
     
   for j=1:NbTrans(Tronc);
%% Vitesse sur le transect j
      Tfile_th=[dfile_th(Tronc,:) num2str(j)];load (Tfile_th);
      load (Tfile_th)
      'dessin';mean(P_M.depth);
      prof=mean(P_M.depth)-dsurface_th(1,i_T);

      dh=Hcellule-prof;i_M=find(abs(dh)==min(abs(dh)));
      prof=Hcellule(i_M);
   
   
      figure(j+1),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on,axis(axe)
      figure(10+j+1),clf,axis('equal'),axis xy,hold on,axis(axe)
      [u_th,v_th]=ProjectionVitesse_surEllipse(Tvitesse_th.u(:,i_T),Tvitesse_th.v(:,i_T),-tetaMoy);
      figure(j+1),quiver(GPSth(Tronc).xpas',-GPSth(Tronc).ypas',u_th/ech,v_th/ech,0,'m')
      figure(10+j+1),quiver(GPSth(Tronc).xpas',-GPSth(Tronc).ypas',u_th/ech,v_th/ech,0,'c')

%% Instant de la mesure
      t_th=(datum_str(T_Temps_th)-T0)*3600*24;
      ii=find(isnan(t_th)==0);
      if (size(ii,2)~=0)

%% Vitesse du mouillage sur tout le temps t_th(ii) du transect j :
% Calcul de la vitesse <--- Mouil.u et Mouil.v
        VitMouillage.u=Vit_Mouillage(t_th(ii),prof,HarmoniqueU,Hcellule);
        VitMouillage.v=Vit_Mouillage(t_th(ii),prof,HarmoniqueV,Hcellule);
     
        Mouil=CalculVitMouillage(VitMouillage);
          
% Dessin sur la carte
        %uM=uM';vM=vM';ii=ii';
        X=PositionMouillage.lat*ones(size(Mouil.u));
        Y=PositionMouillage.long*ones(size(Mouil.v));
        figure(j+1)
        plot(PositionMouillage.long,PositionMouillage.lat,'+r')
        [uM_proj,vM_proj]=ProjectionVitesse_surEllipse(Mouil.u,Mouil.v,-tetaMoy);
        quiver(Y,X,uM_proj/ech,vM_proj/ech,0,'r')

%% Definition du transect théorique :
          NbPointDessins=40;
          
          minPoint=(GPSth(Tronc).dpas(ii(1)));maxPoint=(GPSth(Tronc).dpas(ii(end)));
          deltaPas=(maxPoint-minPoint)/NbPointDessins;ddpas=minPoint:deltaPas:maxPoint;

          GPSth(Tronc).xpas
          minPoint=(GPSth(Tronc).xpas(ii(1)));maxPoint=(GPSth(Tronc).xpas(ii(end)));
          deltaPas=(maxPoint-minPoint)/NbPointDessins;xxpas=minPoint:deltaPas:maxPoint;
          
          minPoint=(GPSth(Tronc).ypas(ii(1)));maxPoint=(GPSth(Tronc).ypas(ii(end)));
          deltaPas=(maxPoint-minPoint)/NbPointDessins;yypas=minPoint:deltaPas:maxPoint;

        for i=1:10:size(ii,2);ind=ii(i)
%% Vitesse Mouillage au cours du transect ::

          % sur toute la durée du mouillage (dessin plot):
          figure(1),clf
          [uMv_proj,vMv_proj]=ProjectionVitesse_surEllipse(vitesse.u(:,i_M),vitesse.v(:,i_M),-tetaMoy);
          subplot(2,1,1),plot(t_M,vitesse.u(:,i_M),'b'),hold on
          subplot(2,1,2),plot(t_M,vitesse.v(:,i_M),'b'),hold on
            
          % Durant la durée du transect (dessin plot):
          subplot(2,1,1),plot(t_th(ii),Mouil.u','.r')
          subplot(2,1,2),plot(t_th(ii),Mouil.v','.r')
            
          % A l'instant ii(i) sur carte:
          figure(j+1),quiver(Y(i),X(i),uM_proj(i)/ech,vM_proj(i)/ech,0,'b')
          figure(10+j+1),quiver(Y(i),X(i),uM_proj(i)/ech,vM_proj(i)/ech,0,'b')
          MinU=min(Mouil.u);MaxU=max(Mouil.u);
          MinV=min(Mouil.v);MaxV=max(Mouil.v);
         

%% Vitesses interpolées en 1 point du transect et sur toute la manip

     % Calcul
          Point=((GPSth(Tronc).dpas(ind)-P0)/(LongTr))*ones(size(VitMouillage.u,1),1);
          A=CalculMatriceA(Point,VitMouillage,ImpVit_M,CouplVitesse,degPol);

          u=CalcVitesse(C.u,A.u,degPol,ImpVit_M,NbOndes)+ImpVit_M*Mouil.u;
          v=CalcVitesse(C.v,A.v,degPol,ImpVit_M,NbOndes)+ImpVit_M*Mouil.v;

          [u_proj,v_proj]=ProjectionVitesse_surEllipse(u,v,-tetaMoy);

    % Dessin plot
          figure(1),
          subplot(2,1,1),plot(t_th(ii),u,'.-m')
          subplot(2,1,2),plot(t_th(ii),v,'.-m')
          MinU=min(MinU,min(u));MaxU=max(MaxU,max(u));
          MinV=min(MinV,min(v));MaxV=max(MaxV,max(v));
           
%% Vitesses interpolées sur tout le transect à l'instant en question
     % Calcul
          
          Point=((GPSth(Tronc).dpas(ii)'-P0)/(LongTr));
          Point=((ddpas'-P0)/(LongTr));
        
          VitMouillage_inst.u=ones(size(Point,1),1)*VitMouillage.u(i,:);
          VitMouillage_inst.v=ones(size(Point,1),1)*VitMouillage.v(i,:);
            
          A=CalculMatriceA(Point,VitMouillage_inst,ImpVit_M,CouplVitesse,degPol);

          u=CalcVitesse(C.u,A.u,degPol,ImpVit_M,NbOndes)+ImpVit_M*Mouil.u(i);
          v=CalcVitesse(C.v,A.v,degPol,ImpVit_M,NbOndes)+ImpVit_M*Mouil.v(i);

     % Dessin carte :
          [u_proj,v_proj]=ProjectionVitesse_surEllipse(u,v,-tetaMoy);
          %figure(j+1),quiver(GPSth(Tronc).xpas(ii)',-GPSth(Tronc).ypas(ii)',u_proj/ech,v_proj/ech,0,'w')
                    
          figure(j+1),quiver(xxpas',-yypas',u_proj/ech,v_proj/ech,0,'w')
          figure(10+j+1),quiver(xxpas',-yypas',u_proj/ech,v_proj/ech,0,'k')
          
          
%% Vitesses du transect à l'instant ii(i):
     % Dessin plot :
            figure(1),
            MinU=min(MinU,min(Tvitesse_th.u(ind,i_T)));MaxU=max(MaxU,max(Tvitesse_th.u(ind,i_T)));
            MinV=min(MinV,min(Tvitesse_th.v(ind,i_T)));MaxV=max(MaxV,max(Tvitesse_th.v(ind,i_T)));
            subplot(2,1,1),plot(t_th(ind),Tvitesse_th.u(ind,i_T),'.k')
            axis([min(t_th(ii))-5E4 max(t_th(ii))+5E4 MinU-50 MaxU+50])
            subplot(2,1,2),plot(t_th(ind),Tvitesse_th.v(ind,i_T),'.k')
            axis([min(t_th(ii))-5E4 max(t_th(ii))+5E4 MinV-50 MaxV+50])
          
     % Dessin carte :
            [u_th,v_th]=ProjectionVitesse_surEllipse(Tvitesse_th.u(ind,i_T),Tvitesse_th.v(ind,i_T),-tetaMoy);
            %figure(j+1),quiver(GPSth(Tronc).xpas(ind)',-GPSth(Tronc).ypas(ind)',Tvitesse_th.u(ind,i_T)/ech,Tvitesse_th.v(ind,i_T)/ech,0,'b')
            figure(j+1),quiver(GPSth(Tronc).xpas(ind)',-GPSth(Tronc).ypas(ind)',u_th/ech,v_th/ech,0,'b')
         
%% on efface tout :
          pause
          quiver(xxpas',-yypas',u_proj/ech,v_proj/ech,0,'k')
%           quiver(Y(ind),X(ind),u(ind)/ech,v(ind)/ech,0,'r')
          [u_th,v_th]=ProjectionVitesse_surEllipse(Tvitesse_th.u,Tvitesse_th.v,-tetaMoy);

          quiver(GPSth(Tronc).xpas(ind)',-GPSth(Tronc).ypas(ind)',u_th(ind,i_T)/ech,v_th(ind,i_T)/ech,0,'m')
          %A présent, il faut calculer les vitesses à l'instant t_M(ii(ind)) et
          %la représenter sur le dessin en tous points.
         end
      
      end 
   end
end
      break
  

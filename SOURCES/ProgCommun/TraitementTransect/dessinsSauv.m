%% Initialisation :
ech=100000;dt=1/60/24;
load (MouillagePropre_proj)

P_M=P;
load (MouillageAnalyse)
load (MouillageAnalyse_proj)

i_T=1;

for Tronc=1:nbTronc;
   disp('Tronçon :'),disp(Tronc)
   load (Ftransth)
   load (point(Tronc,:))
   
   A=[dfile_th(Tronc,:) '*'];a=ls(A);NbTrans(Tronc)=size(a,1);
   disp('nb de transect :'),disp(NbTrans)
   t_M=(datum_str(Temps)-T0)*3600*24;
     
   for j=1:NbTrans(Tronc);
      Tfile_th=[dfile_th(Tronc,:) num2str(j)];load (Tfile_th);
      load (Tfile_th)
      'dessin',mean(P_M.depth)
      prof=mean(P_M.depth)-dsurface_th(1,i_T);

      dh=Hcellule-prof;i_M=find(abs(dh)==min(abs(dh)))
      prof=Hcellule(i_M);
   
   
      
      figure(j+1),clf,image(Ylong,Xlat,Photo),axis xy,hold on,%axis(axe)
         quiver(GPSth(Tronc).xpas',-GPSth(Tronc).ypas',Tvitesse_th.u(:,i_T)/ech,Tvitesse_th.v(:,i_T)/ech,0,'r')
      
      t_th=(datum_str(T_Temps_th)-T0)*3600*24;
      ii=find(isnan(t_th)==0);
      if (size(ii,2)~=0)

%% Vitesse du mouillage sur tout le temps de la manip :
        VitMouillage.u=Vit_Mouillage(t_th(ii),prof,HarmoniqueU,Hcellule,5:6);
        VitMouillage.v=Vit_Mouillage(t_th(ii),prof,HarmoniqueV,Hcellule,5:6);
          uM=sum(VitMouillage.u');
          vM=sum(VitMouillage.v');
        
          
          uM=uM';vM=vM';ii=ii';
          X=PositionMouillage.lat*ones(size(uM));
          Y=PositionMouillage.long*ones(size(uM));
          figure(j+1)
          plot(PositionMouillage.long,PositionMouillage.lat,'+r')
          quiver(Y,X,uM/ech,vM/ech,0,'r')

%% Vitesses variables au cours du transect :

          for i=35:10:size(ii,1);
% Mouillage :
            figure(1),clf
            subplot(2,1,1),plot(t_M,vitesse.u(:,i_M),'b'),hold on
            subplot(2,1,2),plot(t_M,vitesse.v(:,i_M),'b'),hold on
            
            subplot(2,1,1),plot(t_th(ii),uM','.r')
            subplot(2,1,2),plot(t_th(ii),vM','.r')
            
            ind=ii(i);
            figure(j+1),quiver(Y(i),X(i),uM(i)/ech,vM(i)/ech,0,'b')
            MinU=min(uM);MaxU=max(uM);
            MinV=min(vM);MaxV=max(vM);
         
% Vitesses interpolées :
   % Interpolation au point du transect et sur toute la manip
      %prof=Ptr(nb).fond_f(1,ind),
            A=[];
            A.u=[];
            A.v=[];
            vect=ones(1,size(VitMouillage.u,2));
            for deg=0:degPol;
%              A.u=[A.u ((GPSth(Tronc).dpas(ind)-P0)/(LongTr/2)).^deg*VitMouillage.u];
%              A.v=[A.v ((GPSth(Tronc).dpas(ind)-P0)/(LongTr/2)).^deg*VitMouillage.v];
    A.u=[A.u (Point.^deg*vect).*VitesseMouillage];
    A.v=[A.v (Point.^deg*vect).*VitesseMouillage];
            end
    
          u=A.u*C.u;
          v=A.v*C.v;
          figure(1),
          subplot(2,1,1),plot(t_th(ii),u,'.-m')
          subplot(2,1,2),plot(t_th(ii),v,'.-m')
            MinU=min(MinU,min(u));MaxU=max(MaxU,max(u));
            MinV=min(MinV,min(v));MaxV=max(MaxV,max(v));
          
   % Interpolation sur tout le transect à l'instant en question
            A=[];
            A.u=[];
            A.v=[];
            vect=ones(1,size(VitMouillage.u,2));
            for deg=0:degPol;
             A.u=[A.u ((GPSth(Tronc).dpas'-P0)/(LongTr/2)).^deg*VitMouillage.u(i,:)];
             A.v=[A.v ((GPSth(Tronc).dpas'-P0)/(LongTr/2)).^deg*VitMouillage.v(i,:)];
            end
    
          u=A.u*C.u;
          v=A.v*C.v;
          figure(j+1),quiver(GPSth(Tronc).xpas',-GPSth(Tronc).ypas',u/ech,v/ech,0,'w')
          
          
% Vitesses du transect :
            MinU=min(MinU,min(Tvitesse_th.u(ind,i_T)));MaxU=max(MaxU,max(Tvitesse_th.u(ind,i_T)));
            MinV=min(MinV,min(Tvitesse_th.v(ind,i_T)));MaxV=max(MaxV,max(Tvitesse_th.v(ind,i_T)));
          figure(1),
          subplot(2,1,1),plot(t_th(ind),Tvitesse_th.u(ind,i_T),'.k')
          axis([min(t_th(ii)) max(t_th(ii)) MinU-50 MaxU+50])
          subplot(2,1,2),plot(t_th(ind),Tvitesse_th.v(ind,i_T),'.k')
          axis([min(t_th(ii)) max(t_th(ii)) MinV-50 MaxV+50])
          
          figure(j+1),quiver(GPSth(Tronc).xpas(ind)',-GPSth(Tronc).ypas(ind)',Tvitesse_th.u(ind,i_T)/ech,Tvitesse_th.v(ind,i_T)/ech,0,'b')
         
%% on efface tout :
          pause
          quiver(GPSth(Tronc).xpas',-GPSth(Tronc).ypas',u/ech,v/ech,0,'k')
          quiver(Y(i),X(i),u(i)/ech,v(i)/ech,0,'r')
          quiver(GPSth(Tronc).xpas(ind)',-GPSth(Tronc).ypas(ind)',Tvitesse_th.u(ind,i_T)/ech,Tvitesse_th.v(ind,i_T)/ech,0,'r')
          %A présent, il faut calculer les vitesses à l'instant t_M(ii(ind)) et
          %la représenter sur le dessin en tous points.
         end
      
         pause
      end 
   end
end
  

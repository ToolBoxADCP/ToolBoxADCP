load (MouillagePropre_proj)

P_M=P(1);
%% Initialisation :
      Tfile_th=[dfile_th(Tronc,:) num2str(1)];load (Tfile_th);
      load (Tfile_th)
i_T=1;
      prof=mean(P_M.depth)-dsurface_th(1,i_T);
      dh=Hcellule-prof;i_M=find(abs(dh)==min(abs(dh)))
      prof=Hcellule(i_M);

      ech=100000;dt=1/60/24;
load (MouillageAnalyse)
load (MouillageAnalyse_proj)


       figure(3),clf,axis('equal'),axis xy,hold on%axis(axe)
       echTemp=500;
for Tronc=1:nbTronc;
   disp('Tronçon :');disp(Tronc);
   load (Ftransth)
   load (point(Tronc,:))
   
   A=[dfile_th(Tronc,:) '*'];a=ls(A);NbTrans(Tronc)=size(a,1);
   disp('nb de transect :');disp(NbTrans);
   t_M=(datum_str(Temps)-T0)*3600*24;
     
   t_th=0:6*600:223*3600;
   ii=find(isnan(t_th)==0);
   if (size(ii,2)~=0)

%% Vitesse du mouillage sur tout le temps de la manip :
        VitMouillage.u=Vit_Mouillage(t_th(ii),prof,HarmoniqueU,Hcellule);
        VitMouillage.v=Vit_Mouillage(t_th(ii),prof,HarmoniqueV,Hcellule);
        VitesseMouillage=[VitMouillage.u VitMouillage.v];
        uM=sum(VitMouillage.u');
        vM=sum(VitMouillage.v');
        vitM=sum(VitesseMouillage);
        
          
        uM=uM';vM=vM';ii=ii';

%% Vitesses variables au cours du transect :

        for i=2:1:nbPoint-1;
% Vitesses interpolées :
   % Interpolation sur tout le transect à l'instant en question
            A=[];
            A.u=[];
            A.v=[];
            if(CouplVitesse==0)
               vect=ones(1,size(VitMouillage.u,2));
            else
               vect=ones(1,size(VitesseMouillage,2));
            end
            for deg=ImpVit_M:degPol;
               if(CouplVitesse==0)
                  A.u=[A.u ((GPSth(Tronc).dpas(i)-P0)/(LongTr/2)).^deg*ones(size(VitesseMouillage,1),1) ((GPSth(Tronc).dpas(i)-P0)/(LongTr/2)).^deg*VitMouillage.u];
                  A.v=[A.v ((GPSth(Tronc).dpas(i)-P0)/(LongTr/2)).^deg*ones(size(VitesseMouillage,1),1) ((GPSth(Tronc).dpas(i)-P0)/(LongTr/2)).^deg*VitMouillage.v];
               else
                  A.u=[A.u ((GPSth(Tronc).dpas(i)-P0)/(LongTr)).^deg*ones(size(VitesseMouillage,1),1) ((GPSth(Tronc).dpas(i)-P0)/(LongTr)).^deg*VitesseMouillage];
                  A.v=[A.v ((GPSth(Tronc).dpas(i)-P0)/(LongTr)).^deg*ones(size(VitesseMouillage,1),1) ((GPSth(Tronc).dpas(i)-P0)/(LongTr)).^deg*VitesseMouillage];
               end
            end

            u=CalcVitesse(C.u,A.v,degPol,ImpVit_M,NbOndes)+ImpVit_M*uM;
            v=CalcVitesse(C.v,A.v,degPol,ImpVit_M,NbOndes)+ImpVit_M*vM;
            [u,v]=ProjectionVitesse_surEllipse(u,v,-tetaMoy);
            figure(3),quiver(GPSth(Tronc).dpas(i)'*ones(size(t_th'))/100,ones(size(GPSth(Tronc).dpas(i)'))*t_th'/3600,u/echTemp,v/echTemp,0,'c')
        end

        [uM,vM]=ProjectionVitesse_surEllipse(uM,vM,-tetaMoy);
        figure(3),quiver(200*ones(size(t_th'))/100,t_th'/3600,uM/echTemp,vM/echTemp,0,'m')
        figure(3),quiver(700*ones(size(t_th'))/100,t_th'/3600,uM/echTemp,vM/echTemp,0,'c')
   end 
      
% Vitesses du transect :
   for j=1:NbTrans(Tronc);
      Tfile_th=[dfile_th(Tronc,:) num2str(j)];load (Tfile_th);
      load (Tfile_th)
      'dessin',mean(P_M.depth)
      prof=mean(P_M.depth)-dsurface_th(1,i_T);

      dh=Hcellule-prof;i_M=find(abs(dh)==min(abs(dh)))
      prof=Hcellule(i_M);
   
      t_th=(datum_str(T_Temps_th)-T0)*3600*24;

        [Tvitesse_th.u,Tvitesse_th.v]=ProjectionVitesse_surEllipse(Tvitesse_th.u,Tvitesse_th.v,-tetaMoy);
%     Usurf(ii,Jour)=P_vitesse_s(i).u(j,i_T)/1000;
%     Vsurf(ii,Jour)=P_vitesse_s(i).v(j,i_T)/1000;
%     UUU=Usurf(:,J);
%     iii=find(isnan(UUU)==0);
%     if(isempty(iii)==0),
%         J,iii(end),
%         [Usurf(iii(end),J),Vsurf(iii(end),J)],
%         [x(iii(end),J),t(iii(end),J)]
%     end
         figure(3),quiver(GPSth(Tronc).dpas'/100,t_th'/3600,Tvitesse_th.u(:,i_T)/echTemp,Tvitesse_th.v(:,i_T)/echTemp,0,'r')
             axis('equal'),axis xy,hold on
          t_th=(datum_str(T_Temps_th)-T0)*3600*24;
          figure(3),quiver(GPSth(Tronc).dpas'/100,t_th'/3600,Tvitesse_th.u(:,i_T)/echTemp,Tvitesse_th.v(:,i_T)/echTemp,0,'r')
             axis('equal'),axis xy,hold on

   end
end
  

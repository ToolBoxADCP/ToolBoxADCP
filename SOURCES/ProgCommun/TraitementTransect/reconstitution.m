
prof=5;
pasPoint=1;

load (point(Tronc,:))
load (Ftransth)
Ptr=P;
Ptr_adcp=P_adcp;
load (MouillageAnalyse)
load (MouillageAnalyse_proj)

load (MouillagePropre_proj)
U=NaN*ones(nbPoint,size(HarmoniqueU(1).temps,2),50);
V=U;T=V;X=T;
for nb=5:pasPoint:nbPoint;
    nb
    figure(1),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,axis(axe),hold on
    plot(Ptr(nb).long(:),-Ptr(nb).lat(:),'+r')
    plot(Mpr(Tronc).long,-Mpr(Tronc).lat,'ow')

B.prof=Ptr(nb).surface_s(:,:);
if(size(B.prof,2)>=1)
    'size',size(B.prof)
for i=1:1%size(Ptr(nb).surface_s,2);
    i
%for i=5:6;
      %prof=(ProfondeurMouillage-Ptr(nb).prof)+Ptr(nb).fond_s(1,i)
      prof=ProfondeurMouillage-Ptr(nb).surface_s(1,i)
      %prof=mean(P_M.depth)-Ptr(nb).surface_s(1,i),
      %dh=Hcellule-prof,i_M=find(abs(dh)==min(abs(dh)))
      %prof=Hcellule(i_M),
    VitMouillage.u=Vit_Mouillage(HarmoniqueU(1).temps*3600,prof,HarmoniqueU,Hcellule);
    VitMouillage.v=Vit_Mouillage(HarmoniqueV(1).temps*3600,prof,HarmoniqueV,Hcellule);
%     VitMouillage.u=Vit_Mouillage(t_th,prof*ones(size(t_th')),HarmoniqueU,Hcellule);
%     VitMouillage.v=Vit_Mouillage(t_th,prof,HarmoniqueV,Hcellule);
    VitesseMouillage=[VitMouillage.u VitMouillage.v];
    VitesseMouillageU=[VitMouillage.u 0*VitMouillage.v];

       A=[];
       A.u=[];
       A.v=[];
    vect=ones(1,size(VitesseMouillage,2));
  if(CouplVitesse==0)
    vect=ones(1,size(VitMouillage.u,2));
  else
    vect=ones(1,size(VitesseMouillage,2));
  end
    for deg=ImpVit_M:degPol;
      if(CouplVitesse==0)
        A.u=[A.u ((GPSth(Tronc).dpas(nb)-P0)/(LongTr/2)).^deg*VitMouillage.u];
        A.v=[A.v ((GPSth(Tronc).dpas(nb)-P0)/(LongTr/2)).^deg*VitMouillage.v];
      else
        A.u=[A.u ((GPSth(Tronc).dpas(nb)-P0)/(LongTr)).^deg*VitesseMouillage];
        A.v=[A.v ((GPSth(Tronc).dpas(nb)-P0)/(LongTr)).^deg*VitesseMouillage];
      end
    end
    
    u_M=sum(VitMouillage.u,2);
    v_M=sum(VitMouillage.v,2);
    [uM_proj,vM_proj]=ProjectionVitesse_surEllipse(u_M,v_M,-tetaMoy);
    vMReconstitution=vM_proj;
    uMReconstitution=uM_proj;
    
    B.prof=26.03-Ptr(nb).surface_s(:,i);
    B.u=P_vitesse_s(nb).u(:,i);
    B.v=P_vitesse_s(nb).v(:,i);
    t=(datum_str(P_temps(nb))-T0)*24*3600;
    ii=find(isnan(t)==0);
      vectX=ones(size(B.prof,1));
      t=t(ii);
      B.prof=B.prof(ii,:);
      B.u=B.u(ii,:);
      B.v=B.v(ii,:);
      vectX=ones(size(B.prof,1),1);
      vectY=ones(1,size(B.prof,2));
%     if(size(t,2)~=0),
%         u=griddata(t'*vectY,B.prof,B.u,t',prof*vectX,'nearest');
%         hold on,plot(t',u,'or')
%     end
    if(size(t,2)~=0),
%         load (MouillagePropre)
%         tt=(datum_str(Temps)-T0)*24*3600;
        figure(2*i+1),clf,
        subplot(2,1,1),hold on,% plot(tt,vitesse.u(:,floor(i)),'-b')
        axis([0 10 -3000 3000])
        subplot(2,1,2),hold on,% plot(tt,vitesse.u(:,floor(i)),'-b')
        axis([0 10 -3000 3000])
%         CC=ones(size(C.u));
%          u=A.u*CC;
%          v=A.v*CC;
%          subplot(2,1,1),plot(HarmoniqueU.temps(1,:)/3600/24,u,'m')
%          subplot(2,1,2),plot(HarmoniqueU.temps(1,:)/3600/24,v,'m')
%         u=A.u*C.u+sum(VitMouillage.u,2);
%         v=A.v*C.v+sum(VitMouillage.v,2);
        u=A.u*C.u+ImpVit_M*u_M;
        v=A.v*C.v+ImpVit_M*v_M;
           [u_proj,v_proj]=ProjectionVitesse_surEllipse(u,v,-tetaMoy);
     vReconstitution=v_proj;
     uReconstitution=u_proj;
       
        U(nb,:,i)=u;
        V(nb,:,i)=v;
        T(nb,:,i)=HarmoniqueU(1).temps;
        Tronc=1;
        X(nb,:,i)=GPSth(Tronc).dpas(nb)*ones(size(HarmoniqueU(1).temps));
        subplot(2,1,1),plot(HarmoniqueU(1).temps/3600/24,u_proj,'b')
        plot(HarmoniqueU(1).temps/3600/24,uM_proj,'r')
        subplot(2,1,2),plot(HarmoniqueU(1).temps/3600/24,v_proj,'b')
        plot(HarmoniqueU(1).temps/3600/24,vM_proj,'r')
%         u=griddata(t'*vectY,B.prof,B.u,t',prof*vectX,'nearest');

           [Utr,Vtr]=ProjectionVitesse_surEllipse(B.u,B.v,-tetaMoy);
        subplot(2,1,1),plot(t'/3600/24,Utr,'ok','LineWidth',4),grid,
        axis([0 10 -1000 1000])
        subplot(2,1,2),plot(t'/3600/24,Vtr,'ok','LineWidth',4),grid
        axis([0 10 -1000 1000])
%         figure(2*(i+1)),clf
%         subplot(2,1,1),plot(t'/3600/24,B.u,'ok','LineWidth',4),grid,
%         axis([0 10 -500 500])
%         subplot(2,1,2),plot(t'/3600/24,B.v,'ok','LineWidth',4),grid
%         axis([0 10 -500 500])

    end
end
pause
end
end

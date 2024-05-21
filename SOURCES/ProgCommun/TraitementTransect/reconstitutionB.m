prof=5;
pasPoint=3;

load (point(Tronc,:))
load (Ftransth)
Ptr=P;
Ptr_adcp=P_adcp;
load (MouillageAnalyse)
load (MouillageAnalyse_proj)


for nb=2:pasPoint:nbPoint;
    B.prof=26.03-P(nb).surface_s(:,:);
    figure(1),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,axis(axe),hold on
         plot(P(nb).long(:),-P(nb).lat(:),'+r')

for i=1:size(26.03-P(nb).surface_s,2);
%for i=5:6;
    prof=26.03-P(nb).surface_s(1,i);
    VitMouillage.u=Vit_Mouillage(HarmoniqueU(1).temps*3600,prof,HarmoniqueU,Hcellule,i);
    VitMouillage.v=Vit_Mouillage(HarmoniqueV(1).temps*3600,prof,HarmoniqueV,Hcellule,i);
        A.u=VitMouillage.u;
        A.v=VitMouillage.v;
    
    
    B.prof=26.03-P(nb).surface_s(:,i);
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
    if(size(t,2)~=0),
%         load (MouillagePropre)
%         tt=(datum_str(Temps)-T0)*24*3600;
        figure(i+1),clf,
        subplot(2,1,1),hold on,% plot(tt,vitesse.u(:,floor(i)),'-b')
        axis([0 10 -400 400])
        subplot(2,1,2),hold on,% plot(tt,vitesse.u(:,floor(i)),'-b')
        axis([0 10 -400 400])
        CC=ones(size(C.u(:,nb)));
        u=A.u*CC;
        v=A.v*CC;
        subplot(2,1,1),plot(HarmoniqueU(1).temps)/3600/24,u,'--r')
        subplot(2,1,2),plot(HarmoniqueU(1).temps/3600/24,v,'--r')
        u=A.u*C.u(:,nb);
        v=A.v*C.v(:,nb);
        subplot(2,1,1),plot(HarmoniqueU(1).temps/3600/24,u,'b')
        subplot(2,1,2),plot(HarmoniqueU(1).temps/3600/24,v,'b')
        %u=griddata(t'*vectY,B.prof,B.u,t',prof*vectX,'nearest');
        subplot(2,1,1),plot(t'/3600/24,B.u,'ok','LineWidth',4),
        subplot(2,1,2),plot(t'/3600/24,B.v,'ok','LineWidth',4),
    end
    
end
pause
end

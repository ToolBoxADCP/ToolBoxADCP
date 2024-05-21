DonneesCampagne('MS2')
load (point(Tronc,:))
load (Ftransth)
Ptr=P;
Ptr_adcp=P_adcp;

DonneesCampagne('MS1')
load (MouillageAnalyse)
load (MouillageAnalyse_proj)

load (MouillagePropre_proj)

profondeur=mean(P.depth)+hadcpM;
hcel=Hcellule;
t=(datum_str(Temps)-T0)*24*3600;

U=vitesse.u;V=vitesse.v;
[P.long,P.lat]=projection_ortho(PositionMouillage.long,-PositionMouillage.lat,p_TS(Tronc,1),p_TS(Tronc,2));
dpas=sqrt(((P.long-GPSth_Deb(Tronc).long)*dLong).^2+((P.lat-GPSth_Deb(Tronc).lat)*dLat).^2);
figure(1),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,axis(axe),hold on
         plot(P.long(:),-P.lat(:),'.r')
         plot(PositionMouillage.long,PositionMouillage.lat,'+r')
         
        fig=2*5+2;figure(fig),clf,
        subplot(2,1,1),hold on,HarmoniqueNondes('u',5)
        subplot(2,1,2),hold on,HarmoniqueNondes('v',5)

        DonneesCampagne('MS2')
load (MouillageAnalyse)
load (MouillageAnalyse_proj)
load (MouillagePropre_proj)
         plot(PositionMouillage.long,PositionMouillage.lat,'+w')


%for i=1:size(hcel,2);
for i=5;
    i
    prof=hcel(i)+ProfondeurMouillage-profondeur
    VitMouillage.u=Vit_Mouillage(HarmoniqueU(1).temps*3600,prof,HarmoniqueU,Hcellule);
    VitMouillage.v=Vit_Mouillage(HarmoniqueV(1).temps*3600,prof,HarmoniqueV,Hcellule);
    VitesseMouillage=[VitMouillage.u VitMouillage.v];
    VitesseMouillageU=[VitMouillage.u 0*VitMouillage.v];
    VitesseMouillageV=[0*VitMouillage.u VitMouillage.v];

    A=[];
    A.u=[];
    A.v=[];
%    vect=ones(1,size(VitMouillage.u,2));
     vect=ones(1,size(VitesseMouillage,2));
    for deg=0:degPol;
         A.u=[A.u ((dpas-P0)/(LongTr)).^deg*VitesseMouillage];
         A.v=[A.v ((dpas-P0)/(LongTr)).^deg*VitesseMouillage];
%        A.u=[A.u ((dpas-P0)/(LongTr)).^deg*VitMouillage.u];
%        A.v=[A.v ((dpas-P0)/(LongTr)).^deg*VitMouillage.v];
    end
    

%     u=A.u*C.u+sum(VitMouillage.u,2);
%     v=A.v*C.v+sum(VitMouillage.v,2);
    u=A.u*C.u;
    v=A.v*C.v;
    
        figure(fig),
        subplot(2,1,1),plot(HarmoniqueU(1).temps/3600/24,u,'b','LineWidth',2)
        subplot(2,1,2),plot(HarmoniqueU(1).temps/3600/24,v,'b','LineWidth',2)
DonneesCampagne('MS1')
        figure(fig),
        subplot(2,1,1),hold on,HarmoniqueNondes('u',5),axis([-22 -12 -750 750]),grid
        subplot(2,1,2),hold on,HarmoniqueNondes('v',5),axis([-22 -12 -750 750]),grid

        %         subplot(2,1,1),plot(t/3600/24,U(:,i),'.r'),axis([-24 -10 -750 750])
%         subplot(2,1,2),plot(t/3600/24,V(:,i),'.r'),axis([-24 -10 -750 750])
%         figure(2*(i+1)),clf,
%         subplot(2,1,1),hold on,
%         subplot(2,1,2),hold on,
% [Upr,Vpr]=projectionVitesse(u,v,GPSth_Deb(Tronc),GPSth_Fin(Tronc));
%         subplot(2,1,1),plot(HarmoniqueU.temps(1,:)/3600/24,Upr,'b')
%         subplot(2,1,2),plot(HarmoniqueU.temps(1,:)/3600/24,Vpr,'b')
% [Upr,Vpr]=projectionVitesse(U(:,i),V(:,i),GPSth_Deb(Tronc),GPSth_Fin(Tronc));
%         subplot(2,1,1),plot(t/3600/24,Upr,'.r'),axis([-24 -10 -750 750])
%         subplot(2,1,2),plot(t/3600/24,Vpr,'.r')
% axis([-24 10 -750 750])
end
DonneesCampagne('MS2')
load (MouillagePropre_proj)
t=datum_str(Temps)-T0;
        figure(fig),
        subplot(2,1,1),plot(t,vitesse.u(:,i),'-m','LineWidth',2)
        subplot(2,1,2),plot(t,vitesse.v(:,i),'-m','LineWidth',2)
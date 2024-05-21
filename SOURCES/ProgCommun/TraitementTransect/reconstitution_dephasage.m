if (strcmp(MouillageAnalyse,'./MouillageAnalyse/AnalyseMN_GP'))
    DonneesCampagne('MN2')
    load (MouillageAnalyse_proj)
    Pos_N2=PositionMouillage;
    HarmoniqueU_N2=HarmoniqueU;
    HarmoniqueV_N2=HarmoniqueV;
    HarmoniqueH_N2=HarmoniqueH;
    DonneesCampagne('MN1')
end
    
if (strcmp(Campagne,'Tulear1')==1&...
        strcmp(MouillageAnalyse,'./MouillageAnalyse/AnalyseMS2')==1)
    DonneesCampagne('MS1')
    load (MouillageAnalyse_proj)
    Pos_N2=PositionMouillage;
    HarmoniqueU_N2=HarmoniqueU;
    HarmoniqueV_N2=HarmoniqueV;
    HarmoniqueH_N2=HarmoniqueH;
    DonneesCampagne('MS2')
end


prof=5;
pasPoint=1;

load (point(Tronc,:))
load (Ftransth)
Ptr=P;
Ptr_adcp=P_adcp;
load (MouillageAnalyse)
load (MouillageAnalyse_proj)
load (MouillagePropre_proj)

Temps_jour=datum_str(Temps)-T0;
% U=NaN*ones(nbPoint,size(HarmoniqueU.temps,2),50);
% V=U;T=V;X=T;
for nb=5:pasPoint:nbPoint;
    nb
    figure(1),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,axis(axe),hold on
    plot(Ptr(nb).long(:),-Ptr(nb).lat(:),'+r')
    plot(PositionMouillage.long,PositionMouillage.lat,'or')
if (strcmp(Campagne,'Tulear1')==1&...
        strcmp(MouillageAnalyse,'./MouillageAnalyse/AnalyseMS2')==1)
    plot(Pos_N2.long,Pos_N2.lat,'om')
end
    plot(Mpr(Tronc).long,-Mpr(Tronc).lat,'ow')

B.prof=Ptr(nb).surface_s(:,:);
if(size(B.prof,2)>=1)
  for i=1:size(Ptr(nb).surface_s,2);
%% Calcul des vitesses :
% Variables nécessaires
     prof=ProfondeurMouillage-Ptr(nb).surface_s(1,i)
     VitMouillage.u=Vit_Mouillage(HarmoniqueU(1).temps'*3600,prof,HarmoniqueU,Hcellule);
     VitMouillage.v=Vit_Mouillage(HarmoniqueV(1).temps'*3600,prof,HarmoniqueV,Hcellule);

% Matrice A
     Point=((GPSth(Tronc).dpas(nb)-P0)/(LongTr))*ones(size(VitMouillage.u,1),1);
     A=CalculMatriceA(Point,VitMouillage,ImpVit_M,CouplVitesse,degPol);

% Vitesse au mouillage
     Mouil=CalculVitMouillage(VitMouillage);
     i_M=max(1,min(round(prof/celM),6));
if (strcmp(Campagne,'Tulear1')==1&...
        strcmp(MouillageAnalyse,'./MouillageAnalyse/AnalyseMS2')==1)
     Mouil_N1.u=VitesseCalculeeAvecHarmonique(NbOndes,HarmoniqueU(i_M),...
         HarmoniqueU(1).temps,T0);
     Mouil_N2.u=VitesseCalculeeAvecHarmonique(NbOndes,HarmoniqueU_N2(i_M),...
         HarmoniqueU(1).temps,T0);
     Mouil_N1.v=VitesseCalculeeAvecHarmonique(NbOndes,HarmoniqueV(i_M),...
         HarmoniqueU(1).temps,T0);
     Mouil_N2.v=VitesseCalculeeAvecHarmonique(NbOndes,HarmoniqueV_N2(i_M),...
         HarmoniqueU(1).temps,T0);
end

    
% Vitesse en transect
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

% Vitesse interpolé le long du transect 
    if(size(t,2)~=0),
        u=CalcVitesse(C.u,A.u,degPol,ImpVit_M,NbOndes)+ImpVit_M*Mouil.u;
        v=CalcVitesse(C.v,A.v,degPol,ImpVit_M,NbOndes)+ImpVit_M*Mouil.v;
    end
        
        
%% Dessins
% Projection sur les axes Nord-Sud: 
    if(size(t,2)~=0),
        [u_proj,v_proj]=ProjectionVitesse_surEllipse(u,v,-tetaMoy);
        [uM_proj,vM_proj]=ProjectionVitesse_surEllipse(Mouil.u,Mouil.v,-tetaMoy);

        [Utr_proj,Vtr_proj]=ProjectionVitesse_surEllipse(B.u,B.v,-tetaMoy);
        
%         U(nb,:,i)=u;
%         V(nb,:,i)=v;
%         T(nb,:,i)=HarmoniqueU.temps(1,:);
%         Tronc=1;
%         X(nb,:,i)=GPSth(Tronc).dpas(nb)*ones(size(HarmoniqueU.temps(1,:)));

%         load (MouillagePropre)
%         tt=(datum_str(Temps)-T0)*24*3600;

% Figure: 
        %figure(2*i+1),clf,
        figure(i+1),clf,
         subplot(2,1,1),hold on,plot(HarmoniqueU(1).temps/24,Mouil.u,':r')
         subplot(2,1,2),hold on,plot(HarmoniqueU(1).temps/24,Mouil.v,':r')
if (strcmp(Campagne,'Tulear1')==1&...
        strcmp(MouillageAnalyse,'./MouillageAnalyse/AnalyseMS2')==1)
         subplot(2,1,1),hold on,plot(HarmoniqueU(1).temps/24,Mouil_N1.u,'--m')
         subplot(2,1,2),hold on,plot(HarmoniqueU(1).temps/24,Mouil_N1.v,'--m')
         subplot(2,1,1),hold on,plot(HarmoniqueU(1).temps/24,Mouil_N2.u,'--c')
         subplot(2,1,2),hold on,plot(HarmoniqueU(1).temps/24,Mouil_N2.v,'--c')
res=interp1(HarmoniqueU_N2(1).temps,HarmoniqueU_N2(1).res,HarmoniqueU(1).temps);
subplot(2,1,1),hold on,plot(HarmoniqueU(1).temps/24,Mouil_N2.u+res,'g')
res=interp1(HarmoniqueU_N2(1).temps,HarmoniqueV_N2(1).res,HarmoniqueU(1).temps);
subplot(2,1,2),hold on,plot(HarmoniqueU(1).temps/24,Mouil_N2.v+res,'g')
end

 if (strcmp(MouillageAnalyse,'./MouillageAnalyse/AnalyseMN_GP'))
     [XXX,jj]=min(abs(Hcellule-prof));

     Harm=HarmoniqueU_N2(jj);
     u_N2=vitesseCalculeeAvecHarmonique(NbOndes,Harm,HarmoniqueU(1).temps,T0);
     Ures_N2=interp1(Harm.temps,Harm(1).res,HarmoniqueU(1).temps);
        subplot(2,1,1),plot(HarmoniqueU(1).temps/24,u_N2+Ures_N2,'--c')
         
     Harm=HarmoniqueV_N2(jj);
     v_N2=vitesseCalculeeAvecHarmonique(NbOndes,Harm,HarmoniqueV(1).temps,T0);
     Vres_N2=interp1(Harm.temps,Harm(1).res,HarmoniqueV(1).temps);
        subplot(2,1,2),plot(HarmoniqueV(1).temps/24,v_N2+Vres_N2,'--c')
 end
       subplot(2,1,1),plot(HarmoniqueU(1).temps/24,u,'b')

        for ii=1:size(B.u);
            pict='ok';
            jj=find(HarmoniqueU(1).temps(1:end-1)<t(ii)/3600&HarmoniqueU(1).temps(2:end)>t(ii)/3600);
            if(abs(B.u(ii)-u(jj))>50),
                pict='om';
            end
            plot(t(ii)'/3600/24,B.u(ii),pict,'LineWidth',4),grid
        end
%         plot(t'/3600/24,B.u,'ok','LineWidth',4),grid,
       axis([0 10 -1000 1000])
if (strcmp(Campagne,'Tulear1')==1&...
        strcmp(MouillageAnalyse,'./MouillageAnalyse/AnalyseMS2')==1)
        axis([-24 -12 -1000 1000])
end

        subplot(2,1,2),
        plot(HarmoniqueU(1).temps/24,v,'b')
        for ii=1:size(B.v);
            pict='ok';
            jj=find(HarmoniqueV(1).temps(1:end-1)<t(ii)/3600&HarmoniqueV(1).temps(2:end)>t(ii)/3600);
            if(abs(B.v(ii)-v(jj))>50),
                pict='om';
            end
            plot(t(ii)'/3600/24,B.v(ii),pict,'LineWidth',4),grid
        end
        axis([0 10 -1000 1000])
if (strcmp(Campagne,'Tulear1')==1&...
        strcmp(MouillageAnalyse,'./MouillageAnalyse/AnalyseMS2')==1)
        axis([-24 -12 -1000 1000])
end
    end
end
pause
end
end

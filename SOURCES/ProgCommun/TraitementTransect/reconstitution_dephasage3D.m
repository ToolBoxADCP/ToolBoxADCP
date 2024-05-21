Tfile_th=[dfile_th(Tronc,:) num2str(1)];load (Tfile_th);
[col,ligne]=size(Tvitesse_th.u)

if (strcmp(MouillageAnalyse,'./MouillageAnalyse/AnalyseMN_GP'))
    DonneesCampagne('MN2')
    load (MouillageAnalyse_proj)
    Pos_N2=PositionMouillage;
    HarmoniqueU_N2=HarmoniqueU;
    HarmoniqueV_N2=HarmoniqueV;
    HarmoniqueH_N2=HarmoniqueH;
    DonneesCampagne('MN1')
end
    


pasPoint=1;

load (point(Tronc,:))
load (Ftransth)
Ptr=P;
Ptr_adcp=P_adcp;
load (MouillageAnalyse)
load (MouillageAnalyse_proj)
load (MouillagePropre_proj)

Temps_jour=datum_str(Temps)-T0;
Temps=HarmoniqueU(1).temps(200);


U=NaN*ones(col,ligne);
V=NaN*ones(col,ligne);
for nb=1:pasPoint:nbPoint;

B.prof=Ptr(nb).surface_s(:,:);
nb
if(size(B.prof,2)>=1)
  for i=1:size(Ptr(nb).surface_s,2);
%% Calcul des vitesses :
% Variables nécessaires
     prof=ProfondeurMouillage-Ptr(nb).surface_s(1,i);
     VitMouillage.u=Vit_Mouillage(Temps*3600,prof,HarmoniqueU,Hcellule);
     VitMouillage.v=Vit_Mouillage(Temps*3600,prof,HarmoniqueV,Hcellule);
% Matrice A
     Point=((GPSth(Tronc).dpas(nb)-P0)/(LongTr))*ones(size(VitMouillage.u,1),1);
     A=CalculMatriceA(Point,VitMouillage,ImpVit_M,CouplVitesse,degPol);

% Vitesse au mouillage
     Mouil=CalculVitMouillage(VitMouillage);
    
% Vitesse en transect
ProfondeurMouillage=mean(P.depth)+hadcpM;

     B.prof=ProfondeurMouillage-Ptr(nb).surface_s(:,i);
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

% Vitesse interpolé le long du transect 
    if(size(t,2)~=0),
        U(nb,i)=CalcVitesse(C.u,A.u,degPol,ImpVit_M,NbOndes)+ImpVit_M*Mouil.u;
        V(nb,i)=CalcVitesse(C.v,A.v,degPol,ImpVit_M,NbOndes)+ImpVit_M*Mouil.v;
    end    
end
end
end

% subplot(1,2,1),pcolor(T_ADCPpr.dp'/1000,-dsurface',U'),colorbar('horiz')
% subplot(1,2,2),pcolor(T_ADCPpr.dp'/1000,-dsurface',V'),colorbar('horiz')
subplot(1,2,1),pcolor(U'),colorbar('horiz')
subplot(1,2,2),pcolor(V'),colorbar('horiz')


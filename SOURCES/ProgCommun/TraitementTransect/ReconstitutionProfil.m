% Tfile_th=[dfile_th(Tronc,:) num2str(1)];load (Tfile_th);
[col,ligne]=size(Tvitesse_th.u);

%function []=ReconstitutionProfil(Temps)
% Temps_jour=datum_str(Temps)-T0;
%Temps=HarmoniqueU(1).temps(200);


pasPoint=1;

load (point(Tronc,:))
load (Ftransth)
Ptr=P;
Ptr_adcp=P_adcp;
load (MouillageAnalyse)
load (MouillageAnalyse_proj)
load (MouillagePropre_proj)

U=NaN*ones(col,ligne);
V=NaN*ones(col,ligne);
surface_interp=NaN*ones(col,ligne);
for nb=1:pasPoint:nbPoint;
  if(size(Ptr(nb).surface_s,2)>=1)
     for i=1:size(Ptr(nb).surface_s,2);
%%      Calcul des vitesses :
%       Variables nécessaires
if(mean(P.depth)==100)
    ProfondeurMouillage=8;
else
    ProfondeurMouillage=mean(P.depth)+hadcpM;
end
        prof=ProfondeurMouillage-Ptr(nb).surface_s(1,i);
        surface_interp(nb,i)=Ptr(nb).surface_s(1,i);%surface_interp(nb,i)%;
        VitMouillage.u=Vit_Mouillage(Temps_interp*3600,prof,HarmoniqueU,Hcellule);
        VitMouillage.v=Vit_Mouillage(Temps_interp*3600,prof,HarmoniqueV,Hcellule);

        % Matrice A
        Point=((GPSth(Tronc).dpas(nb)-P0)/(LongTr))*ones(size(VitMouillage.u,1),1);
        A=CalculMatriceA(Point,VitMouillage,ImpVit_M,CouplVitesse,degPol);

        % Vitesse au mouillage
        Mouil=CalculVitMouillage(VitMouillage);
    
        % Vitesse interpolé le long du transect 
        if(size(t,2)~=0),
          U(nb,i)=CalcVitesse(C.u,A.u,degPol,ImpVit_M,NbOndes)+ImpVit_M*Mouil.u;
          V(nb,i)=CalcVitesse(C.v,A.v,degPol,ImpVit_M,NbOndes)+ImpVit_M*Mouil.v;
        end    
     end
  end
end

[cap,module]=uv2dirspeed(V,U);cap=mod(cap+tetaMoy*180/pi,360);
% subplot(1,2,1),pcolor(GPSth(Tronc).dpas'/1000,-dsurface_th',cap'),colorbar('horiz')
% subplot(1,2,2),pcolor(GPSth(Tronc).dpas'/1000,-dsurface_th',module'),colorbar('horiz')


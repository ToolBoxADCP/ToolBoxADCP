pasPoint=1;
col=length(P);
ligne=length(P(1).DiscrVert);
nbTemps=size(HarmoniqueU(1).temps,1);
U=NaN*ones(nbTemps,col,ligne);
V=NaN*ones(nbTemps,col,ligne);

%% Calcul du flux et des vitesses point par point
for nb=1:pasPoint:nbPoint;          %nbPoint=size(P,2);
  B.prof=P(nb).surface_s(:,:);H(nb)=P(nb).prof;
  if(size(B.prof,2)>=1)
     clear flux
     disp(nb)%size(P(nb).surface_s,2)
     for i=1:size(P(nb).surface_s,2);
        prof=ProfondeurMouillage-P(nb).surface_s(1,i);
        VitMouillage.u=Vit_Mouillage(HarmoniqueU(1).temps'*3600,prof,HarmoniqueU,Hcellule);
        VitMouillage.v=Vit_Mouillage(HarmoniqueV(1).temps'*3600,prof,HarmoniqueV,Hcellule);
        VitesseMouillage=[VitMouillage.u VitMouillage.v];

        Point=((GPSth(Tronc).dpas(nb)-P0)/(LongTr))...
            *ones(size(VitMouillage.u,1),1);
        A=CalculMatriceA(Point,VitMouillage,ImpVit_M,CouplVitesse,degPol);
    
        % Vitesse au mouillage
        Mouil=CalculVitMouillage(VitMouillage);

        if(size(t,2)~=0),
          U(:,nb,i)=CalcVitesse(C.u,A.u,degPol,ImpVit_M,NbOndes)+ImpVit_M*Mouil.u;
          V(:,nb,i)=CalcVitesse(C.v,A.v,degPol,ImpVit_M,NbOndes)+ImpVit_M*Mouil.v;
        end
     end
   end
end
Tr_reconst.dpas=GPSth(Tronc).dpas;
Tr_reconst.z=-P(1).DiscrVert;
Tr_reconst.Temps=HarmoniqueU(1).temps;
Tr_reconst.U=U;
Tr_reconst.V=V;


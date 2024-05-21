
prof=5;
pasPoint=1;

load (Ftransth)
load (MouillageAnalyse_proj)

load (point(Tronc,:))
Ptr=P;

load(VitReconst(Tronc,:))

%% Initialisation :
col=length(Ptr);
ligne=length(Ptr(1).DiscrVert);
nbTemps=size(HarmoniqueU(1).temps,1);
FluxSection.u=zeros*ones(nbTemps,col);
FluxSection.v=zeros*ones(nbTemps,col);
FluxSectionTot.u=zeros*ones(col,1);
FluxSectionTot.v=zeros*ones(col,1);

Section=zeros(nbTemps,col);
H=zeros(col,1);
nbPoint=size(Tr_reconst.U,2);

%% Calcul du niveau
if (strcmp(Pression,'Non  ')==1)
  load('./MouillagePropre/MNpr');
else
  load (MouillagePropre)    
end
Niv=detrend(P.depth);    
t_niv=((datum_str(Temps)-T0))*24;
Niv_M=interp1(t_niv,Niv,Tr_reconst.Temps);


%% Calcul du flux et des vitesses point par point
for nb=2:pasPoint:nbPoint;          %nbPoint=size(P,2);
  H(nb)=Ptr(nb).prof;
  if(size(Ptr(nb).surface_s(:,:),2)>=1)
      Section(:,nb)=(GPSth(Tronc).dpas(nb)-GPSth(Tronc).dpas(nb-1))...
                 *(Ptr(nb).prof+Niv_M);
      plot(GPSth(Tronc).xpas(nb),-GPSth(Tronc).ypas(nb),'.w')
      
      FluxSection.u(:,nb)=Section(:,nb).*nanmean(Tr_reconst.U(:,nb,:),3)/1000;
      FluxSection.v(:,nb)=Section(:,nb).*nanmean(Tr_reconst.V(:,nb,:),3)/1000;
      FluxSection.temps=Tr_reconst.Temps;
   end
end
      FluxSectionTot.u=nanmean(FluxSection.u,1);
      FluxSectionTot.v=nanmean(FluxSection.v,1);
      FluxSectionTot.temps=Tr_reconst.Temps;
      
      Flux.u=sum(FluxSection.u,2);
      Flux.v=sum(FluxSection.v,2);
      Flux.temps=Tr_reconst.Temps;


%% Sauvegarde
save(FluxReconst(Tronc,:),'Flux','Section','FluxSectionTot','FluxSection','tetaMoy')

%% Dessin
DessinReconstitutionFlux

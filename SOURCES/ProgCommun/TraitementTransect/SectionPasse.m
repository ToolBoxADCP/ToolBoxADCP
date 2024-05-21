
load(point(Tronc,:))
clear H;for nb=1:NbPoints;H(nb)=P(nb).prof;end
plot(GPSth(1).dpas,-H,'--.r')
DX=diff(GPSth(1).dpas);Hm=(H(1:end-1)+H(2:end))/2;
int=sum(DX(2:end).*Hm(2:end));

load(MouillagePropre)
%int_Maree=int*ones(size(P.depth));%+(GPSth(1).dpas(end)-GPSth(1).dpas(2))*detrend(P.depth);
int_Maree=int+(GPSth(1).dpas(end)-GPSth(1).dpas(2))*detrend(P.depth);
max(int_Maree);min(int_Maree);
2*(max(int_Maree)-min(int_Maree))/(max(int_Maree)+min(int_Maree))*100;

load(MouillageAnalyse)
Flux=nanmean(Projection.u/1000.*(int_Maree*ones(1,size(Projection.u,2)))) %section=profondeur*largeur
FluxVit=Projection.u;
[Upr,Vpr]=projectionVitesse(vitesse.u/1000,vitesse.v/1000,GPSth_Deb(Tronc),GPSth_Fin(Tronc));

Flux2=nanmean(Upr.*(int_Maree*ones(1,size(Upr,2)))); %normale au transect * section
Flux3=nanmean(Vpr.*(int_Maree*ones(1,size(Vpr,2)))); %normale au transect * section
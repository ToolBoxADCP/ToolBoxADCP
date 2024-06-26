
load (Ftransth)

load (point(Tronc,:))
Ptr=P;

load(VitReconst(Tronc,:))
load(FluxReconst(Tronc,:))


%% Dessin
% Fleches
%% Dessin du transect :
T1.long=GPSth_Deb(Tronc).long;T1.lat=-GPSth_Deb(Tronc).lat;
T2.long=GPSth_Fin(Tronc).long;T2.lat=-GPSth_Fin(Tronc).lat;

figure,clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on,axis(axe)
plot(T1.long,T1.lat,'+r'),hold on,plot(T2.long,T2.lat,'+m'),
plot(PositionMouillage.long,PositionMouillage.lat,'og')
[cap,module]=uv2dirspeed((FluxSectionTot.v),(FluxSectionTot.u));
[fl.v,fl.u]=dir2uv(cap+tetaMoy*180/pi,module);
quiver(GPSth(Tronc).xpas,-GPSth(Tronc).ypas,fl.u,fl.v,4)

figure
H=[];for i=1:length(Ptr);H(i)=P(i).prof;end
plot(GPSth(Tronc).dpas,FluxSectionTot.u,GPSth(Tronc).dpas,-H)

figure
Acris.u=squeeze((nanmean(Tr_reconst.U(:,:,:),1)/1000));
Acris.v=squeeze((nanmean(Tr_reconst.V(:,:,:),1)/1000));
[cap,module]=uv2dirspeed((Acris.v),(Acris.u));
cap=mod(cap+tetaMoy*180/pi,360);
subplot(1,2,1),
  pcolor(Tr_reconst.dpas,Tr_reconst.z,cap')
  colorbar('horiz')
  title('Cap')
subplot(1,2,2),
  pcolor(Tr_reconst.dpas,Tr_reconst.z,module')
  colorbar('horiz')
  title('Flux (m/s)')

% for i_z=length(Tr_reconst.z):-1:1;
%     figure,clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on,axis(axe)
%     [fl.v,fl.u]=dir2uv(cap+tetaMoy*180/pi,module);
%     quiver(GPSth(Tronc).xpas(end-10:end)',...
%         -GPSth(Tronc).ypas(end-10:end)',...
%         ech*fl.u(end-10:end,i_z),ech*fl.v(end-10:end,i_z),4)    
%     quiver(PositionMouillage.long,...
%         PositionMouillage.lat,...
%         nanmean(vitesse.u(:,max(1,24-i_z))),nanmean(vitesse.v(:,max(1,24-i_z))),4,'r')    
% end
        

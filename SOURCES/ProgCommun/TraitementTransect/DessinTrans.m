figure (3),clf
figure(2),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,axis(axe),hold on
     plot(fGPSi.long,-fGPSi.lat,'.-r')
     plot(fGPSr.long,-fGPSr.lat,'.-m')
     plot(GPSth(Tronc).long,-GPSth(Tronc).lat,'b')
%subplot(2,1,1),plot(GPSth(Tronc).xpas,-GPSth(Tronc).ypas,'*m')
figure(3),hold on,plot(GPSth(Tronc).dpas,0*ones(size(GPSth(Tronc).dpas)),'.-m')

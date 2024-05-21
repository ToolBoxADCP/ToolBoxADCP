%function DessinFluxTot(u,v,tetaMoy)

ech=.25E-3;pas_des=3;
fichTransect='./DessinRobert/Flux';
%close all
figure,,image(Ylong,Xlat,Photo),axis('equal'),axis xy,
hold on


Tronc=1;
for ind = 1:size(ind_ref,1);i=ind_ref(ind);
  Nom(i,:),  DonneesCampagne(Nom(i,:))%,pause
    load(FluxReconst(Tronc,:))
    load (Ftransth)
tetaMoy,pause

% Dessin    
    [cap,module]=uv2dirspeed((FluxSectionTot.v),(FluxSectionTot.u));
    [fl.v,fl.u]=dir2uv(cap+tetaMoy*180/pi,module);
    ii=1:pas_des:length(GPSth(Tronc).xpas);
    if (strcmp(Campagne,'Tulear1')==1&strcmp(Nom(i,:),'MN ')==1)
      ii=1:min(pas_des,2):length(GPSth(Tronc).xpas)-1;
    end

    quiver(GPSth(Tronc).xpas(:,ii),...
        -GPSth(Tronc).ypas(:,ii),...
        ech*fl.u(:,ii),ech*fl.v(:,ii),0,'b')    
end
    xlabel('longitude');
    ylabel('latitude');
    title(Campagne)
    
  fichM=[fichTransect];
  
  saveas(gcf,fichM,'fig')
  saveas(gcf,fichM,'png')

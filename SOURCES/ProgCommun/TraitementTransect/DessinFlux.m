function DessinFlux(Pos,Vit,tetaMoy,ech,Fich,titre)
GlobaleVar
figure,image(Ylong,Xlat,Photo),axis('equal'),axis xy,
hold on

pas_des=3;

DessinTransect_loc
index=1;
for ind = 1:size(ind_ref,1);i=ind_ref(ind);
    DonneesCampagne(Nom(i,:))
    
    for Tronc=1:nbTronc;

    % Dessin    
        [cap,module]=uv2dirspeed(Vit(index).v,Vit(index).u);
        [fl.v,fl.u]=dir2uv(cap+tetaMoy(index)*180/pi,module);
        ii=1:pas_des:length(Pos(index).x);
        coul='b';
        if (strcmp(Campagne,'Tulear1')==1&i==3)
          ii=1:min(pas_des,2):length(Pos(index).x)-1;
        end
        if (strcmp(Campagne,'Mayotte1')==1&i==4)
            coul='r';
        end
        if (Tronc~=1)
          ii=1:2:length(Pos(index).x);
          coul='w';
        end

        quiver(Pos(index).x(:,ii),...
            -Pos(index).y(:,ii),...
            ech*fl.u(:,ii),ech*fl.v(:,ii),0,coul)    
        index=index+1;
    end
end
    xlabel('longitude');
    ylabel('latitude');
    title([Campagne ' - Flux ' titre])
    if strcmp(Campagne,'Tulear1'),axis([43.45 43.85 -23.6 -23.2]),end
    if strcmp(Campagne,'Mayotte1'),axis([45.05 45.35 -12.85 -12.6]),end
        
    
  fichM=[Fich];
  
  saveas(gcf,fichM,'fig')
  saveas(gcf,fichM,'png')

fichTransect='.\DessinRobert\Transect\';

clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,
hold on
for i = 1:size(Nom,1);
      DonneesCampagne(Nom(i,:))
if(~isempty(Ftransth))
      load (GPStrans)

load (Ftransth)
for Tronc=1:nbTronc;
    indnan=find(isnan(fGPSi.long)==0 & Troncon(Tronc,:)'==Tronc);
    plot(GPSi.long(indnan),-GPSi.lat(indnan),'.r')
    plot(GPSth(Tronc).xpas,-GPSth(Tronc).ypas)
end
load(MouillageMoy)
plot(PositionMouillage.long,PositionMouillage.lat,'+r')
plot([PositionMouillage.long PositionMouillage.long+0.02*cos(tetaMoy)],...
    [PositionMouillage.lat PositionMouillage.lat+0.02*sin(tetaMoy)],'w')
plot([PositionMouillage.long PositionMouillage.long+0.02*sin(tetaMoy)],...
    [PositionMouillage.lat PositionMouillage.lat-0.02*cos(tetaMoy)],'w')

axis(axe)

  fichM=[fichTransect ...
      num2str(char(cellstr(Nom(i,:)))) ];
  
  saveas(gcf,fichM,'fig')
  saveas(gcf,fichM,'png')
end
end
axis(axe_glob)  
fichM=[fichTransect ...
      'carte' ];
  saveas(gcf,fichM,'fig')
  saveas(gcf,fichM,'png')

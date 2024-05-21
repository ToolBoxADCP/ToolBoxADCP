ech=25000;%ech=2500;
figure(3),clf
if(exist('Photo','var')) & (isempty(Photo)==0)
   image(Ylong,Xlat,Photo),
end
axis('equal'),axis xy,hold on
for i = 1:size(Nom,1);
  DonneesCampagne(Nom(i,:));Nom(i,:)
   load (MouillageAnalyse)
      N=MaxProf(Nom(i,:));
      dn=floor((N-1)/2);
   plot(PositionMouillage.long,PositionMouillage.lat,'.r')
   DessinEllipse(Ellipse(:,1),1,'w',ech...
       ,PositionMouillage.long,PositionMouillage.lat)
   DessinEllipse(Ellipse(:,1+dn),1+dn,'c',ech...
       ,PositionMouillage.long,PositionMouillage.lat)
   DessinEllipse(Ellipse(:,N),N,'m',ech...
       ,PositionMouillage.long,PositionMouillage.lat)
end
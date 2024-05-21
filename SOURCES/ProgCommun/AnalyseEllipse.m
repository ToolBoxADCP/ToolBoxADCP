Projection=[];
NivMax=MaxProf(vitesse);

for niv=1:NivMax;
  [Ellipse(niv) Pr]=ellipse(niv);
  Projection.u(:,niv)=Pr.u; 
  Projection.v(:,niv)=Pr.v;  
  %pause
end


load (MouillagePropre)
      clear HarmoniqueU HarmoniqueV 
      Projection=[];
      tetaMoy=0;iMoy=0;
for i=1:size(vitesse.u,2);
  if (sum(isnan(vitesse.u(:,i)))<length(vitesse.u(:,i))*0.1)
    [Ellipse(i) Pr]=ellipse(i);
      tetaMoy=tetaMoy+Ellipse(i).teta;
      iMoy=i+1;
      Projection.u(:,i)=Pr.u; 
      Projection.v(:,i)=Pr.v;
    HarmoniqueU(i)=HarmoniqueNondes('u',i);
      correlation(i).u=Harm.r;
    HarmoniqueV(i)=HarmoniqueNondes('v',i);
      correlation(i).v=Harm.r;
    Hcellule(i)=blankM+hadcpM+(i-1)*celM;
    
    %i,pause

    
  end
end
tetaMoy=tetaMoy/iMoy
for ii=1:size(correlation,2),i(ii)=correlation(ii).u;j(ii)=correlation(ii).v;end
disp('Correlation :'),[i' j']

save (MouillageAnalyse,'tetaMoy','Temps','Ellipse','Projection','HarmoniqueU','HarmoniqueV','Hcellule')


load(MouillageAnalyse)
clear Temps Ellipse Projection HarmoniqueU HarmoniqueV Hcellule
load (MouillagePropre)
      HarmoniqueU=[];
      HarmoniqueV=[];
for i=1:size(vitesse.u,2);
  if (sum(isnan(vitesse.u(:,i)))<length(vitesse.u(:,i))*0.1)
    HarmoniqueU(i)=HarmoniqueNondes('U_p',i);
      correlation(i).u=Harm.r;
    HarmoniqueV(i)=HarmoniqueNondes('V_p',i);
    correlation(i).v=Harm.r;
    Hcellule(i)=blankM+hadcpM+(i-1)*celM;
    
    %i,pause

    
  end
end
for ii=1:size(correlation,2),i(ii)=correlation(ii).u;j(ii)=correlation(ii).v;end
disp('Correlation :'),[i' j']

save (MouillageAnalyse_proj,'tetaMoy','Temps','HarmoniqueU','HarmoniqueV','Hcellule')


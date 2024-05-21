function [t,u,up]=ResiduelleCalcul(MouillageAnalyse,T0,i);

load (MouillageAnalyse)
u=HarmoniqueH.res;
t=HarmoniqueH.temps-T0*24;
if (strcmp(Campagne,'Mayotte1')==1),
   if (i==3), u=u(467:7921);t=t(467:7921);end
end
for ind=1:2
  a=HarmoniqueH.lin(ind);
  u=u+a.*((t).^(ind-1));
end
    
% 'Harmonique',HarmoniqueH.ampl,
%sum(HarmoniqueH.ampl)
up=u/sum(HarmoniqueH.ampl)*100;
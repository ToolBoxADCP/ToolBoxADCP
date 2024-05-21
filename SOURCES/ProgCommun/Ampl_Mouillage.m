function [Ampl]=Ampl_Mouillage(prof,Harmonique,Hcellule,ii);
GlobaleVar

I=1;
Harm=[];
vit=[];
i=round(prof/celM);

HcMin=min(Hcellule);HcMax=max(Hcellule);
prof=max(prof,HcMin);prof=min(prof,HcMax); % pour éviter les NaN dus aux depassement de prof
u1=0;u2=0;u=0;
for k =1:size(HarmoniqueU,2),
  ampl(k,:)=HarmoniqueU(k).ampl
  phase(k,:)=HarmoniqueU(k).phase
end
for ind=1:NbOndes;
  Harm.ampl=interp1(Hcellule,ampl(:,ind),prof);
  Harm.phase=interp1(Hcellule,phase(:,ind),prof);
  om=Harmonique.omega(1,ind);
  vit(:,I)=Harm.ampl;I=I+1;
  vit(:,I)=0;I=I+1;
end

vit(:,I)=1;
I=I+1;

u=0;
for ind=1:1%2
  vit(:,I)=1;I=I+1;
end


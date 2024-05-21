t=(0:360:3600*24*20)';
VitMouillage.u=Vit_Mouillage(t,16*ones(size(t)),HarmoniqueU,Hcellule);
VitMouillage.v=Vit_Mouillage(t,16*ones(size(t)),HarmoniqueV,Hcellule);
Mouil=CalculVitMouillage(VitMouillage);

subplot(2,1,1),plot(t/3600/24,Mouil.u,'r')
subplot(2,1,2),plot(t/3600/24,Mouil.v,'r')
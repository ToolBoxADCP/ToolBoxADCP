figure(3),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on

for i = 1:size(Nom,1);
  DonneesCampagne(Nom(i,:))
  load (MouillagePropre)
  Harm_h=HarmoniqueNondes('h');
  Harm_h.phase*180/pi;
  Harm_U=HarmoniqueNondes('Upr');
  Harm_U.phase*180/pi;
  Harm_V=HarmoniqueNondes('Vpr');
  Harm_V.phase*180/pi;
  Nom(i,:)
  'dephasage:'
  (Harm_h.phase-Harm_U.phase)./Harm_U.omega
  (Harm_h.phase-Harm_V.phase)./Harm_U.omega
end
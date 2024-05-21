stickplotMPP_loc
close all
Nb_maille=eval(input('nb de stickplot par mouillage=','s'));

fichCommun='.\Images\StickPlot\Stk_';
fich_end=['_NbMaille' num2str(Nb_maille)]

for i = 1:size(Nom,1);
  fich=[num2str(fichCommun) num2str(char(cellstr(NomFig(fig(i),:)))) num2str(fich_end)]
  DonneesCampagne(Nom(i,:))
  load(MouillagePropre)
  time1=(datum_str(Temps)-T0)*24*3600;% en secondes
  
  Vitesse_loc=vitesse;
  time_loc=time1;
  dt=min(diff(time1));nb_i=DT/dt
  
  
  echG=echG_t(i);ech=ech_t(i);nb_i
  figure(fig(i)),subplot(2,1,nfig(i)),StickplotSerieVert
  title(Nom(i,:)),axis equal
  axis([Xmin(i) Xmax(i) Ymin(i) Ymax(i)])
  box on
  saveas(gcf,fich,'fig')
  saveas(gcf,fich,'png')
end

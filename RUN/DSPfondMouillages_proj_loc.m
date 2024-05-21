   Fig=[1,1,2,2,1,2,3,3,3];
   c=['c';'k';'c';'k';'g';'g';'c';'k';'g'];
   leg=[1,2];
   Fig_leg=2;
   
   Tmin=[1,1,1,1,1,1,1,1,1];
   Tmax=[100;100;100;100;100;100;100;100;100;100];
   Umin_loc=-1000;Umax_loc=500;
   Vmin_loc=-200;Vmax_loc=150;

 
   %Premier dessin (en dehors du mouillage centre ou barri�re)
   xmin1_loc=1E-5; xmax1_loc=2E-4;
   ymin1_loc=1E2; ymax1_loc=1E8;
 
   %Deuxieme dessin (mouillage centre ou barri�re)
   xmin2_loc=0; xmax2_loc=2E-4;
   ymin2_loc=0; ymax2_loc=1E8;
   
   %Troisieme dessin /Figure 2 (peridogramme vitesse ORTHO)
   xmin3_loc=0; xmax3_loc=2E-4;
   ymin3_loc=0; ymax3_loc=6E5;

subplot(3,1,1)
legend(char(Nom(1,:)),char(Nom(2,:)),char(Nom(5,:)),'location','best')
subplot(3,1,2)
legend(char(Nom(3,:)),char(Nom(4,:)),char(Nom(6,:)),'location','best')
subplot(3,1,3)
legend(char(Nom(7,:)),'location','best')
%legend(char(Nom(7,:)),char(Nom(8,:)),char(Nom(9,:)),'location','best')


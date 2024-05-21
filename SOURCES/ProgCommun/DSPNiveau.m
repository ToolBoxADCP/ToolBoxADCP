./DSPNiveau_loc
%GlobaleVar

%Fig=[2,3,1,1];
Fig=[1,1,1,1];
c=['--r';'-.b';':k ';'c  '];

fichCommun='.\Images\Periodogramme\Niveau';
fich=[num2str(fichCommun)];
fichLog=[num2str(fichCommun) num2str('_log')];

close all

leg=[];
for i = 1:size(Nom,1);
%for i = 3;
%% Travail dans la boucle

% lecture des variables
    Nom(i,:),DonneesCampagne(Nom(i,:))

% Dessin
  if (strcmp(Pression,'Non  ')==0),
      leg=[leg i];
      
    [sortie,f]=PeriodogrammeMouillage(5,'h');

    figure(4),subplot(3,1,Fig(i))
    loglog(f,sortie,c(i,:))
    axis([xmin1_loc xmax1_loc ymin1_loc ymax1_loc]),hold on,
    box on,grid on

    figure(3)
    plot(f,sortie,c(i,:))
    axis([xmin2_loc xmax2_loc ymin2_loc ymax2_loc]),hold on
    hold on,grid,box on
  end
end

figure(4),subplot(3,1,1),legend(Nom(leg,:)'location','NE')

saveas(gcf,fichLog,'fig')
saveas(gcf,fichLog,'png')

figure(3)
saveas(gcf,fich,'fig')
saveas(gcf,fich,'png')


fichCommun='.\Images\Niveau\EvolTemp';
fich=[num2str(fichCommun)];
fichZoom=[num2str(fichCommun) num2str('_zoom')];


T=4;

close all
subplot(2,1,1),hold on
subplot(2,1,2),hold on


Nom=['MS ';'MB ';'MN1';'MN2'];
c=['r';'b';'c';'m'];

%for i = 1:size(Nom,1);
for i = 1;
%% Travail dans la boucle

% lecture des variables
    Nom(i,:),DonneesCampagne(Nom(i,:))

% Dessin
  load (MouillagePropre)

  if (strcmp(Pression,'Non  ')==0)
       Niv=detrend(P.depth);
       t=(datum_str(Temps))-T0;% en jour
       subplot(2,1,1),plot(t,Niv,c(i,:))
       subplot(2,1,2),plot((t-T)*24,Niv,c(i,:))
  end
end

subplot(2,1,1),axis([-2 11 -1.5 1.5]),box on

subplot(2,1,2),%axis([3.95 4.45 -1.5 1.5])
axis([-1.2 11.5 -1.5 1.5]),box on

saveas(gcf,fich,'fig')
saveas(gcf,fich,'png')




./ResiduelleNiveauDessin_loc

fichCommun='.\Images\Niveau\Residuelle';
fich=[num2str(fichCommun)];
dm=50;

close all
subplot(2,1,1),hold on
subplot(2,1,2),hold on


c=['r';'b';'c';'m'];
cm=['.r';'*b';'<c';'+m'];

for i = 1:size(Nom,1);
%for i=2;

%% Travail dans la boucle
% lecture des variables
    Nom(i,:);DonneesCampagne(Nom(i,:))
    if (strcmp(Pression,'Non  ')==0)
% Dessin
    [t,u,up]=ResiduelleCalcul(MouillageAnalyse,T0,i);
    subplot(2,1,1),plot(t(1:dm:end)/24,u(1:dm:end),cm(i,:)),hold on
    subplot(2,1,2),plot(t(1:dm:end)/24,up(1:dm:end),cm(i,:)),hold on
  end
end

leg=[];
for i = 1:size(Nom,1);
%for i=2;

%% Travail dans la boucle
% lecture des variables
    Nom(i,:);DonneesCampagne(Nom(i,:))
    if (strcmp(Pression,'Non  ')==0)
       leg=[leg i];

% Dessin
    [t,u,up]=ResiduelleCalcul(MouillageAnalyse,T0,i);
    subplot(2,1,1),plot(t/24,u,c(i,:))
    subplot(2,1,2),plot(t/24,up,c(i,:))
  end
end

subplot(2,1,1),box on,%axis([xmin1_loc xmax1_loc ymin1_loc ymax1_loc])
grid on
legend(Nom(leg,:),'location','best')
subplot(2,1,2),box on,%axis([xmin1_loc xmax1_loc ymin1_loc ymax1_loc])
grid on
legend(Nom(leg,:),'location','best')

saveas(gcf,fich,'fig')
saveas(gcf,fich,'png')




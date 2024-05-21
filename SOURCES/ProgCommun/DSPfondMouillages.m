DSPfondMouillages_loc

%GlobaleVar
if isempty(automatique),automatique=0;end
if (automatique==0)
    m=eval(input('ieme_maille=','s'));
end

    close all, 
figure(1),clf,figure(2),clf,figure(3),clf

DirCommun='./Harmonique/Periodogramme/';
[a,b]=mkdir (DirCommun);
DirMouillage='./Harmonique/Images/';
[a,b]=mkdir (DirMouillage);

%% U vitesse Est-Ouest
titre_des='Vitesse U'
titre_fich='VitesseU'
[a,b]=mkdir ([ DirMouillage '/' titre_des]);
  fichMouillage=[DirMouillage titre_des '/'];
[a,b]=mkdir ([DirCommun '/' titre_fich]);
   fichCommun=[DirCommun '/' titre_fich '/'];
[a,b]=mkdir ([DirCommun '/' titre_fich '_Log/']);
   fichCommunLog=[DirCommun '/' titre_fich '_Log/'];
for i = 1:size(Nom,1);
%for i = 3;
%% Travail dans la boucle

% lecture des variables
    Nom(i,:);DonneesCampagne(Nom(i,:));

% Dessin
    %m=eval(input('ieme_maillePN=','s'));
    
    if (automatique==1)
       m=round((Nmax(i)-1)*NbNiv)+1;
    end
    if(m<=Nmax(i))
        fich=[num2str(fichCommun) 'Niv' num2str(m) '_U'];
        fichLog=[num2str(fichCommunLog) 'Niv' num2str(m) '_U_log'];
        fichM=[num2str(fichMouillage) nom '_Niv' num2str(m) '_U']
        
        [sortie,f]=PeriodogrammeMouillage(5,'u',m);
   
        figure(1),subplot(3,1,Fig(i))
        loglog(f,sortie,c(i,:))
        axis([xmin1_loc xmax1_loc ymin1_loc ymax1_loc]),hold on,
        box on,grid on
        if(Fig(i)==1)
            titre=[cellstr(['FFT de la ', titre_des,' -  Niveau : ',num2str(m)])];
        else
            titre=[cellstr(['  '])];
        end
        title(titre)
        xlabel('frequence'),ylabel('puissance')
        legend(Nom(i,:),Nom(max(1,i-1),:),'location','best')

        figure(2),subplot(3,1,Fig(i))
        plot(f,sortie,c(i,:))
        axis([xmin2_loc xmax2_loc ymin2_loc ymax2_loc]),hold on

        figure(i+3),
        axis([Tmin(i) Tmax(i) Umin_loc Umax_loc])
        titre=[cellstr([titre_des,'  -  Mouillage : ',nom])...
            cellstr([' -  Niveau : ',num2str(m)])];
        subplot(2,1,1),    title(titre)
        xlabel('frequence'),ylabel('puissance')
        legend('FFT','location','best')
        subplot(2,1,2),   
        xlabel('temps (jour)'),ylabel('vitesse (mm/s)')
        legend('Vitesse','VitesseReconstitu�e','location','SouthWest')

        disp('sauvegarde dans'),fichM
        saveas(gcf,fichM,'fig')
        saveas(gcf,fichM,'png')
        fichM
    end
end

figure(1)
DSPfondMouillages_loc
disp('sauvegarde dans'),fichLog
saveas(gcf,fichLog,'fig')
saveas(gcf,fichLog,'png')

disp('sauvegarde dans'),fich
figure(2)
titre=[cellstr(['FFT de la ', titre_des,...
    ' -  Niveau : ',num2str(m)]) ];
title(titre)
xlabel('frequence'),ylabel('puissance')
grid,box on
saveas(gcf,fich,'fig')
saveas(gcf,fich,'png')

'U fait'
%% V vitesse Nord-Sud

titre_des='Vitesse V'
titre_fich='VitesseV'
[a,b]=mkdir ([ DirMouillage '/' titre_fich]);
  fichMouillage=[DirMouillage titre_fich '/'];
[a,b]=mkdir ([DirCommun '/' titre_fich]);
   fichCommun=[DirCommun '/' titre_fich '/'];
[a,b]=mkdir ([DirCommun '/' titre_fich '_Log/']);
   fichCommunLog=[DirCommun '/' titre_fich '_Log/'];

    close all, 
figure(1),clf,figure(2),clf,figure(3),clf

for i = 1:size(Nom,1);
%for i = 3;
%% Travail dans la boucle

% lecture des variables
    Nom(i,:),DonneesCampagne(Nom(i,:))

% Dessin
    %m=eval(input('ieme_maillePN=','s'));
    if (automatique==1)
       m=round((Nmax(i)-1)*NbNiv)+1;
    end
    if(m<=Nmax(i))
        fich=[num2str(fichCommun) 'Niv' num2str(m) '_V'];
        fichLog=[num2str(fichCommunLog) 'Niv' num2str(m) '_V_log'];
        fichM=[num2str(fichMouillage) nom '_Niv' num2str(m) '_V'];
        
        [sortie,f]=PeriodogrammeMouillage(5,'v',m);

        figure(1),subplot(3,1,Fig(i))
        loglog(f,sortie,c(i,:))
        axis([xmin1_loc xmax1_loc ymin1_loc ymax1_loc]),hold on,
        box on,grid on
        if(Fig(i)==1)
            titre=[cellstr(['FFT de la ', titre_des,' -  Niveau : ',num2str(m)])];
        else
            titre=[cellstr(['  '])];
        end
        title(titre)
        xlabel('frequence'),ylabel('puissance')
        legend(Nom(i,:),Nom(max(1,i-1),:),'location','best')

        figure(2)
        plot(f,sortie,c(i,:))
        axis([xmin2_loc xmax2_loc ymin2_loc ymax2_loc]),hold on

        figure(i+3),
        axis([Tmin(i) Tmax(i) Umin_loc Umax_loc])
        titre=[cellstr([titre_des,'  -  Mouillage : ',nom])...
            cellstr([' -  Niveau : ',num2str(m)])];
        subplot(2,1,1),    title(titre)
        xlabel('frequence'),ylabel('puissance')
        legend('FFT','location','best')
        subplot(2,1,2),   
        xlabel('temps (jour)'),ylabel('vitesse (mm/s)')
        legend('Vitesse','VitesseReconstitu�e','location','SouthWest')
        grid,box on

        disp('sauvegarde dans'),fichM
        saveas(gcf,fichM,'fig')
        saveas(gcf,fichM,'png')
    end

end


figure(1)
DSPfondMouillages_loc
disp('sauvegarde dans'),fichLog
saveas(gcf,fichLog,'fig')
saveas(gcf,fichLog,'png')

disp('sauvegarde dans'),fich
figure(2)
grid,box on
titre=[cellstr(['FFT de la ', titre_des,...
    ' -  Niveau : ',num2str(m)]) ];
title(titre)
xlabel('frequence'),ylabel('puissance')
saveas(gcf,fich,'fig')
saveas(gcf,fich,'png')


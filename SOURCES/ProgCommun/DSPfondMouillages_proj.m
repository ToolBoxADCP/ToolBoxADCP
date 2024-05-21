DSPfondMouillages_proj_loc

%GlobaleVar
if isempty(automatique),automatique=0;end
if (automatique==0)
    m=eval(input('ieme_maille=','s'));
end
    close all,
figure(1),clf,figure(2),clf,figure(3),clf


fichCommun='./Harmonique/Periodogramme/';
fichMouillage='./Harmonique/Images/Harm';


%% U projet�
dir_fich=[num2str(fichCommun) '_Long/']
titre_des='Vitesse Longitudinale'
titre_fich='VitLong'
[a,b]=mkdir ([ DirMouillage '/' titre_fich]);
  fichMouillage=[DirMouillage titre_fich '/'];
[a,b]=mkdir ([DirCommun '/' titre_fich]);
   fichCommun=[DirCommun '/' titre_fich '/'];
[a,b]=mkdir ([DirCommun '/' titre_fich '_Log/']);
   fichCommunLog=[DirCommun '/' titre_fich '_Log/'];

   for i = 1:size(Nom,1);
  Nom(i,:)
  
  DonneesCampagne(Nom(i,:))

    if (automatique==1)
       m=round((Nmax(i)-1)*NbNiv)+1;
    end
    if(m<=Nmax(i))
        fich=[num2str(fichCommun) 'Niv' num2str(m) '_Ulong'];
        fichLog=[num2str(fichCommunLog) 'Niv' num2str(m) '_Ulong_log'];
        fichM=[num2str(fichMouillage) nom '_Niv' num2str(m) '_Ulong'];

   [sortie,f]=PeriodogrammeMouillage(5,'Upr',m);

    figure(1),subplot(3,1,Fig(i))
    loglog(f,sortie,c(i,:))
    axis([xmin1_loc xmax1_loc ymin1_loc ymax1_loc]),hold on,
    grid on,box on
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
    legend('Vitesse','VitesseReconstitu�e','location','best')

    disp('sauvegarde dans'),fichM
    saveas(gcf,fichM,'fig')
    saveas(gcf,fichM,'png')
end

end
figure(1),%subplot(3,1,Fig_leg),
DSPfondMouillages_proj_loc
saveas(gcf,fichLog,'fig')
saveas(gcf,fichLog,'png')

figure(2)
titre=[cellstr(['FFT de la ', titre_des,...
    ' -  Niveau : ',num2str(m)]) ];
title(titre)
xlabel('frequence'),ylabel('puissance')
grid,box on
saveas(gcf,fich,'fig')
saveas(gcf,fich,'png')

%% V projet�

    close all, 
figure(1),clf,figure(2),clf,figure(3),clf

titre_des='Vitesse Orthogonale'
titre_fich='VitOrtho'
[a,b]=mkdir ([ DirMouillage '/' titre_fich]);
  fichMouillage=[DirMouillage titre_fich '/'];
[a,b]=mkdir ([DirCommun '/' titre_fich]);
   fichCommun=[DirCommun '/' titre_fich '/'];
[a,b]=mkdir ([DirCommun '/' titre_fich '_Log/']);
   fichCommunLog=[DirCommun '/' titre_fich '_Log/'];


for i = 1:size(Nom,1);
  Nom(i,:)
  
  DonneesCampagne(Nom(i,:))

    if (automatique==1)
       m=round((Nmax(i)-1)*NbNiv)+1;
    end
    if(m<=Nmax(i))

        fich=[num2str(fichCommun) 'Niv' num2str(m) '_Vortho'];
        fichLog=[num2str(fichCommunLog) 'Niv' num2str(m) '_Vortho_log'];
        fichM=[num2str(fichMouillage) nom '_Niv' num2str(m) '_Vortho'];
        
        [sortie,f]=PeriodogrammeMouillage(5,'Vpr',m);

        figure(1),subplot(3,1,Fig(i))
        loglog(f,sortie,c(i,:))
        axis([xmin1_loc xmax1_loc ymin1_loc ymax1_loc]),hold on,
        grid on,box on
        if(Fig(i)==1)
            titre=[cellstr(['FFT de la ', titre_des,...
                ' -  Niveau : ',num2str(m)])];
        else
            titre=[cellstr(['  '])];
        end
        title(titre)
        xlabel('frequence'),ylabel('puissance')
        legend(Nom(i,:),Nom(max(1,i-1),:),'location','best')

        figure(2)
        plot(f,sortie,c(i,:))
        axis([xmin3_loc xmax3_loc ymin3_loc ymax3_loc]),hold on

        figure(i+3),
        axis([Tmin(i) Tmax(i) Vmin_loc Vmax_loc])
        titre=[cellstr([titre_des,'  -  Mouillage : ',nom])...
            cellstr([' -  Niveau : ',num2str(m)])];
        subplot(2,1,1),    title(titre)
        xlabel('frequence'),ylabel('puissance')
        legend('FFT','location','best')
        subplot(2,1,2),  
        xlabel('temps (jour)'),ylabel('vitesse (mm/s)')
        legend('Vitesse','VitesseReconstitu�e','location','best')

        saveas(gcf,fichM,'fig')
        saveas(gcf,fichM,'png')
    end

end
figure(1),%subplot(3,1,Fig_leg),
DSPfondMouillages_proj_loc
grid on,box on
saveas(gcf,fichLog,'fig')
saveas(gcf,fichLog,'png')

figure(2)
grid,box on
titre=[cellstr(['FFT de la ', titre_des,...
    ' -  Niveau : ',num2str(m)]) ];
title(titre)
xlabel('frequence'),ylabel('puissance')
saveas(gcf,fich,'fig')
saveas(gcf,fich,'png')

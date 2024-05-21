ProfilVerticalVitesse_loc
datestr(T0+T)

%GlobaleVar
h=[0,1,2,3];
h=[0,3,6,9];
fin=[22 24 24 24;7 24 24 24;21 21 22 23;21 24 24 24];
fichCommun='./Images/Profil/Vitesse';
fichU=[num2str(fichCommun) num2str('U')];
fichV=[num2str(fichCommun) num2str('V')];
fichDir=[num2str(fichCommun) num2str('_dir')];
fichNorme=[num2str(fichCommun) num2str('_Norme')];
fichU_proj=[num2str(fichCommun) num2str('U') num2str('_proj')];
fichV_proj=[num2str(fichCommun) num2str('V') num2str('_proj')];

close all

Fig=[0,0,1,1];NbFig=[1,2,1,2];
c=['-.r';'--b';'.-c';'-k '];
%c=['r';'b';'c';'k'];

for i = 1:size(Nom,1);
%for i = 3;
%% Travail dans la boucle

% lecture des variables
    Nom(i,:);DonneesCampagne(Nom(i,:))

% Dessin
    load (MouillagePropre)

    t_M=((datum_str(Temps)-T0)-T)*24;
%     figure(13+NbFig(i)+2*Fig(i)),subplot(1,2,1),quiver(0,0,u0,v0,0,'--k'),hold on,axis equal
%     subplot(1,2,2) ,quiver(0,0,u0,v0,0,c(j,:),'--k'),hold on,axis equal

    for j = 1:size(h,2);
      ii=find(abs(t_M-h(j))<10/60);
      if ~isempty(ii)
        u=mean(vitesse.u(ii,:));
        v=mean(vitesse.v(ii,:));
        figure(1+Fig(i)),subplot(1,2,NbFig(i)),hold on,plot(u,P_Adcp.fond_f(ii(1),:),c(j,:))
        title(['U au mouillage ' Nom(i,:)])
        figure(3+Fig(i)),subplot(1,2,NbFig(i)),hold on,plot(v,P_Adcp.fond_f(ii(1),:),c(j,:))
        title(['V au mouillage ' Nom(i,:)])
        figure(5+Fig(i)),subplot(1,2,NbFig(i)),hold on,plot(uv2dir(u,v),P_Adcp.fond_f(ii(1),:),c(j,:))
        title(['dir au mouillage ' Nom(i,:)])
        figure(7+Fig(i)),subplot(1,2,NbFig(i)),hold on,plot(speed(u,v),P_Adcp.fond_f(ii(1),:),c(j,:))
        title(['Norme au mouillage ' Nom(i,:)])
%     figure(13+NbFig(i)+2*Fig(i)),subplot(1,2,1),quiver(0,0,u(1),v(1),0,c(j,:)),hold on,axis equal
%     subplot(1,2,2) ,quiver(0,0,u(fin(i,1)),v(fin(i,1)),0,c(j,:)),hold on,axis equal
%     title(Nom(i,:)),
      end
    end
%     figure(1+Fig(i)),legend('h1','h2','h3','h4'),grid,box on
%     figure(3+Fig(i)),legend('h1','h2','h3','h4'),grid,box on
%     figure(5+Fig(i)),legend('h1','h2','h3','h4'),grid,box on
%     figure(7+Fig(i)),legend('h1','h2','h3','h4'),grid,box on
    figure(1+Fig(i)),subplot(1,2,NbFig(i)),grid,box on
    figure(3+Fig(i)),subplot(1,2,NbFig(i)),grid,box on
    figure(5+Fig(i)),subplot(1,2,NbFig(i)),grid,box on
    figure(7+Fig(i)),subplot(1,2,NbFig(i)),grid,box on

   
    
    load (MouillagePropre_proj)
    [u0,v0]=dir2uv(tetaMoy*180/pi,1000)

    t_M=((datum_str(Temps)-T0)-T)*24;
    
    for j = 1:size(h,2);
      ii=find(abs(t_M-h(j))<10/60);
      if ~isempty(ii)
        u=mean(vitesse.u(ii,:));
        v=mean(vitesse.v(ii,:));
        figure(9+Fig(i)),subplot(1,2,NbFig(i)),hold on,plot(u,P_Adcp.fond_f(ii(1),:),c(j,:))
        title(['Uproj au mouillage ' Nom(i,:)])
        figure(11+Fig(i)),subplot(1,2,NbFig(i)),hold on,plot(v,P_Adcp.fond_f(ii(1),:),c(j,:))
        title(['Uortho au mouillage ' Nom(i,:)])
      end
    end
%     figure(9+Fig(i)),legend('h1','h2','h3','h4'),grid,box on
%     figure(11+Fig(i)),legend('h1','h2','h3','h4'),grid,box on
    figure(9+Fig(i)),box on,axis([-1000 1000 hmin(i) hmax(i)])
    figure(11+Fig(i)),box on,axis([-1000 1000 hmin(i) hmax(i)])

end

for fig=0:1;
figure(1+fig)
  t_fichU=[num2str(fichU) num2str('_') num2str(fig)];
  saveas(gcf,t_fichU,'fig')
  saveas(gcf,t_fichU,'png')
figure(3+fig)
  t_fichV=[num2str(fichV) num2str('_') num2str(fig)];
  saveas(gcf,t_fichV,'fig')
  saveas(gcf,t_fichV,'png')
figure(5+fig)
  t_fichDir=[num2str(fichDir) num2str('_') num2str(fig)];
  saveas(gcf,t_fichDir,'fig')
  saveas(gcf,t_fichDir,'png')
figure(7+fig)
  t_fichNorme=[num2str(fichNorme) num2str('_') num2str(fig)];
  saveas(gcf,t_fichNorme,'fig')
  saveas(gcf,t_fichNorme,'png')
figure(9+fig)
  t_fichU_proj=[num2str(fichU_proj) num2str('_') num2str(fig)];
  saveas(gcf,t_fichU_proj,'fig')
  saveas(gcf,t_fichU_proj,'png')
figure(11+fig),
  t_fichV_proj=[num2str(fichV_proj) num2str('_') num2str(fig)];
  saveas(gcf,t_fichV_proj,'fig')
  saveas(gcf,t_fichV_proj,'png')
end
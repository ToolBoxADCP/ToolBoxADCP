dessinVitesseNiveau_loc

fichCommun='./Images/Vitesse/VitesseNiveau';

for i = 1:size(Nom,1);
%% Travail dans la boucle

% lecture des variables
    Nom(i,:),DonneesCampagne(Nom(i,:))
    figure(Fig(i)), clf

% Dessin
  load (MouillagePropre)
  load (MouillageMoy)

  if (strcmp(FichPression,'Non  ')==0)
       fich=[num2str(fichCommun) num2str('_') num2str(Nom(i,:))]
       
       Niv=detrend(P.depth);
       %Niv=VitMoy_proj.u;
       %for ind=1:iF(i)
           ind=iF(i);
           %u=vitesse.u(:,ind);v=vitesse.v(:,ind);dir=uv2dir(u,v);
           u=VitMoy.u;v=VitMoy.v;
           dir=uv2dir(u,v);

           % mean(vitesse.u(3000:4000,:))
           ii=find(isnan(dir)==0 & isnan(Niv)==0);Correlation(dir(ii),Niv(ii))
           %subplot(3,1,Fig(i)),
           plot(mod(dir+angle(i),180)-angle(i),Niv,'.k','MarkerSize',4)
       %end
       
       saveas(gcf,fich,'fig')
       saveas(gcf,fich,'png')

  end
end


fichCommun='./Images/Vitesse/VitesseVitesse';

for i = 1:size(Nom,1);
%% Travail dans la boucle

% lecture des variables
    Nom(i,:),DonneesCampagne(Nom(i,:))
    figure(Fig(i)), clf

% Dessin
  load (MouillagePropre)
  load (MouillageMoy)

  if (strcmp(FichPression,'Non  ')==0)
       fich=[num2str(fichCommun) num2str('_') num2str(Nom(i,:))]
       
       %Niv=detrend(P.depth);
       Niv=VitMoy_proj.u;
       %for ind=1:iF(i)
           ind=iF(i);
           %u=vitesse.u(:,ind);v=vitesse.v(:,ind);dir=uv2dir(u,v);
           u=VitMoy.u;v=VitMoy.v;
           dir=uv2dir(u,v);

           % mean(vitesse.u(3000:4000,:))
           ii=find(isnan(dir)==0 & isnan(Niv)==0);Correlation(dir(ii),Niv(ii))
           %subplot(3,1,Fig(i)),
           plot(mod(dir+angle(i),180)-angle(i),Niv,'.k','MarkerSize',4)
       %end
       
       saveas(gcf,fich,'fig')
       saveas(gcf,fich,'png')

  end
end

VitPlot_loc
clf,hold on
if size(Harm,1)>0
index=0;
 NivMax=MaxProf(nom);
 if(NbNiv==1);tsNiv=1;
   else tsNiv=floor(linspace(1,NivMax,NbNiv));
 end
 for niv = tsNiv;
    t=Harm(niv).temps/24;
    u=Harm(niv).res+Harm(niv).lin(1)+Harm(niv).lin(2)*t*24;
    if(NbNiv>1)
        subplot(NbNiv,1,NbNiv-index);index=index+1;
    else
        subplot(2,1,1)
    end
    II=ii(1:end-1);
    plot(t(II)-Tmes+T0,u(II));
    xlabel('temps (jour)'),ylabel('vitesse (mm/s)')
    if(NbNiv>1),
      %legend(['niveau ' num2str(niv)],'Location','SouthWest')
      legend(['niveau ' num2str(niv)],'Location','Best')
    end
    grid on
    axis([JourMin JourMax VitMin VitMax])
if(strcmp(Campagne,'Tulear1')|strcmp(Campagne,'Tulear2'))
    BarrePrelev(Tmes,T_fin,Nom(i,:))
end
 end
 
 box on
 titre=[cellstr([DessNom ' Residuelle','  -  ',...
        nom])...
        cellstr([char(NomMois(mod(DebDessin(mois).month-1,12)+1)) ' ' ...
                    num2str(floor(DebDessin(mois).month/12)+DebDessin(mois).year)])...
    ];
 subplot(NbNiv,1,1),title(titre)
 fichM=[num2str(fichMouillage) num2str(char(cellstr(DessNom))) '/' ...
       num2str(char(cellstr(DessNom))) '_res_' ...
       num2str(char(cellstr(Nom(i,:)))) ...
     '_' char(NomMois(mod(DebDessin(mois).month-1,12)+1)) '_'...
      num2str(floor(DebDessin(mois).month/12)+DebDessin(mois).year)];
 
 [a,b]=mkdir([num2str(fichMouillage) num2str(char(cellstr(DessNom)))]);
 saveas(gcf,fichM,'fig')
 saveas(gcf,fichM,'png')
end

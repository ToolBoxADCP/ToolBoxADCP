VitPlot_loc
if size(harm,1)>0
 clf,hold on
 index=0;
 if(NbNiv==1);tsNiv=1;
   else tsNiv=floor(linspace(1,NivMax,NbNiv));;
 end
for niv = tsNiv;
    t=datum_str(Temps)-Tmes;
    subplot(NbNiv,1,NbNiv-index);index=index+1;
    plot(t(ii),vit(ii,niv));
    hold on
    plot(t(ii(1:end-1)),harm(1,niv).MoyGliss(ii(1:end-1)),'r');
    
    xlabel('temps (jour)'),ylabel('vitesse (mm/s)')
    %if(NbNiv>1),legend(['niveau ' num2str(niv)],'Location','SouthWest'),end
    if(NbNiv>1),legend(['niveau ' num2str(niv)],'Location','Best'),end
    grid on
    axis([JourMin JourMax VitMin VitMax])
if(strcmp(Campagne,'Tulear1')|strcmp(Campagne,'Tulear2'))
    BarrePrelev(Tmes,T_fin,Nom(i,:))
end
end

 box on
titre=[cellstr([DessNom '  -  ',nom])...
        cellstr([char(NomMois(mod(DebDessin(mois).month-1,12)+1)) ' ' ...
                 num2str(floor(DebDessin(mois).month/12)+DebDessin(mois).year)])...
    ];

 subplot(NbNiv,1,1),title(titre)
 
 fichM=[num2str(fichMouillage) num2str(char(cellstr(DessNom))) '/' ...
       num2str(char(cellstr(DessNom))) '_' ...
       num2str(char(cellstr(Nom(i,:)))) ...
     '_' char(NomMois(mod(DebDessin(mois).month-1,12)+1)) '_'...
      num2str(floor(DebDessin(mois).month/12)+DebDessin(mois).year)];
 

 [a,b]=mkdir([num2str(fichMouillage) num2str(char(cellstr(DessNom)))]);
 saveas(gcf,fichM,'fig')
 saveas(gcf,fichM,'png')
end

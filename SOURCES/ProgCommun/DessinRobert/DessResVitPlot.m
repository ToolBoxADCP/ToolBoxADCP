clf,hold on
index=0;
niv=1;
if size(Harm,1)>1
% if(exist('Ymin_res')==0)
    Ymin_res=Ymin;
    Ymax_res=Ymax;
% end
    
    
subplot(2,1,2)
    II=ii(1:end-1);
    t=Harm(niv).temps/24;
    %u=Harm(niv).res+Harm(niv).lin(1)+Harm(niv).lin(2)*t*24;
    u=Harm(niv).res-Harm(niv).MoyGliss;
    plot(t(II)-Tmes+T0,u(II),'b');hold on
    u=Harm(niv).lin(1)+Harm(niv).lin(2)*t*24;
    plot(t(II)-Tmes+T0,u(II),'r');
    
    xlabel('temps (jour)'),ylabel('residuelle (mm/s)')
    grid on
    axis([JourMin JourMax Ymin_res Ymax_res])
    if(strcmp(Campagne,'Tulear1')|strcmp(Campagne,'Tulear2'))
        BarrePrelev(Tmes,T_fin,Nom(i,:))
    end
    box on
    if(legendOn)
    legend('Vitesse Residuelle','Vitesse Moyenne'...
        ,'location','Best')
    end

subplot(2,1,1)
%     u=Harm(niv).res;
%     plot(t(II)-Tmes+T0,u(II),'g');hold on
    t=datum_str(Temps)-Tmes;
    plot(t(ii),vit(ii,niv));hold on
    hold on
    u=VitesseCalculeeAvecHarmonique(NbOndes,Harm,...
        (datum_str(Temps)-T0)*24,T0);
    MoyGliss=interp1(Harm(niv).temps,Harm(niv).MoyGliss,...
                                                 (datum_str(Temps)-T0)*24);
    u=u+MoyGliss;
    plot(t(ii),u(ii,niv),'r');
    plot(t(ii),MoyGliss(ii),'k');
    
    xlabel('temps (jour)'),ylabel('vitesse (mm/s)')
    grid on
    if(legendOn)
    legend('Vitesse','Vitesse Tidale',...
        'location','Best')
    end
    axis([JourMin JourMax Ymin Ymax])
if(strcmp(Campagne,'Tulear1')|strcmp(Campagne,'Tulear2'))
    BarrePrelev(Tmes,T_fin,Nom(i,:))
end

    titre=[ cellstr([DessNom  '  -  ',nom])...
            cellstr([char(NomMois(mod(DebDessin(mois).month-1,12)+1)) ' ' ...
                    num2str(floor(DebDessin(mois).month/12)+DebDessin(mois).year)])...
          ];
    title(titre)
 
 [a,b]=mkdir([num2str(fichMouillage) num2str(char(cellstr(DessNom)))]);
 fichM=[num2str(fichMouillage) num2str(char(cellstr(DessNom))) '/'...
     num2str(char(cellstr(DessNom)))...
     '_res_'  num2str(char(cellstr(Nom(i,:)))) ...
     '_Mois' num2str(DebDessin(mois).month) '_'...
             num2str(DebDessin(mois).year)];
 saveas(gcf,fichM,'fig')
 saveas(gcf,fichM,'png')
end

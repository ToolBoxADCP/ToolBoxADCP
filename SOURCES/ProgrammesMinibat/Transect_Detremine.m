clear all   
Initialisation
   dessinPhotoTulearInit;
[a,b]=mkdir(DossierTransect);
Transects_Definition
load DataProfil

NumeroTransect=0;
for indTrans = 1:size(TransectStation,2)
    for indJour = 1:size(JourTransect(indTrans).j,1)
        JourTransect(indTrans).j(indJour)
        NumeroTransect=NumeroTransect+1
        %ii=find(tempsData.day==JourTransect(indTrans).j(indJour));
        ii=find(T_Data>=JourTransect(indTrans).j(indJour) & ...
            T_Data<JourTransect(indTrans).j(indJour)+22/24);
      Transect_InterpolationSurChemin
      
      lon0=TransectPoint(indTrans).Lon;
      lat0=TransectPoint(indTrans).Lat;
      D0=TransectPoint(indTrans).d;
      
      Transect_CalculDistance
      P=PressionI;
      T=TI(I);T=interp1(D0(ii),T(ii),D0);
      
      Temps.year=tempsData.year(I);
            Temps.year=interp1(D0(ii),Temps.year(ii),D0);
      Temps.month=tempsData.month(I);
            Temps.month=interp1(D0(ii),Temps.month(ii),D0);
      Temps.day=tempsData.day(I);
            Temps.day=interp1(D0(ii),Temps.day(ii),D0);
      Temps.hour=tempsData.hour(I);
            Temps.hour=interp1(D0(ii),Temps.hour(ii),D0);
      Temps.minute=tempsData.minute(I);
            Temps.minute=interp1(D0(ii),Temps.minute(ii),D0);
      Temps.seconde=tempsData.seconde(I);
            Temps.seconde=interp1(D0(ii),Temps.seconde(ii),D0);

      [d,z]=meshgrid(D0,-P);
      Temperature=TemperatureI(:,I);      
      Temperature=griddata(d(:,ii),z(:,ii),Temperature(:,ii),d,z);
      Salinite=SaliniteI(:,I);      
      Salinite=griddata(d(:,ii),z(:,ii),Salinite(:,ii),d,z);
      Fluorimetrie=FluorimetrieI(:,I);      
      Fluorimetrie=griddata(d(:,ii),z(:,ii),Fluorimetrie(:,ii),d,z);
      Turbidite=TurbiditeI(:,I);      
      Turbidite=griddata(d(:,ii),z(:,ii),Turbidite(:,ii),d,z);
      Z0=Z0_(:,I);      
      Z0_=griddata(d(:,ii),z(:,ii),Z0(:,ii),d,z);
%       Pression=PressionI(:,I);      
%       Pression=interp1(d(:,ii),Pression(:,ii),d);
     
      Densite=CalculDensite(Salinite,Temperature);
      
      if (Bathy==1)
          Z0=CalculBathy(lon0,lat0);
          Z0_=-ones(size(z,1),1)*Z0;size(Z0_)
      end
            Temperature(z<Z0_)=NaN; 
            Salinite(z<Z0_)=NaN;
            Fluorimetrie(z<Z0_)=NaN;
            Turbidite(z<Z0_)=NaN;
      
      figure,pcolor(d,z,Temperature),shading flat,colorbar
      title(['Temperature, transect ' num2str(indTrans) ' le :' ...
            num2str(JourTransect(indTrans).j(indJour))])
        xlabel('Distance')
        ylabel('Profondeur')
        Fich=[DossierTransect 'TemperatureTransect' num2str(indTrans) 'Jour' ...
            num2str(JourTransect(indTrans).j(indJour))];
            saveas(gcf,Fich,'fig')
%             saveas(gcf,Fich,'png')

      figure,pcolor(d,z,Salinite),shading flat,colorbar
      title(['Salinite, transect ' num2str(indTrans) ' le :' ...
            num2str(JourTransect(indTrans).j(indJour))])
        xlabel('Distance')
        ylabel('Profondeur')
        Fich=[DossierTransect 'SaliniteTransect' num2str(indTrans) 'Jour' ...
            num2str(JourTransect(indTrans).j(indJour))];
            saveas(gcf,Fich,'fig')
%             saveas(gcf,Fich,'png')
      figure,pcolor(d,z,Fluorimetrie),shading flat,colorbar
      title(['Fluorimetrie, transect ' num2str(indTrans) ' le :' ...
            num2str(JourTransect(indTrans).j(indJour))])
        xlabel('Distance')
        ylabel('Profondeur')
        Fich=[DossierTransect 'FluorimetrieTransect' num2str(indTrans) 'Jour' ...
            num2str(JourTransect(indTrans).j(indJour))];
            saveas(gcf,Fich,'fig')
%             saveas(gcf,Fich,'png')
      figure,pcolor(d,z,Turbidite),shading flat,colorbar
      title(['Turbidite, transect ' num2str(indTrans) ' le :' ...
            num2str(JourTransect(indTrans).j(indJour))])
        xlabel('Distance')
        ylabel('Profondeur')
        Fich=[DossierTransect 'TurbiditeTransect' num2str(indTrans) 'Jour' ...
            num2str(JourTransect(indTrans).j(indJour))];
            saveas(gcf,Fich,'fig')
%             saveas(gcf,Fich,'png')

      figure,pcolor(d,z,Densite),shading flat,colorbar
      title(['Densite, transect ' num2str(indTrans) ' le :' ...
            num2str(JourTransect(indTrans).j(indJour))])
        xlabel('Distance')
        ylabel('Profondeur')
        Fich=[DossierTransect 'DensiteTransect' num2str(indTrans) 'Jour' ...
            num2str(JourTransect(indTrans).j(indJour))];
            saveas(gcf,Fich,'fig')
%             saveas(gcf,Fich,'png')
      
      TransectData(NumeroTransect).Z0=Z0;
      TransectData(NumeroTransect).T=T;
      TransectData(NumeroTransect).Temps=Temps;
      TransectData(NumeroTransect).Temperature=Temperature;
      TransectData(NumeroTransect).Salinite=Salinite;
      TransectData(NumeroTransect).Fluorimetrie=Fluorimetrie;
      TransectData(NumeroTransect).Turbidite=Turbidite;
      TransectData(NumeroTransect).Densite=Densite;
      TransectData(NumeroTransect).z=z;
      TransectData(NumeroTransect).indTrans=indTrans;
      TransectData(NumeroTransect).JourTransect=JourTransect(indTrans).j(indJour);

%       TransectPoint(indTrans).T=T;
%       TransectPoint(indTrans).P=P;
    end       
end
save('DonneesTransect','TransectPoint','TransectStation','JourTransect','TransectData')
% 
%       tempsData.year=[tempsData.year;temps.year];
%       tempsData.month=[tempsData.month;temps.month];
%       tempsData.day=[tempsData.day;temps.day];
%       tempsData.hour=[tempsData.hour;temps.hour];
%       tempsData.minute=[tempsData.minute;temps.minute];
%       tempsData.seconde=[tempsData.seconde;temps.seconde];
%       PositionData.lat=[PositionData.lat;Lat];
%       PositionData.lon=[PositionData.lon;Lon];
%       
%       DataTot.Salinite=[DataTot.Salinite;Salinite];
%       DataTot.Temperature=[DataTot.Temperature;Temperature];
%       DataTot.Fluorimetrie=[DataTot.Fluorimetrie;Fluorimetrie];
%       DataTot.Turbidite=[DataTot.Turbidite;Turbidite];
%       DataTot.Pression=[DataTot.Pression;Pression];
%          
%       T_Data=datum_str(tempsData)-T0;
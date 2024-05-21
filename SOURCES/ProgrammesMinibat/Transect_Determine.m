clear all   
Initialisation
   dessinPhotoTulearInit;
[a,b]=mkdir(DossierTransect);
Transects_Definition
load DataProfil
%load Maree

NumeroTransect=0;
for indTrans = 1:size(TransectStation,2)
    for indJour = 1:size(JourTransectD(indTrans).j,1)
        JourTransectD(indTrans).j(indJour)
        NumeroTransect=NumeroTransect+1
        %ii=find(tempsData.day==JourTransect(indTrans).j(indJour));
        ii=find(T_Data>=JourTransectD(indTrans).j(indJour) & ...
            T_Data<JourTransectF(indTrans).j(indJour));
        if size(ii,1)~=0
            
          Transect_InterpolationSurChemin

          lon0=TransectPoint(indTrans).Lon;
          lat0=TransectPoint(indTrans).Lat;
          D0=TransectPoint(indTrans).d;

          Transect_CalculDistanceb
          P=PressionI;
          T=interp1(DI,TI,D0);

    %       Temps.year=tempsData.year(I);
    %             Temps.year=interp1(D0(ii),Temps.year(ii),D0);
    %       Temps.month=tempsData.month(I);
    %             Temps.month=interp1(D0(ii),Temps.month(ii),D0);
    %       Temps.day=tempsData.day(I);
    %             Temps.day=interp1(D0(ii),Temps.day(ii),D0);
    %       Temps.hour=tempsData.hour(I);
    %             Temps.hour=interp1(D0(ii),Temps.hour(ii),D0);
    %       Temps.minute=tempsData.minute(I);
    %             Temps.minute=interp1(D0(ii),Temps.minute(ii),D0);
    %       Temps.seconde=tempsData.seconde(I);
    %             Temps.seconde=interp1(D0(ii),Temps.seconde(ii),D0);

          [dI,zI]=meshgrid(DI,-P);[d0,z0]=meshgrid(D0,-P);
          Temperature=griddata(dI,zI,TemperatureI,d0,z0);
          Salinite=griddata(dI,zI,SaliniteI,d0,z0);
          Fluorimetrie=griddata(dI,zI,FluorimetrieI,d0,z0);
          Turbidite=griddata(dI,zI,TurbiditeI,d0,z0);
          Z0_=griddata(dI,zI,ZI,d0,z0);
    %       Pression=PressionI(:,I);      
    %       Pression=interp1(d(:,ii),Pression(:,ii),d);


          if (Bathy==1)
              Z0=CalculBathy(lon0,lat0);
              Z0_=-ones(size(z,1),1)*Z0;size(Z0_)
          end
                Temperature(z0<Z0_)=NaN; 
                Salinite(z0<Z0_)=NaN;
                Fluorimetrie(z0<Z0_)=NaN;
                Turbidite(z0<Z0_)=NaN;

                Densite=CalculDensite(Salinite,Temperature);
            
   figure(1),clf,
         subplot(2,1,1),image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on%
                        plot(lonI,latI,'*g')


         if(strcmp(Campagne,'OLZO')==1);
             subplot(2,1,2),ii=find(TMaree<max(T_Data) & TMaree > min(T_Data)-1);
                            plot(TMaree(ii),HauteurMaree(ii),'b'),hold on
                            ii=find(TMaree<max(T) & TMaree > min(T));
                            plot(TMaree(ii),HauteurMaree(ii),'r'),
                            axis([min(T_Data)-1 max(T_Data) min(HauteurMaree) max(HauteurMaree)])
                            box on
                            ylabel('Hauteur')
                            xlabel('Temps')
                Fich=[DossierTransect 'Transect' num2str(indTrans)  ...
                '_' indJour '_' 'Jour' ...
                    num2str(floor(JourTransectD(indTrans).j(indJour)))]
                    saveas(gcf,Fich,'fig')
         end
                        
          figure(2),Param=Temperature;Transect_Dessin,
            subplot(2,1,1),
            title(['Temperature, transect ' num2str(indTrans) ...
                '_' num2str(indJour) ' le :' ...
                num2str(floor(JourTransectD(indTrans).j(indJour))) ])
            Fich=[DossierTransect 'TemperatureTransect' num2str(indTrans)  ...
                '_' num2str(indJour) '_' 'Jour' ...
                num2str(floor(JourTransectD(indTrans).j(indJour)))]
                saveas(gcf,Fich,'fig')
%                 saveas(gcf,Fich,'png')

          figure(3),Param=Salinite;Transect_Dessin,
            subplot(2,1,1),
            title(['Salinite, transect ' num2str(indTrans) ...
                '_' num2str(indJour)  ' le :' ...
                num2str(floor(JourTransectD(indTrans).j(indJour))) ])
            Fich=[DossierTransect 'SaliniteTransect' num2str(indTrans) ...
                '_' num2str(indJour) '_' 'Jour' ...
                num2str(floor(JourTransectD(indTrans).j(indJour)))]
                saveas(gcf,Fich,'fig')
%                 saveas(gcf,Fich,'png')
    
          figure(4),Param=Fluorimetrie;Transect_Dessin,
            subplot(2,1,1),
            title(['Fluorimetrie, transect ' num2str(indTrans) ...
                '_' num2str(indJour) ' le :' ...
                num2str(floor(JourTransectD(indTrans).j(indJour))) ])
            Fich=[DossierTransect 'FluorimetrieTransect' num2str(indTrans) ...
                '_' num2str(indJour) '_'  'Jour' ...
                num2str(floor(JourTransectD(indTrans).j(indJour)))]
                saveas(gcf,Fich,'fig')
%                 saveas(gcf,Fich,'png')
    
          figure(5),Param=Turbidite;Transect_Dessin,
            subplot(2,1,1),
            title(['Turbidite, transect ' num2str(indTrans)  ...
                '_' num2str(indJour)  ' le :' ...
                num2str(floor(JourTransectD(indTrans).j(indJour)))])
            Fich=[DossierTransect 'TurbiditeTransect' num2str(indTrans) ...
                '_' num2str(indJour) '_'  'Jour' ...
                num2str(floor(JourTransectD(indTrans).j(indJour)))]
                saveas(gcf,Fich,'fig')
%                 saveas(gcf,Fich,'png')

          figure(6),Param=Densite;Transect_Dessin,
            subplot(2,1,1),
            title(['Densite, transect ' num2str(indTrans)...
                '_' num2str(indJour) ' le :' ...
                num2str(floor(JourTransectD(indTrans).j(indJour))) ])
            Fich=[DossierTransect 'DensiteTransect' num2str(indTrans) ...
                '_' num2str(indJour) '_'  'Jour' ...
                num2str(floor(JourTransectD(indTrans).j(indJour)))]
                saveas(gcf,Fich,'fig')
%                 saveas(gcf,Fich,'png')

          TransectData(NumeroTransect).Z0=Z0_;
          TransectData(NumeroTransect).T=T;
          %TransectData(NumeroTransect).Temps=Temps;
          TransectData(NumeroTransect).Temperature=Temperature;
          TransectData(NumeroTransect).Salinite=Salinite;
          TransectData(NumeroTransect).Fluorimetrie=Fluorimetrie;
          TransectData(NumeroTransect).Turbidite=Turbidite;
          TransectData(NumeroTransect).Densite=Densite;
          TransectData(NumeroTransect).z=z;
          TransectData(NumeroTransect).indTrans=indTrans;
          TransectData(NumeroTransect).JourTransectD=JourTransectD(indTrans).j(indJour);
          TransectData(NumeroTransect).JourTransectF=JourTransectF(indTrans).j(indJour);

    %       TransectPoint(indTrans).T=T;
    %       TransectPoint(indTrans).P=P;
        end
    end       
end
%save('DonneesTransect','TransectPoint','TransectStation','JourTransect','TransectData')
save('DonneesTransect','TransectPoint','TransectStation','TransectData')
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
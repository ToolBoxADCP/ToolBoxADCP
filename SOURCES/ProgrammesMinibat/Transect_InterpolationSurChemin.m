      T=T_Data(ii);
      lon=PositionData.lon(ii);
      lat=PositionData.lat(ii);
      Annee=tempsData.year(ii);
      Mois=tempsData.month(ii);
      JourJ=tempsData.day(ii);
      Heure=tempsData.hour(ii);
      Minute=tempsData.minute(ii);
      Seconde=tempsData.seconde(ii);
      Salinite=DataTot.Salinite(ii);
      Temperature=DataTot.Temperature(ii);
      Fluorimetrie=DataTot.Fluorimetrie(ii);
      Turbidite=DataTot.Turbidite(ii);
      Pression=DataTot.Pression(ii);

      Zmin=-0.1;
      dt=1/60;dz=0.01;
      
    t=linspace(min(T),max(T),500);TI=t;
    z=linspace(-max(Pression),-min(Pression),500);PressionI=-z;
    [t,z]=meshgrid(t,z);
    
    jj=find(diff(T)>0);
       T_=T(jj);lon_=lon(jj);lat_=lat(jj);
    
    ff=find(isnan(lon_)==0);lonI=interp1(T_(ff),lon_(ff),TI);
    ff=find(isnan(lat_)==0);latI=interp1(T_(ff),lat_(ff),TI);
    %pause
    AnneeI=interp1(T_,Annee(jj),TI);
      MoisI=interp1(T_,Mois(jj),TI);
      JourJI=interp1(T_,JourJ(jj),TI);
      HeureI=interp1(T_,Heure(jj),TI);
      MinuteI=interp1(T_,Minute(jj),TI);
      SecondeI=interp1(T_,Seconde(jj),TI);
      SaliniteI=griddata(T_,-Pression(jj),Salinite(jj),t,z);
      TemperatureI=griddata(T_,-Pression(jj),Temperature(jj),t,z);
      FluorimetrieI=griddata(T_,-Pression(jj),Fluorimetrie(jj),t,z);
      TurbiditeI=griddata(T_,-Pression(jj),Turbidite(jj),t,z);

%% Determination Profondeur      
    Z=-Pression;dZ=diff(Z);
    ii=find(dZ(1:end-1).*dZ(2:end)<=0);ii=ii(ii>3);ii=ii(ii<size(Z,1)-5);
    jj=find((Z(ii-3)>=Z(ii+1))&(Z(ii-2)>=Z(ii+1))&(Z(ii-1)>=Z(ii+1))&(Z(ii)>=Z(ii+1))...
            &(Z(ii-1)>=Z(ii+1))&(Z(ii)>=Z(ii+1))...
            &(Z(ii+2)>=Z(ii+1))&(Z(ii+3)>=Z(ii+1))&(Z(ii+4)>=Z(ii+1))&(Z(ii+5)>=Z(ii+1))...
            &(Z(ii+1)<Zmin));
    ZZ=Z(ii(jj)+1);T_=T(ii(jj)+1);
%      if (size(T_,1)>=2)
%         Z0_=interp1(T_,ZZ,T);
%         ii=find(diff(T_Heure)>=dTmax);ZZ(ii)=0;ZZ(ii+1)=0;
%         Z_=interp1(T_Heure,ZZ,t(1,:));
%         Z0_=ones(size(z,1),1)*Z_;
%            parametre(z<Z0_)=NaN;parametre(z>Zmin)=NaN;
%     end
      ii=find(diff(T_)>0);
      Z0_=interp1(T_(ii),ZZ(ii),t);

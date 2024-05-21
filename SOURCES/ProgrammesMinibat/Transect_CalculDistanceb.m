% lonO
% lat0
% 
% lonI
% latI
jj=find(isnan(lonI)==0);size(jj)

if (strcmp(Campagne,'OLZO')==1)
    [LatMax,IBif]=max(latI);
    if (LatMax<-21.9)
        [I]=Transect_CalcDist(lon0,lonI,lat0,latI,Lat2Metre);
    else
%      image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on%
%      plot(lon0,lat0,'*r')
%      plot(lonI,latI,'*g')
       [Lat0Max,I0Bif]=max(lat0);
        lonI_=lonI(1:IBif);
        lon0_=lon0(1:I0Bif);
        latI_=latI(1:IBif);
        lat0_=lat0(1:I0Bif);
%      plot(lon0_,lat0_,'*c')
%      plot(lonI_,latI_,'*y')
    [I1]=Transect_CalcDist(lon0_,lonI_,lat0_,latI_,Lat2Metre);
%     plot(lon0(I1),lat0(I1),'ow')
    
        lonI_=lonI(IBif+1:end);
        lon0_=lon0(I0Bif+1:end);
        latI_=latI(IBif+1:end);
        lat0_=lat0(I0Bif+1:end);
%      plot(lon0_,lat0_,'*b')
%      plot(lonI_,latI_,'*c')
    [I2]=Transect_CalcDist(lon0_,lonI_,lat0_,latI_,Lat2Metre);
%     plot(lon0(I0Bif+I2),lat0(I0Bif+I2),'ok')
    I=[I1 I0Bif+I2];
    
   end        
else
    [I]=Transect_CalcDist(lon0,lonI,lat0,latI,Lat2Metre);
end
jj=find(isnan(lonI)==0);I=I(jj);
    
    
    
    
    
%% Classement dans l'ordre des rangs des Distances      
      DI=D0(I);

%% Classement dans l'ordre croissant des Distance      
      [DI I]=sort(DI);
      SaliniteI=SaliniteI(:,I);
      TemperatureI=TemperatureI(:,I);
      FluorimetrieI=FluorimetrieI(:,I);
      TurbiditeI=TurbiditeI(:,I);
      ZI=Z0_(:,I);
      TI=TI(I);

      %% Suppression des valeurs identifiées au même point
ii=find(diff(DI)~=0);
      DI=DI(ii);
      SaliniteI=SaliniteI(:,ii);
      TemperatureI=TemperatureI(:,ii);
      FluorimetrieI=FluorimetrieI(:,ii);
      TurbiditeI=TurbiditeI(:,ii);
      ZI=ZI(:,ii);
      TI=TI(ii);
      
      
      

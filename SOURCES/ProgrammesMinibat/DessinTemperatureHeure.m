if size(find(isnan(Parametre)==0),1)>=2
BolTraceStation0=BolTraceStation;
T_Heure0=T_Heure;
Pression0=Pression;
Parametre0=Parametre;
Lon0=Lon;Lat0=Lat;
Zmin=-0.1;dTmax=15/60;
dt_dessin=1/60;dz=0.5;
t=T_Heure(1):dt_dessin:T_Heure(end);
z=-max(Pression):dz:-min(Pression);
ii=find(diff(T_Heure)>=dTmax);
   Parametre(ii+1)=NaN;Parametre(ii)=NaN;
ii=find(diff(T_Heure)~=0);
   Parametre=Parametre(ii);T_Heure=T_Heure(ii);Pression=Pression(ii);
   lon=Lon(ii);lat=Lat(ii);

[t,z]=meshgrid(t,z);
ii=find(isnan(Parametre)==0);
   parametre=griddata(T_Heure(ii),-Pression(ii),Parametre(ii),t,z);
ii=find(isnan(lon)==0);
if (size(ii,1)>1 & Bathy==1)
   lon=interp1(T_Heure(ii),lon(ii),t(1,:),'linear','extrap');
   lat=interp1(T_Heure(ii),lat(ii),t(1,:),'linear','extrap');
   if (strcmp(Campagne,'Cozomed2')==1)
      if (datenum(Jour)~=736797)
%      if (str2num(Jour)~=102)
        Z0=CalculBathy(lon,lat);
       else
        Z0=max(Pression)*ones(size(lon));
       end
   else
        Z0=max(Pression)*ones(size(lon));
   end
   Z0_=-ones(size(z,1),1)*Z0;
       parametre(z<Z0_)=NaN;parametre(z>Zmin)=NaN;
else
%pcolor(t,z,parametre),shading flat

    Z=-Pression;dZ=diff(Z);
    ii=find(dZ(1:end-1).*dZ(2:end)<=0);ii=ii(ii>3);ii=ii(ii<size(Z,1)-5);
    jj=find((Z(ii-3)>=Z(ii+1))&(Z(ii-2)>=Z(ii+1))&(Z(ii-1)>=Z(ii+1))&(Z(ii)>=Z(ii+1))...
            &(Z(ii-1)>=Z(ii+1))&(Z(ii)>=Z(ii+1))...
            &(Z(ii+2)>=Z(ii+1))&(Z(ii+3)>=Z(ii+1))&(Z(ii+4)>=Z(ii+1))&(Z(ii+5)>=Z(ii+1))...
            &(Z(ii+1)<Zmin));
    Z_=Z(ii(jj)+1);T_=T_Heure(ii(jj)+1);
    if (size(T_,1)>=2)
        ZZ=interp1(T_,Z_,T_Heure);
        ii=find(diff(T_Heure)>=dTmax);ZZ(ii)=0;ZZ(ii+1)=0;
        Z_=interp1(T_Heure,ZZ,t(1,:));
        Z0_=ones(size(z,1),1)*Z_;
           parametre(z<Z0_)=NaN;parametre(z>Zmin)=NaN;
    end
end
ii=find(isnan(parametre)==0);
if (size(ii,1)>1)
        
    parametreSurf=[];   
    parametreFond=[];   
     for tt=1:size(parametre,2)
         [kk]=find(isnan(parametre(:,tt))==0);
         if size(kk,1)~=0
           parametreSurf=[parametreSurf; parametre(min(kk),tt)];
           parametreFond=[parametreFond; parametre(max(kk),tt)];
         else
           parametreSurf=[parametreSurf; NaN];
           parametreFond=[parametreFond; NaN];
         end
             
     end
     subplot(2,1,1),
     plot(t(1,:),parametreSurf,'.k',...
          t(1,:),parametreFond,'.r',...
          t(1,:),nanmean(parametre),'.c')
        legend('Temperature de Surface',...
               'Temperature de Fond',...
               'Temperature Moyenne')
        title(['Temperature le ' Jour])
        xlabel('Heure')
        ylabel('Temperature')

        fich=[DossierDessin '/TempHeure_' Jour];
        saveas(gcf,fich,'fig')
        %saveas(gcf,fich,'png')

end

T_Heure=T_Heure0;
Pression=Pression0;
Parametre=Parametre0;
Lon=Lon0;Lat=Lat0;
BolTraceStation=BolTraceStation0;
end
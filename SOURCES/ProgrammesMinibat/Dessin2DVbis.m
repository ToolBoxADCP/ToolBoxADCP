if size(find(isnan(Parametre)==0),1)>=2
BolTraceStation0=BolTraceStation;
T_Heure0=T_Heure;
Pression0=Pression;
Parametre0=Parametre;
Lon0=Lon;Lat0=Lat;
Zmin=-0.1;dTmax=15/60;
t=T_Heure(1):dt_dessin:T_Heure(end);
z=-max(Pression):dz:-min(Pression);
if (ODV==0)
    ii=find(diff(T_Heure)>=dTmax);
       Parametre(ii+1)=NaN;Parametre(ii)=NaN;
    ii=find(diff(T_Heure)~=0); % Pour Merite
       Parametre=Parametre(ii);T_Heure=T_Heure(ii);Pression=Pression(ii);
       lon=Lon(ii);lat=Lat(ii);
       ii=find(diff(T_Heure)>0);
else
       ii=find(diff(T_Heure)~=0);T_Heure_=T_Heure(ii);
       lon=Lon(ii);lat=Lat(ii);
end

[t,z]=meshgrid(t,z);
ii=find(isnan(Parametre)==0);
   parametre=griddata(T_Heure(ii),-Pression(ii),Parametre(ii),t,z);
if size(find(isnan(lon)==1),1)~=0;
    ii=find(isnan(lon)==0);
    if (size(ii,1)>1)
       lon=interp1(T_Heure(ii),lon(ii),t(1,:),'linear','extrap');
       lat=interp1(T_Heure(ii),lat(ii),t(1,:),'linear','extrap');
    else
        disp('Soucis, pas de longitude ni de latitude')
        lon=NaN*size(t(1,:));
        lat=NaN*size(t(1,:));
    end
else
   lon=interp1(T_Heure,lon,t(1,:),'linear','extrap');
   lat=interp1(T_Heure,lat,t(1,:),'linear','extrap');
end
if (size(ii,1)>1 & Bathy==1)
   if (strcmp(Campagne,'Cozomed2') == 1|strcmp(Campagne,'Cozomed1') == 1 | ...
           strcmp(Campagne,'Merite') == 1)
       if (strcmp(Campagne,'Cozomed2') == 1)
          if (datenum(Jour)~=736797)
    %      if (str2num(Jour)~=102)
            Z0=CalculBathy(lon,lat);
           else
            Z0=max(Pression)*ones(size(lon));
          end
       else
            Z0=CalculBathy(lon,lat);
       end
   else
        Z0=max(Pression)*ones(size(lon));
   end
   Z0_=-ones(size(z,1),1)*Z0;
       parametre(z<Z0_)=NaN;parametre(z>Zmin)=NaN;
else
%pcolor(t,z,parametre),shading flat
    if (ODV==1)
        ii=find(diff(T_Heure)==0);ii=[0;ii]+1;
        jj=find(diff(ii)==2);jj=[0;jj];
        clear T_ ZZ
        for ind_=1:size(jj,1)-1
            T_(ind_)=T_Heure(ii(jj(ind_)+1));
            ZZ(ind_)=-max(Pression(ii(jj(ind_)+1:jj(ind_+1))));
        end
        Z_=interp1(T_,ZZ,t(1,:));
        Z0_=ones(size(z,1),1)*Z_;
               parametre(z<Z0_)=NaN;parametre(z>Zmin)=NaN;

    else
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
end
ii=find(isnan(parametre)==0);
if (size(ii,1)>1)
    pcolor(t,z,parametre),shading flat
    colorbar
    hold on
    plot(t(1,:),-Z0,'b')
    plot(T_Heure0,-Pression0,'.k')
        title([NomDossier ' le ' Jour])
        xlabel('Heure')
        ylabel('Profondeur')
        BolTraceStation=0;
    if (interpH==0)    
        Lon=interp1(T_Heure_,lon,t(1,:),'linear','extrap');
        Lat=interp1(T_Heure_,lat,t(1,:),'linear','extrap');
        parametre_=parametre;
        tM=ones(size(T_Heure_,1),1)*t(1,:);
        T_HeureM=T_Heure_*ones(1,size(t(1,:),2));
        tt=sqrt((tM-T_HeureM).^2);
        [Tmin,I]=nanmin(tt',[],1);
        Lon=Lon(I);Lat=Lat(I);
        parametre_=parametre(:,I);
    else
        Lon=lon;
        Lat=lat;
        parametre_=parametre;        
    end
    Parametre=nanmean(parametre_)';
    figure(18),Dessin2DH,       
        title([NomDossier 'Moy le ' Jour])
        fich=[DossierDessin '/2DH_Moy_' FichInt];
        saveas(gcf,fich,'fig')
%         saveas(gcf,fich,'png')
    Parametre=max(parametre_)';
    figure(16),Dessin2DH,       
        title([NomDossier 'Max le ' Jour])
        fich=[DossierDessin '/2DH_Max_' FichInt];
        saveas(gcf,fich,'fig')
%         saveas(gcf,fich,'png')

end

T_Heure=T_Heure0;
Pression=Pression0;
Parametre=Parametre0;
Lon=Lon0;Lat=Lat0;
BolTraceStation=BolTraceStation0;
end
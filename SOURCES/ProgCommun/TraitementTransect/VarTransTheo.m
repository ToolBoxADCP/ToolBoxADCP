close all
col=size(dsurface,1);ligne=size(dsurface,2);
col_th=size(GPSth(Tronc).dpas,2);
Tdepth_th=interp1(T_ADCPpr.dp,Tdepth,GPSth(Tronc).dpas);
ii=find(isnan(Tdepth_th)==1);Tdepth_th(ii)=0.1;


%dsurface_th=interp1(Tdp,dsurface,dpas);
%dfond_th=interp1(Tdp,dfond,dpas);
dsurface_th=ones(col_th,1)*dsurface(1,:);
dfond_th=Tdepth_th'*ones(1,ligne)-dsurface_th;
dfond_thm=0*celTr:celTr:(ligne-1)*celTr;dfond_thm=ones(col_th,1)*dfond_thm;
dsurface_thm=Tdepth_th'*ones(1,ligne)-dfond_thm;
depth_adcp_th=depth_adcp;

Tdp_t=T_ADCPpr.dp*ones(1,size(dsurface,2));
%dpas_t=dpas(4:38)'*ones(1,size(dsurface_th,2));
dpas_t=GPSth(Tronc).dpas'*ones(1,size(dsurface_th,2));
% Tu_th=interp1(Tdp,Tu,dpas);
% Tv_th=interp1(Tdp,Tv,dpas);
% Tvitesse_th=interp1(Tdp,Tvitesse,dpas);
% Tdir_deg_th=interp1(Tdp,Tdir_deg,dpas);

%% Ameliorations possible :
% On aurait pu certainement mieux interpoler horizontalement
% Tvitesse_th.u=interp2(dsurface,Tdp_t,Tvitesse.u,dsurface_th,dpas_t);
% Tvitesse_th.v=interp2(dsurface,Tdp_t,Tvitesse.v,dsurface_th,dpas_t);
% Tvitesse_th.u=interp2(dsurface,Tdp_t,Tvitesse.u,dsurface_th,dpas_t);
% Tvitesse_th.v=interp2(dsurface,Tdp_t,Tvitesse.v,dsurface_th,dpas_t);
% Tvitesse_thm.u=interp2(dsurface,Tdp_t,Tvitesse.u,dsurface_thm,dpas_t);
% Tvitesse_thm.v=interp2(dsurface,Tdp_t,Tvitesse.v,dsurface_thm,dpas_t);
% [II,JJ]=find(isnan(Tvitesse_th.u)==1);
% [IIm,JJm]=find(isnan(Tvitesse_thm.u)==1);

imax=size(dsurface,1);
TvitesseLisse.u=NaN*ones(size(Tvitesse.u));
TvitesseLisse.v=NaN*ones(size(Tvitesse.v));
for i=1:imax %Interpolation verticale
    ii=find(isnan(Tvitesse.u(i,:))==0);
    Ndegre=max(min(10,fix(size(ii,2)/2)),1);
    pp=polyfit(dsurface(i,ii),Tvitesse.u(i,ii),Ndegre);
    TvitesseLisse.u(i,ii)=polyval(pp,dsurface(i,ii));
    pp=polyfit(dsurface(i,ii),Tvitesse.v(i,ii),Ndegre);
    TvitesseLisse.v(i,ii)=polyval(pp,dsurface(i,ii));
    if(BolFig==1)
      figure(1),
      subplot(1,2,1),plot(dsurface(i,ii),Tvitesse.u(i,ii),'*b',dsurface(i,ii),TvitesseLisse.u(i,ii),'r')
      subplot(1,2,2),plot(dsurface(i,ii),Tvitesse.v(i,ii),'*b',dsurface(i,ii),TvitesseLisse.v(i,ii),'r')
    end
%pause
end

%% Dessin ?
if (BolFig==1)
  figure(2)
  subplot(1,2,1),pcolor(Tdp_t,dsurface,Tvitesse.u),caxis([-200 50])
  colorbar('horiz')
  subplot(1,2,2),pcolor(Tdp_t,dsurface,TvitesseLisse.u),caxis([-200 50])
  colorbar('horiz')
  figure(3)
  subplot(1,2,1),pcolor(Tdp_t,dsurface,Tvitesse.v),caxis([-200 150])
  colorbar('horiz')
  subplot(1,2,2),pcolor(Tdp_t,dsurface,TvitesseLisse.v),caxis([-200 150])
  colorbar('horiz')
end

%% Interpolation horizontale ===> boucle sur la profondeur
ech=10000;
imax=size(dsurface_th,2);
Tvitesse_th.u=NaN*ones(size(dsurface_th));
Tvitesse_th.v=NaN*ones(size(dsurface_th));
for i=1:imax            
    ii=find(isnan(TvitesseLisse.u(:,i))==0);
    if(size(ii,1)~=0)
      iindex=find(diff(ii)>1);iindex=[0;iindex;size(ii,1)];
    if(BolFig==1)
      figure(4),clf,hold on,plot(Tdp_t,0*Tdp_t,'ok')
      ,plot(dpas_t,0*dpas_t,'.b')
    end
      for index=1:size(iindex)-1;
    if(BolFig==1)
        figure(4),plot(Tdp_t(ii(iindex(index)+1:iindex(index+1)),i),0*Tdp_t(ii(iindex(index)+1:iindex(index+1)),i),'*r')
    end
        mi=min(Tdp_t(ii(iindex(index)+1:iindex(index+1)),i));
        ma=max(Tdp_t(ii(iindex(index)+1:iindex(index+1)),i));
        x=mi:10:ma;
        %jj=find(dfond_th(:,i)>0 & dpas_t(:,i)>mi & dpas_t(:,i)<ma);
        jj=find(dpas_t(:,i)>mi & dpas_t(:,i)<ma);
    if(BolFig==1)
        figure(4),plot(dpas_t(jj,i),0*dpas_t(jj,i),'.m')
     end
       Ndegre=max(min(10,fix(size(ii(iindex(index)+1:iindex(index+1)),1)/2)),1);
        pp=polyfit(Tdp_t(ii(iindex(index)+1:iindex(index+1)),i),TvitesseLisse.u(ii(iindex(index)+1:iindex(index+1)),i),Ndegre);
        Tvitesse_th.u(jj,i)=polyval(pp,dpas_t(jj,i));
     if(BolFig==1)
       figure(5),clf
        subplot(2,1,1),plot(Tdp_t(ii(iindex(index)+1:iindex(index+1)),i),TvitesseLisse.u(ii(iindex(index)+1:iindex(index+1)),i),'*b',dpas_t(jj,i),Tvitesse_th.u(jj,i),'or')
        y=polyval(pp,x);
        subplot(2,1,1),hold on, plot(x,y,'r')
     end

        pp=polyfit(Tdp_t(ii(iindex(index)+1:iindex(index+1)),i),TvitesseLisse.v(ii(iindex(index)+1:iindex(index+1)),i),Ndegre);
        Tvitesse_th.v(jj,i)=polyval(pp,dpas_t(jj,i));
    if(BolFig==1)
        'coucou',pause
        subplot(2,1,2),plot(Tdp_t(ii(iindex(index)+1:iindex(index+1)),i),TvitesseLisse.v(ii(iindex(index)+1:iindex(index+1)),i),'*b',dpas_t(jj,i),Tvitesse_th.v(jj,i),'or')
        y=polyval(pp,x);
        subplot(2,1,2),hold on, plot(x,y,'r')

        figure(6),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,axis(axe),hold on
        quiver(T_ADCPpr.long,-T_ADCPpr.lat,Tvitesse.u(:,i)/ech,Tvitesse.v(:,i)/ech,0,'r')
        quiver(GPSth(Tronc).xpas',-GPSth(Tronc).ypas',Tvitesse_th.u(:,i)/ech,Tvitesse_th.v(:,i)/ech,0,'b')
    end
      end
    end
end

%% Dessin ?
if(BolFig==1)
  figure(7)
  subplot(1,2,1),pcolor(Tdp_t,dsurface,TvitesseLisse.u),caxis([-200 50]),
  colorbar('horiz')
  subplot(1,2,2),pcolor(dpas_t,dsurface_th,Tvitesse_th.u),caxis([-200 50])
  colorbar('horiz')
  figure(8)
  subplot(1,2,1),pcolor(Tdp_t,dsurface,TvitesseLisse.v),caxis([-200 150])
  colorbar('horiz')
  subplot(1,2,2),pcolor(dpas_t,dsurface_th,Tvitesse_th.v),caxis([-200 150])
  colorbar('horiz')
end

% imax=size(dsurface_th,1);
% TvitesseLisse_th.u=NaN*ones(size(Tvitesse_th.u));
% TvitesseLisse_th.v=NaN*ones(size(Tvitesse_th.v));
% Tvitesse_thm.u=NaN*ones(size(dsurface_th));
% Tvitesse_thm.v=NaN*ones(size(dsurface_th));
% for i=1:imax
% %interpolation verticale ===> boucle sur l'horizontale
%     i
%     ii=find(isnan(Tvitesse_th.u(i,:))==0);
%     Ndegre=max(min(10,fix(size(ii,2)/2)),1)
%     pp=polyfit(dsurface_th(i,ii),Tvitesse_th.u(i,ii),Ndegre);
%     TvitesseLisse_th.u(i,ii)=polyval(pp,dsurface_th(i,ii));
% Tvitesse_thm.u(i,:)=polyval(pp,dsurface_thm(i,:));
%     pp=polyfit(dsurface_th(i,ii),Tvitesse_th.v(i,ii),Ndegre);
%     TvitesseLisse_th.v(i,ii)=polyval(pp,dsurface_th(i,ii));
% Tvitesse_thm.v(i,:)=polyval(pp,dsurface_thm(i,:));
%      figure(1),plot(dsurface_th(i,ii),Tvitesse_th.u(i,ii),'*b',dsurface_th(i,ii),TvitesseLisse_th.u(i,ii),'r')
%      figure(2),plot(dsurface_th(i,ii),Tvitesse_th.v(i,ii),'*w',dsurface_th(i,ii),TvitesseLisse_th.v(i,ii),'r')
%  pause,
% end
% Tvitesse_th.u=TvitesseLisse_th.u;
% Tvitesse_th.v=TvitesseLisse_th.v;
% 
% for i=1:size(II)
% Tvitesse_th.u(II(i),JJ(i))=NaN;
% Tvitesse_th.v(II(i),JJ(i))=NaN;
% end
% for i=1:size(IIm)
% Tvitesse_thm.u(IIm(i),JJm(i))=NaN;
% Tvitesse_thm.v(IIm(i),JJm(i))=NaN;
% end

% Tvitesse_th.u=interp2(dsurface,Tdp_t,Tvitesse.u,dsurface_th,dpas_t);
% Tvitesse_th.v=interp2(dsurface,Tdp_t,Tvitesse.v,dsurface_th,dpas_t);

% 17/09/09 : modif (suppression des 2 commentaires ci-dessous) faite sans verif pour eviter un bug
imax=size(dsurface_th,1);
Tvitesse_thm.u=NaN*Tvitesse_th.u;
Tvitesse_thm.v=NaN*Tvitesse_th.v;
for i=1:imax %Interpolation verticale
   A=(Tdepth_th(i)-dsurface_th(i,:));
   Tvitesse_thm.u(i,:)=interp1(A,Tvitesse_th.u(i,:),dsurface_thm(i,:));
   Tvitesse_thm.v(i,:)=interp1(A,Tvitesse_th.v(i,:),dsurface_thm(i,:));
end


T_Temps_th.day=interp1(T_ADCPpr.dp,T_Temps.day,GPSth(Tronc).dpas);
T_Temps_th.month=interp1(T_ADCPpr.dp,T_Temps.month,GPSth(Tronc).dpas);
T_Temps_th.year=interp1(T_ADCPpr.dp,T_Temps.year,GPSth(Tronc).dpas);
T_Temps_th.hour=interp1(T_ADCPpr.dp,T_Temps.hour,GPSth(Tronc).dpas);
T_Temps_th.minute=interp1(T_ADCPpr.dp,T_Temps.minute,GPSth(Tronc).dpas);
T_Temps_th.seconde=interp1(T_ADCPpr.dp,T_Temps.seconde,GPSth(Tronc).dpas);

Tvitesse_th.ubt=interp1(T_ADCPpr.dp,Tvitesse.ubt,GPSth(Tronc).dpas);
Tvitesse_th.vbt=interp1(T_ADCPpr.dp,Tvitesse.vbt,GPSth(Tronc).dpas);



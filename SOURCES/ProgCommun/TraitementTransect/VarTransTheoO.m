col=size(dsurface,1);ligne=size(dsurface,2);
col_th=size(GPSth(Tronc).dpas,2);
Tdepth_th=interp1(T_ADCPpr.dp,Tdepth,GPSth(Tronc).dpas);
ii=find(isnan(Tdepth_th)==1);Tdepth_th(ii)=0.1;


%dsurface_th=interp1(Tdp,dsurface,dpas);
%dfond_th=interp1(Tdp,dfond,dpas);
dsurface_th=ones(col_th,1)*dsurface(1,:);
dfond_th=Tdepth_th'*ones(1,ligne)-dsurface_th;
dfond_thm=1*celTr:celTr:ligne*celTr;dfond_thm=ones(col_th,1)*dfond_thm;
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
Tvitesse_th.u=interp2(dsurface,Tdp_t,Tvitesse.u,dsurface_th,dpas_t);
Tvitesse_th.v=interp2(dsurface,Tdp_t,Tvitesse.v,dsurface_th,dpas_t);
Tvitesse_thm.u=interp2(dsurface,Tdp_t,Tvitesse.u,dsurface_thm,dpas_t);
Tvitesse_thm.v=interp2(dsurface,Tdp_t,Tvitesse.v,dsurface_thm,dpas_t);


T_Temps_th.day=interp1(T_ADCPpr.dp,T_Temps.day,GPSth(Tronc).dpas);
T_Temps_th.month=interp1(T_ADCPpr.dp,T_Temps.month,GPSth(Tronc).dpas);
T_Temps_th.year=interp1(T_ADCPpr.dp,T_Temps.year,GPSth(Tronc).dpas);
T_Temps_th.hour=interp1(T_ADCPpr.dp,T_Temps.hour,GPSth(Tronc).dpas);
T_Temps_th.minute=interp1(T_ADCPpr.dp,T_Temps.minute,GPSth(Tronc).dpas);
T_Temps_th.seconde=interp1(T_ADCPpr.dp,T_Temps.seconde,GPSth(Tronc).dpas);

Tvitesse_th.ubt=interp1(T_ADCPpr.dp,Tvitesse.ubt,GPSth(Tronc).dpas);
Tvitesse_th.vbt=interp1(T_ADCPpr.dp,Tvitesse.vbt,GPSth(Tronc).dpas);




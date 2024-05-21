  Tfile=[dfile(Tronc,:) num2str(NbTrans(Tronc))];
  Tfile_th=[dfile_th(Tronc,:) num2str(NbTrans(Tronc))];
  
  clear T_ADCPpr T_ADCP T_Temps Tvitesse
  T_ADCP.long=ADCP_T(Tronc).long(Itrans(itrans):Itrans(itrans+1));
  T_ADCP.lat=ADCP_T(Tronc).lat(Itrans(itrans):Itrans(itrans+1));
  T_ADCPpr.dp=ADCPpr_T(Tronc).dp(Itrans(itrans):Itrans(itrans+1));
  T_ADCPpr.long=ADCPpr_T(Tronc).long(Itrans(itrans):Itrans(itrans+1));
  T_ADCPpr.lat=ADCPpr_T(Tronc).lat(Itrans(itrans):Itrans(itrans+1));
  T_Temps.day=Temps_T(Tronc).day(Itrans(itrans):Itrans(itrans+1));
  T_Temps.month=Temps_T(Tronc).month(Itrans(itrans):Itrans(itrans+1));
  T_Temps.year=Temps_T(Tronc).year(Itrans(itrans):Itrans(itrans+1));
  T_Temps.hour=Temps_T(Tronc).hour(Itrans(itrans):Itrans(itrans+1));
  T_Temps.minute=Temps_T(Tronc).minute(Itrans(itrans):Itrans(itrans+1));
  T_Temps.seconde=Temps_T(Tronc).seconde(Itrans(itrans):Itrans(itrans+1));
  Tvitesse.ubt=vitesse_T(Tronc).ubt(Itrans(itrans):Itrans(itrans+1));
  Tvitesse.vbt=vitesse_T(Tronc).vbt(Itrans(itrans):Itrans(itrans+1));
  Tvitesse.u=vitesse_T(Tronc).u(Itrans(itrans):Itrans(itrans+1),:);
  Tvitesse.v=vitesse_T(Tronc).v(Itrans(itrans):Itrans(itrans+1),:);
  Tdepth=ADCPpr_T(Tronc).depth(Itrans(itrans):Itrans(itrans+1));
  [Tvitesse.u,Tvitesse.v]=Rotation(Tvitesse.u,Tvitesse.v,errTr);

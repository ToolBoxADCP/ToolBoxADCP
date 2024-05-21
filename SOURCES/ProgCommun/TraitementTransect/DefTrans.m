RechercheTransect=1;
%% Initialisation
% Positions GPS
    bmin=GPS_borne(nb).min;bmax=GPS_borne(nb).max;
    
    fGPSr.long=fGPS.long(bmin:bmax);
    fGPSr.lat=fGPS.lat(bmin:bmax);
    
    TempsGPSr.year=TempsGPS.year(bmin:bmax);
    TempsGPSr.month=TempsGPS.month(bmin:bmax);
    TempsGPSr.day=TempsGPS.day(bmin:bmax);
    TempsGPSr.hour=TempsGPS.hour(bmin:bmax);
    TempsGPSr.minute=TempsGPS.minute(bmin:bmax);
    TempsGPSr.seconde=TempsGPS.seconde(bmin:bmax);
    
    t_GPSr=(datum_str(TempsGPSr)-T0)*24*3600;
 
% Données de l'ADCP 
    %Vitesse projetée sur ellipse
    [Temps ,vitesse,depth]=lecture_proj(Jfile(nb,:),Trans_borne(nb).min,Trans_borne(nb).max,sens(nb),BottomTrack(nb),tetaMoy); 
    %Vitesse Non projetée :
    %[Temps ,vitesse,depth]=lecture(Jfile(nb,:),Trans_borne(nb).min,Trans_borne(nb).max,sens(nb),BottomTrack(nb)); 
    t_ADCP=(datum_str(Temps)-T0)*24*3600;%

 % Interpolation et positionnement des mesures
    ADCP.long=spline(t_GPSr,fGPSr.long,t_ADCP); 
    ADCP.lat=spline(t_GPSr,fGPSr.lat,t_ADCP);
 %wi=spline(tn,w,ti);   %vitesse du bateau
figure(6),clf
plot(t_GPSr,fGPSr.long,'o')
hold on,plot(t_ADCP,ADCP.long,'+r') 
%% Dessin
     %DessinTrans 

%% Nettoyage des données
 %ii=find(wi<wi_inf & wi>wi_sup);
 vit_bt=sqrt(vitesse.ubt.^2+vitesse.vbt.^2);
 %clf,plot(vit_bt)
 ii=find(vit_bt>wi_inf*513.9 & vit_bt<wi_sup*513.9);  % pour transf les vitesses en noeud en mm/s
%hold on, ii,plot(vit_bt(ii),'r')
 nettoyage;
 ADCP.long=ADCP.long(ii);ADCP.lat=ADCP.lat(ii);
 
 t_ADCP=t_ADCP(ii);
 hold on,plot(t_ADCP,ADCP.long,'*k')
 %wi=wi(ii);        
 
%% Ici on peut mettre notre repérage de point associé au transect et troncon.
if(size(ADCP.long,1)>0)
  clear TronconADCP ADCPpr
  for Tronc=1:nbTronc;
    TronconADCP(Tronc,:)=0*ones(size(ADCP.long));
    [ADCPpr(Tronc).long,ADCPpr(Tronc).lat]=projection_ortho(ADCP.long,ADCP.lat,p_TS(Tronc,1),p_TS(Tronc,2));
    d=sqrt((dLong*(ADCP.long-ADCPpr(Tronc).long)).^2+(dLat*(ADCP.lat-ADCPpr(Tronc).lat)).^2);
    ii=find (d<dmin);TronconADCP(Tronc,ii)=ones(size(ii));
    ADCPpr(Tronc).dp=sqrt(((ADCPpr(Tronc).long-GPSth_Deb(Tronc).long)*dLong).^2+((ADCPpr(Tronc).lat-GPSth_Deb(Tronc).lat)*dLat).^2);
  end


%% Recherche des transects
  t_ADCPc=t_ADCP;
  for Tronc=1:nbTronc;
   DessinTrans 
   iiTronc=find(TronconADCP(Tronc,:)==1);reducADCP;
   t_ADCP=t_ADCPc(iiTronc);


%% Recherche des transects
    if(RechercheTransect==1)
      RechTransect
    end

%% Sauvegarde des valeurs / transect et / transect théo
    for itrans=1:size(Itrans)-1;
    %Choix des transect à conserver
      tempo.long=ADCP_T(Tronc).long(Itrans(itrans):Itrans(itrans+1));
      tempo.lat=ADCP_T(Tronc).lat(Itrans(itrans):Itrans(itrans+1));
      %tempo.dp=ADCPpr_T(Tronc).dp(Itrans(itrans):Itrans(itrans+1));
      tempo_pr.long=ADCPpr_T(Tronc).long(Itrans(itrans):Itrans(itrans+1));
      tempo_pr.lat=ADCPpr_T(Tronc).lat(Itrans(itrans):Itrans(itrans+1));
    
      close all,figure(2),clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,axis(axe),hold on
      plot(tempo.long,-tempo.lat,'.')
      plot(tempo_pr.long,-tempo_pr.lat,'.r')
      Tronc
      if(Reponse==1)
         reply=RepFich(iReponse);
         if(reply==1),reply='Y';end
         if(reply==0),reply='N';end
         iReponse=iReponse+1;
                  %if(iReponse>80),reply,pause,end
      else
       reply = input('Transect à conserver ? Y/N', 's');
%      if isempty(reply)
%         reply = 'Y';
%      end
      end
      if(reply=='Y')
        NbTrans(Tronc)=NbTrans(Tronc)+1;
        VarTrans
        FormTrans
        %save(Tfile, 'T_ADCPei','Tsi','Tday','Tmonth','Tyear','Thour','Tminute','Tseconde','Tubt','Tvbt','Tdir_deg','Tu','Tv','Tdepth','Tvitesse','depth_adcp','dsurface','dfond','TEp','TSp')   
        save(Tfile, 'T_ADCP','T_Temps','Tvitesse','Tdepth','depth_adcp','dsurface','dfond','T_ADCPpr')

        VarTransTheo
        save(Tfile_th, 'T_Temps_th','Tvitesse_th','Tvitesse_thm','Tdepth_th','depth_adcp_th','dsurface_th','dfond_th','dsurface_thm','dfond_thm')
        %save(Tfile_th, 'Tday_th','Tmonth_th','Tyear_th','Thour_th','Tminute_th','Tseconde_th','Tubt_th','Tvbt_th','Tdir_deg_th','Tu_th','Tv_th','Tdepth_th','Tvitesse_th','Tdir_deg_thm','Tu_thm','Tv_thm','Tvitesse_thm','depth_adcp_th','dsurface_th','dfond_th','dsurface_thm','dfond_thm')
      end 
    end
    disp('Tronçon :'),disp(Tronc)
    disp('nb de transect :'),disp(NbTrans)
  end
end

  

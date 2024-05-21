time1=(datum_str(Temps)-T0)*24*3600;% en secondes

if (FichPression=='ADCP ')
  tinterp=time1;
  Sauv_depth=depth;
elseif (FichPression=='ascii')
   Pression=load (DonneesPression);
   P=Pression(:,2);
   P_Temps.day=Pression(:,3);P_Temps.month=Pression(:,4);
   P_Temps.year=Pression(:,5);
   P_Temps.hour=Pression(:,6);P_Temps.minute=Pression(:,7);
   P_Temps.seconde=Pression(:,8);    

   P_t=(datum_str(P_Temps)-T0)*24*3600;

%    if (size(time1)==0); time1=min(P_t):max(P_t);end
%    tt=find(P_t>min(time1)&P_t<max(time1));
%    P=P(tt);
%    P_Temps.year=P_Temps.year(tt);
%    P_Temps.month=P_Temps.month(tt);
%    P_Temps.day=P_Temps.day(tt);
%    P_Temps.hour=P_Temps.hour(tt);
%    P_Temps.minute=P_Temps.minute(tt);
%    P_Temps.seconde=P_Temps.seconde(tt);
%    P_t=P_t(tt);
   
   Sauv_depth=P;
   tinterp=P_t;
   depth=interp1(tinterp,Sauv_depth,time1);

elseif (FichPression=='donne')
    load (DonneesPression)
    tsab.year=floor(tinterp/3600/24/365);
    tsab.month=floor((tinterp/3600/24-tsab.year*365)/30);
    tsab.day=floor(tinterp/3600/24-tsab.year*365-tsab.month*30);
    tsab.hour=floor(tinterp/3600-(tsab.year*365+tsab.month*30+tsab.day)*24);
    tsab.minute=floor(tinterp/60-(((tsab.year*365+tsab.month*30+tsab.day)*24+tsab.hour)*60));
    tsab.seconde=tinterp-((((tsab.year*365+tsab.month*30+tsab.day)*24+tsab.hour)*60+tsab.minute)*60);
    tinterp=datum_str(tsab)*3600*24;
    tsab.year=tsab.year+2000;
    tinterp=datum_str(tsab)*3600*24;
    tinterp=tinterp-T0*3600*24;
    Sauv_depth=depth;
    depth=interp1(tinterp,Sauv_depth,time1);
 
elseif (FichPression=='mat  ')
   load (DonneesPression);
   P_t=(datum_str(P_Temps)-T0)*24*3600;
   P=Pression;
   if (size(time1)==0); time1=min(P_t):max(P_t);end
%    tt=find(P_t>min(time1)&P_t<max(time1));
%    P=P(tt);
%    P_Temps.year=P_Temps.year(tt);
%    P_Temps.month=P_Temps.month(tt);
%    P_Temps.day=P_Temps.day(tt);
%    P_Temps.hour=P_Temps.hour(tt);
%    P_Temps.minute=P_Temps.minute(tt);
%    P_Temps.seconde=P_Temps.seconde(tt);
%    P_t=P_t(tt);
   
   Sauv_depth=P;
   tinterp=P_t;
   depth=interp1(tinterp,Sauv_depth,time1);
   
elseif (strcmp(FichPression,'Autre')==1) 
   [tinterp,depth]=LectureDonneesPression(DonneesPression,T0);
   Sauv_depth=depth;
  % depth=interp1(tinterp,Sauv_depth,time1);
   
elseif (FichPression=='Non  ')
   depth=100*ones(size(t,2),1);
   if (size(time1)==0); time1=t;else tinterp=time1; end
   tinterp=time1;
   Sauv_depth=depth;
end;


%% Estimation du niveau d'eau pendant le temps d'immersion de l'ADCP
%if (strcmp(FichPression,'Autre')==1) 
if ((strcmp(FichPression,'Non  ')==0) & (strcmp(LissagePression,'Oui')==1)) ...
   Harm=HarmoniqueNondes('div',depth,tinterp,1,size(tinterp,1),time1);
   depth=Harm.lin(1)+Harm.lin(2)*time1/24/3600;
   for i=1:NbOndes
    depth=depth+Harm.ampl(i)*sin(Harm.omega(i)*time1/3600+Harm.phase(i));
   end
   ii=find(isnan(Harm.res)==1);Harm.res(ii)=0;
   depth=depth+Harm.res;
elseif (strcmp(FichPression,'Autre')==1)
   Harm=HarmoniqueNondes('div',depth,tinterp,1,size(tinterp,1),time1);
   depth=ProfMoy;
   for i=1:NbOndes
    depth=depth+Harm.ampl(i)*sin(Harm.omega(i)*time1/3600+Harm.phase(i));
   end
elseif (strcmp(FichPression,'Non  ')==1)
   depth=100*ones(size(time1,1),1);
end

figure,plot(tinterp,Sauv_depth),hold on,plot(time1,depth,'g')

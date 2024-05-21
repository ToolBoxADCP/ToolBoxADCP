T1=15.92;T2=18.35;

load('../Traitement_Tulear_sept09/TransectReconstituee/Flux_TS_1')
load('../Traitement_Tulear_sept09/TransectReconstituee/Flux_TN_1')
for i=1:4
figure,clf,image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on
plot(PositionMouillage.long,PositionMouillage.lat,'og')
axis([43.45 43.85 -23.6 -23.2])
end

 for i=1:4
     Fich='./Flux_';
    figure(i)
      fichM=[Fich num2str(i)];
  saveas(gcf,fichM,'fig')
  saveas(gcf,fichM,'png')

 end


load(MouillageMoy)
t=(datum_str(Temps)-T0)*24;
 Section_M=interp1(Flux.temps,Section,t);
load(MouillagePropre)
Section_M=sum(nanmean(Section),2)/nanmean(P.depth)*P.depth;
Flux_Mouillage.u=sum(Section_M,2).*VitMoy_proj.u(1:end)/1000;
Flux_Mouillage.v=sum(Section_M,2).*VitMoy_proj.v(1:end)/1000;
ind=1:length(Flux_Mouillage.u);
ii=find(isnan(Flux_Mouillage.u)==0);
Flux_Mouillage.u=Flux_Mouillage.u(ii);
Flux_Mouillage.u=interp1(ii,Flux_Mouillage.u,ind);
ii=find(isnan(Flux_Mouillage.v)==0);
Flux_Mouillage.v=Flux_Mouillage.v(ii);
Flux_Mouillage.v=interp1(ii,Flux_Mouillage.v,ind);

ech=2E-5;
plot(t/24,Flux_Mouillage.u,'b')%,Flux.temps/24,Flux.u,'r')
disp([nanmean(Flux.u),nanmean(Flux_Mouillage.u)])
figure(1)
[cap,module]=uv2dirspeed(nanmean(Flux_Mouillage.v),nanmean(Flux_Mouillage.u));
[v,u]=dir2uv(cap+tetaMoy*180/pi,module);
quiver(PositionMouillage.long,PositionMouillage.lat,u*ech,v*ech,0,'linewidth',2)

ii=find(t<T1*24);
disp([nanmean(Flux_Mouillage.u(ii))])
figure(2)
[cap,module]=uv2dirspeed(nanmean(Flux_Mouillage.v(ii)),nanmean(Flux_Mouillage.u(ii)));
[v,u]=dir2uv(cap+tetaMoy*180/pi,module);
quiver(PositionMouillage.long,PositionMouillage.lat,u*ech,v*ech,0,'linewidth',2)

ii=find(t>T1*24&t<T2*24);
disp([nanmean(Flux_Mouillage.u(ii))])
figure(3)
[cap,module]=uv2dirspeed(nanmean(Flux_Mouillage.v(ii)),nanmean(Flux_Mouillage.u(ii)));
[v,u]=dir2uv(cap+tetaMoy*180/pi,module);
quiver(PositionMouillage.long,PositionMouillage.lat,u*ech,v*ech,0,'linewidth',2)

ii=find(t>T2*24);
disp([nanmean(Flux_Mouillage.u(ii))])
figure(4)
[cap,module]=uv2dirspeed(nanmean(Flux_Mouillage.v(ii)),nanmean(Flux_Mouillage.u(ii)));
[v,u]=dir2uv(cap+tetaMoy*180/pi,module);
quiver(PositionMouillage.long,PositionMouillage.lat,u*ech,v*ech,0,'linewidth',2)





DessinTransect_loc
%% Recherche d'un point qui servira de ref pour le niveau
i=0;
Pression='Non  ';
while (strcmp(Pression,'Non  ')==1)
  i=i+1;
  DonneesCampagne(Nom(i,:));
end
  disp(Nom(i,:))
  load (MouillagePropre)
  load(MouillageAnalyse)
  Niv=detrend(P.depth);
  Niv_int=VitesseCalculeeAvecHarmonique...
        (NbOndes,HarmoniqueH,HarmoniqueH.temps,T0)...
        +HarmoniqueH.MoyGliss;
  dNiv=diff(Niv_int);
  t_niv=((datum_str(Temps))-T0)*24;% en jour

index=1;
  for ind = 1:size(ind_ref,1);i=ind_ref(ind);

%% Calcul du niveau
% lecture des variables
    Nom(i,:),DonneesCampagne(Nom(i,:))
for Tronc=1:nbTronc;
    load(FluxReconst(Tronc,:))

    if (strcmp(Pression,'Non  ')==0)
      H=mean(P.depth);
    else
      ii=find(isnan(Niv)==0);H=-min(Niv(ii))+0.5;
    end

% Dessin
    load (MouillagePropre_proj)
    t_M=((datum_str(Temps)-T0))*24;dt=diff(t_M);dt=[dt;dt(end)]*3600;
    t_M=t_M(1:end-1);
    Niv_M=interp1(t_niv,Niv,t_M);
    dNiv_M=interp1(t_niv(1:length(dNiv)),dNiv,t_M);
    
%% Marée haute // Marée basse
    ii=find(Niv_M<0);
%     Flux_lowtide=sum(abs(nanmean(vitesse.u(ii,:),2)).*(H+Niv_M(ii)).*dt(ii))...
%         /1000/sum(dt(ii));
    Flux_lowtide=nanmean(Flux.u(ii));
    FluxSection_lowtide(index).u=nanmean(FluxSection.u(ii,:));
    FluxSection_lowtide(index).v=nanmean(FluxSection.v(ii,:));

    ii=find(Niv_M>0);
    Flux_hightide=nanmean(Flux.u(ii));
    FluxSection_hightide(index).u=nanmean(FluxSection.u(ii,:));
    FluxSection_hightide(index).v=nanmean(FluxSection.v(ii,:));
    
    Flux_tot=nanmean(Flux.u);
    FluxSection_tot(index).u=nanmean(FluxSection.u(:,:));
    FluxSection_tot(index).v=nanmean(FluxSection.v(:,:));
    
    disp([Flux_lowtide Flux_hightide Flux_tot...
        Flux_lowtide/(Flux_lowtide+Flux_hightide)*100 ...
        Flux_hightide/(Flux_lowtide+Flux_hightide)*100])%*3600*6

%% Marée montante // Marée descendante
    ii=find(dNiv_M<0);
    Flux_ebb=nanmean(Flux.u(ii));
    FluxSection_ebb(index).u=nanmean(FluxSection.u(ii,:));
    FluxSection_ebb(index).v=nanmean(FluxSection.v(ii,:));
    
    ii=find(dNiv_M>0);
    Flux_flow=nanmean(Flux.u(ii));
    FluxSection_flow(index).u=nanmean(FluxSection.u(ii,:));
    FluxSection_flow(index).v=nanmean(FluxSection.v(ii,:));
        
    disp([Flux_ebb Flux_flow Flux_tot...
        Flux_ebb/(Flux_ebb+Flux_flow)*100 ...
        Flux_flow/(Flux_ebb+Flux_flow)*100])%*3600*6
    
load (Ftransth)
    Pos(index).x=GPSth(Tronc).xpas;
    Pos(index).y=GPSth(Tronc).ypas;
    tetaMoy_T(index)=tetaMoy;
    index=index+1;
%pause
end
end


ech=.25E-3;
fich='./DessinRobert/Flux';
DessinFlux(Pos,FluxSection_tot,tetaMoy_T,ech,fich,...
    'total')
fich='./DessinRobert/Flux_lowtide';
DessinFlux(Pos,FluxSection_lowtide,tetaMoy_T,ech,fich,...
    'Maree basse')
fich='./DessinRobert/Flux_hightide';
DessinFlux(Pos,FluxSection_hightide,tetaMoy_T,ech,fich,...
    'Maree haute')
fich='./DessinRobert/Flux_ebb';
DessinFlux(Pos,FluxSection_ebb,tetaMoy_T,ech,fich,...
    'Jusant')
fich='./DessinRobert/Flux_flow';
DessinFlux(Pos,FluxSection_flow,tetaMoy_T,ech,fich,...
    'Flot')
%close all

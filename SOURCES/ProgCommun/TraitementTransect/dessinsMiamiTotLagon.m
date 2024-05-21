DessinTransect_loc
DirMouillage='./DessinRobert/Fonctionnement';[a,b]=mkdir(DirMouillage);
FichM=[DirMouillage '/T_'];

%% Initialisation :
ech=10000;dt=1/60/24;
T_deb=100;%10;%1*24;
T_fin=15*24;
dT=1;
i_passe=1;
        MinCap=0;
        MaxCap=360;
        MinMod=0;
        MaxMod=ModMax(i_passe);

load('./MouillagePropre/MS_GPpr')
%load('./MouillagePropre/MNpr')
Niv=detrend(P.depth);
t_Niv=(datum_str(Temps)-T0)*24;


%load (MouillagePropre_proj)
T_deb=max(T_deb,min(t_Niv))
T_fin=min(T_fin,max(t_Niv))
%for TT=T_deb:dT:T_fin;
TT=T_deb;
while(TT<T_fin)      
%% Niveau :
    figure(2),clf
    plot(t_Niv,Niv),hold on
    [dminTemps,ind_minTemps]=min(abs(t_Niv-TT));
    plot(t_Niv(ind_minTemps),Niv(ind_minTemps),'or')
    axis([T_deb-6 T_fin+6 -2 2 ])

    figure(1),clf,
    image(Ylong,Xlat,Photo),axis('equal'),axis xy,hold on,%axis(axe)
    i_T=1;
        
    for ind = 1:size(ind_ref,1);i=ind_ref(ind);
        Nom(i,:);  DonneesCampagne(Nom(i,:))%,pause
        load (MouillagePropre)

        % Mouillage : Vitesse du mouillage sur tout le temps de la manip :
        %i_M=10;
        t_M=(datum_str(Temps)-T0)*24;
        i_M=MaxProf(vitesse);
        P_M=P(1);
        load (MouillageAnalyse)
        load (MouillageAnalyse_proj)


        uM=interp1(t_M,vitesse.u(:,i_M),TT);
        vM=interp1(t_M,vitesse.v(:,i_M),TT);
        MinU=min(uM);MaxU=max(uM);
        MinV=min(vM);MaxV=max(vM);

        X=PositionMouillage.lat;
        Y=PositionMouillage.long;
        figure(1)
        plot(PositionMouillage.long,PositionMouillage.lat,'+r')

        figure(1),quiver(Y,X,uM/ech,vM/ech,0,'r')

        % Transect :
        % Interpolation sur tout le transect � l'instant en question
        for Tronc=nbTronc:-1:1;
            col='c';
            if(Tronc==1&ind~=4),col='w';end
            %disp('Tron�on :'),disp(Tronc)
            load (Ftransth)
            load (point(Tronc,:))
            load(VitReconst(Tronc,:))
            [dminTemps,ind_minTemps]=min(abs(Tr_reconst.Temps-TT));
            U=squeeze(Tr_reconst.U(ind_minTemps,:,:));
            V=squeeze(Tr_reconst.V(ind_minTemps,:,:));
            [cap,module]=uv2dirspeed(V,U);
            [v,u]=dir2uv(cap+tetaMoy*180/pi,module);

            figure(1),quiver(GPSth(Tronc).xpas',-GPSth(Tronc).ypas',u(:,i_T)/ech,v(:,i_T)/ech,0,col)

            titre=[cellstr([datestr(TT/24+T0) ])];
            title(titre)
        end
    end
    figure(2)
    disp(' ')
    disp(' ')
    disp('Heure : '),disp(TT) 
    disp('')
    disp('Appuyer sur "entree" pour continuer')
    disp('        sur "1"      si retour : ')
    Pause=input('        sur "0"      pour sauver : ') ;
    if(~isempty(Pause)&Pause==1),TT=TT-2*dT;end
    if(~isempty(Pause)&Pause==0),
        disp('Sauvegarde de l image dans')        
        fich1=[FichM num2str(TT) '_Lagon'];
        fich2=[FichM num2str(TT) '_Niveau'];
        disp(fich1 )
        disp('et')
        disp(fich2)
        figure(1)
        saveas(gcf,fich1,'fig')
        saveas(gcf,fich1,'png')
        figure(2)
        saveas(gcf,fich2,'fig')
        saveas(gcf,fich2,'png')
    end
    TT=TT+dT;


end
  

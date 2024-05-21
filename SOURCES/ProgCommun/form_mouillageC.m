function form_mouillageC(i)
GlobaleVar

DonneesCampagne(i)

% 10/07/07 S.R. Mise en forme des donn�es de mouillage
% num d�signe le mouillage et les param�tres de l'appareil associ�s
% 1: MN1
% 2: MN2
% 3: MB
% 4: MS
% Sorties:
% day, month, year, hour , minute, seconde: date et heure de la mesure
% u_mmsec, v_mmsec,vitesse_mmsec, dir_deg : resp. vitesse Est, vitesse
% Nord, norme de la vitesse en mm/s, direction en degr�s
% depth_adcp_m: immersion de l'adcp 
% dsurface_m, dfond_m: resp. distance de chaque cellule par rapport � la
% surface et par rapport au fond

%function [day, month, year, hour ,u_mmsec, v_mmsec, dir_deg, vitesse_mmsec, depth_adcp_m, dsurface_m, dfond_m,minute, seconde]=form_mouillage(num);
if (NomADCP=='Fictif')
    MouillagePropref=MouillagePropre;
    if (exist('echo','var'))
        EchoPropref=EchoPropre;
    end
    if (exist('temperature','var'))
        TemperaturePropref=TemperaturePropre;
    end
    ConstructionMouillage1dFictif 
    MouillagePropre=MouillagePropref;
    if (exist('echo','var'))
        EchoPropre=EchoPropref;
    end
    if (exist('temperature','var'))
        TemperaturePropre=TemperaturePropref;
    end
else
    if (exist(BorneMouillage,'file')==2)
        load (BorneMouillage)
    end
    param_form_mouillageC
    Niv_eau

    %% Nettoyage des pics, au dessus de 3000mm/s
    vitesse=clean_str(3000,vitesse);

    P=[];
    P.lat=PositionMouillage.lat;
    P.long=PositionMouillage.long;
    P.depth=depth;

        [ligne,col]=size(vitesse.u);
        vectX=ones(ligne,1);    vectY=ones(1,col);    vect=0:col-1;
    if (col>1)
        P_Adcp.surface_f= depth*vectY - vectX*(celM*vect+hadcpM+blankM);
        P_Adcp.fond_f=vectX*(celM*vect+hadcpM+blankM);
    else
        P_Adcp.surface_f= depth;
        P_Adcp.fond_f=vectX*hadcpM;        
    end


    %% Elimination des valeurs echo
    if col >1
        figure, pcolor(time1*vectY/3600/24,P_Adcp.fond_f,vitesse.u),colorbar,shading flat
        ind=find(P_Adcp.surface_f<nanmean(P.depth)*1/10);
        P_Adcp.surface_f(ind)=NaN;
        P_Adcp.fond_f(ind)=NaN;
        vitesse.v(ind)=NaN;
        vitesse.u(ind)=NaN;errM
        [vitesse.u,vitesse.v]=Rotation(vitesse.u,vitesse.v,errM);
    else
        [vitesse.u,vitesse.v]=Rotation(vitesse.u,vitesse.v,errM);
    end    
end

%% Dessin
if (col>1)
    figure,plot(P_Adcp.surface_f)
    figure,plot(P_Adcp.fond_f)
    figure, pcolor(time1*vectY/3600/24,P_Adcp.fond_f,sqrt(vitesse.u.^2+vitesse.v.^2)),
    colorbar,shading flat
    hold on, plot(time1/3600/24,P.depth,'r')

    figure, pcolor(time1*vectY/3600/24,P_Adcp.fond_f,vitesse.u),colorbar,shading flat
    hold on, plot(time1/24/3600,P.depth,'r')
    figure, pcolor(time1*vectY/3600/24,P_Adcp.fond_f,vitesse.v),colorbar,shading flat
    hold on, plot(time1/24/3600,P.depth,'r')
else
    figure, 
        subplot(3,1,1),plot(time1/24/3600,vitesse.u),
        subplot(3,1,2),plot(time1,vitesse.v),
        subplot(3,1,3),plot(time1/24/3600,P.depth,'r')    
end
    
%% Sauvegarde
[a,b]=mkdir (Dir_DonneesPropres);

save(MouillagePropre, 'P','Temps','P_Adcp','vitesse')
if (exist('echo','var')) & size(EchoPropre,1)>=1
    save(EchoPropre, 'P','Temps','P_Adcp','echo')
end
if (exist('temperature','var')) & size(TemperaturePropre)>=1
    save(TemperaturePropre, 'P','Temps','P_Adcp','temperature')
end

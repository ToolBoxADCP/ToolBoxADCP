fichTransect='.\DessinRobert\Transect\Interpolation\';
dirTransect='.\DessinRobert\Transect\Interpolation';[a,b]=mkdir(dirTransect);
T_deb=00;%1*24;
T_fin=15*24;
T_fin=3*24;
dT=0.5;
DessinTransect_loc
RecalculVitesse=0;

for i_passe=1:3%size(Passe,1)
    DonneesCampagne(Nom(ind_ref(i_passe),:))
    load(Ftransth)
    MinU=999;MinV=MinU;
    MaxU=-999;MaxV=MaxU;
    for Tronc=1:nbTronc;
        
        if(RecalculVitesse==1)
            P0=P0_tous(i_passe);
            pre_traitement_dephasage
        else
            load(VitReconst(Tronc,:))
        end

        MinCap=0;
        MaxCap=360;
        MinMod=0;
        MaxMod=1000;


        %% Vitesse Interpolée
        clear module cap U V
        for TT=T_deb:dT:min(T_fin,max(Tr_reconst.Temps));
            if(RecalculVitesse==1)
                ReconstitutionProfil
            else
                [dminTemps,ind_minTemps]=min(abs(Tr_reconst.Temps-TT));
                Temps_interp=Tr_reconst.Temps(ind_minTemps)
                U=squeeze(Tr_reconst.U(ind_minTemps,:,:));
                V=squeeze(Tr_reconst.V(ind_minTemps,:,:));
                [cap,module]=uv2dirspeed(V,U);cap=mod(cap+tetaMoy*180/pi,360);
            end

            %%   Dessin Vitesse Interpolée
            figure(1),clf
            subplot(1,2,1),

            if(RecalculVitesse==1)
                pcolor(GPSth(Tronc).dpas'/1000,-surface_interp',cap')
            else
                pcolor(Tr_reconst.dpas/1000,Tr_reconst.z,cap')
            end

            colorbar('horiz')
            if(~isnan(Temps_interp))
                titre=[cellstr(['Interp - Passe : ' Passe(i_passe,:)]) ...
                    cellstr(['au ' datestr(Temps_interp/24+T0) ])];
            else
                titre=cellstr(['Interp - Passe : ' Passe(i_passe,:)]);
            end
            title(titre)
            colorbar('horiz')
            xlabel('distance a la cote (km)'),ylabel('Profondeur (m)')
            axis([Xmin(i_passe) Xmax(i_passe) Ymin(i_passe) Ymax(i_passe)])
            caxis([MinCap MaxCap])

            subplot(1,2,2),
            if(RecalculVitesse==1)
                pcolor(GPSth(Tronc).dpas'/1000,-surface_interp',module')
            else
                pcolor(Tr_reconst.dpas/1000,Tr_reconst.z,module')
            end
            colorbar('horiz')
            titre=[cellstr(['Troncon ' num2str(Tronc)])];
            title(titre)
            xlabel('distance a la cote (km)'),ylabel('Profondeur (m)')
            caxis([MinMod MaxMod])
            axis([Xmin(i_passe) Xmax(i_passe) Ymin(i_passe) Ymax(i_passe)])

            %       fichM_interp=[fichTransect  ...
            %           num2str(char(cellstr(PasseDimi(i_passe,:))))...
            %           '_Trans' num2str(j) '_Tronc' num2str(Tronc) 'Interp'];
            %
            %       saveas(gcf,fichM_interp,'fig')
            %       saveas(gcf,fichM_interp,'png')

            figure(2),clf
            load(MouillagePropre)
            t=(datum_str(Temps)-T0)*24;
            plot(t,P.depth-nanmean(P.depth)),hold on
                [dminTemps,ind_minTemps]=min(abs(t-Temps_interp));
            plot(t(ind_minTemps),P.depth(ind_minTemps)-nanmean(P.depth),'or')
           


pause
        end
    end
end
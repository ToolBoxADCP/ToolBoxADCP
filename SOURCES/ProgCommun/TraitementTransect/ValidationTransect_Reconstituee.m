fichTransect='./DessinRobert/Transect/Interpolation/';
dirTransect='./DessinRobert/Transect/Interpolation';[a,b]=mkdir(dirTransect);

DessinTransect_loc
RecalculVitesse=0;
U_reconst =[];U_mes=[];
V_reconst =[];V_mes=[];

figure(1),clf
subplot(2,2,1),hold on
subplot(2,2,2),hold on

for i_passe=1:size(Passe,1)
    DonneesCampagne(Nom(ind_ref(i_passe),:))
    %% Vitesse Reconstituee
    load(Ftransth)
       if(RecalculVitesse==1)
           P0=P0_tous(i_passe);
           pre_traitement_dephasage
       else
           load(VitReconst(Tronc,:))
       end

    for Tronc=1:1%nbTronc;
      A=[dfile_th(Tronc,:) '*'];a=dir(A);
      NbTrans(Tronc)=size(a,1);


      for j=1:NbTrans(Tronc);
    %%  Calcul du cap et du module des vitesses mesurees (puis interpolées)
          Tfile_th=[dfile_th(Tronc,:) num2str(j)];load (Tfile_th);
          [cap_th,module_th]=uv2dirspeed(Tvitesse_th.v,Tvitesse_th.u);
                  cap_th=mod(cap_th+tetaMoy*180/pi,360);
                  %ii=find(cap_th>180);cap_th(ii)=cap_th(ii)-360;


    %% Interpolation vitesse Reconstituee
          clear module cap U V
          Temps_interp_=(datum_str(T_Temps_th)-T0)*24;
          for pas=1:size(cap_th,1)
          Temps_interp=Temps_interp_(pas);

              if(RecalculVitesse==1)
                 ReconstitutionProfil
              else
                 [dminTemps,ind_minTemps]=min(abs(Tr_reconst.Temps-Temps_interp));
                 Temps_=Tr_reconst.Temps(ind_minTemps);
                 U=squeeze(Tr_reconst.U(ind_minTemps,pas,:));
                 V=squeeze(Tr_reconst.V(ind_minTemps,pas,:));
                 [cap,module]=uv2dirspeed(V,U);cap=mod(cap+tetaMoy*180/pi,360);
              end
              ML=min(size(U),size(Tvitesse_th.u(pas,:)'));
              U_reconst=[U_reconst U(1:ML)'];
              U_mes=[U_mes Tvitesse_th.u(pas,1:ML)];
              V_reconst=[V_reconst V(1:ML)'];
              V_mes=[V_mes Tvitesse_th.v(pas,1:ML)];
              %subplot(1,2,2), plot(V(1:ML)',Tvitesse_th.v(pas,1:ML),'.')
          end

      end
    end
end
subplot(2,2,1), plot(U_reconst,U_mes,'.c'), axis('equal')
plot([-400 700],[-400 700],'r')
axis([-400 700 -400 700]),box on
subplot(2,2,2), plot(V_reconst,V_mes,'.c'), axis('equal')
plot([-400 500],[-400 500],'r')
axis([-400 500 -400 500]),box on

 Correlation(U_reconst,U_mes), 
 Correlation(V_reconst,V_mes), 




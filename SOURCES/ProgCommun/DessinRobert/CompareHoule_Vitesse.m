FichSauv='\Houle';
Tref=datenum(2011,1,1);
Tmes=datenum(011,1,1)-1;
    JourMin=180; JourMax=300;
    Hmin_res=0; Hmax_res=5;
    Ymin=-1000;Ymax=1000;
    signeTous=[1;-1;1 ;1];
    H0=[0;200;100;0];

for i=1:4
    figure((i-1)*2+1),clf;
%% Vitesse :
subplot(2,1,1)
DonneesCampagne(Nom(i,:));
load(MouillageMoy)
time1=(datum_str(Temps)-Tmes);
Harm=HarmoniqueMoyU_proj;vit=VitMoy_proj.u;DessNom='Uproj';
signe=signeTous(i);
    t=datum_str(Temps)-Tmes;
    plot(t,vit);hold on
    hold on
    u=VitesseCalculeeAvecHarmonique(NbOndes,Harm,...
        (datum_str(Temps)-T0)*24,T0);
    MoyGliss=interp1(Harm.temps,Harm.MoyGliss,...
                                                 (datum_str(Temps)-T0)*24);
    MoyGlissOrtho=interp1(Harm.temps,HarmoniqueMoyV_proj.MoyGliss,...
                                                 (datum_str(Temps)-T0)*24);
    u=u+MoyGliss;
    plot(t,u,'r');
    plot(t,signe*MoyGliss,'k');
    
    xlabel('temps (jour)'),ylabel('vitesse (mm/s)')
    grid on
    legend('Vitesse','Vitesse Tidale',...
        'location','Best')
    axis([JourMin JourMax Ymin Ymax])

    titre=[Nom(i,:)];
    title(titre)

 %% Houle :
    subplot(2,1,2)
load(FichSauv)
plot(T_Hs-Tref+1,Hs)
    xlabel('temps (jour)'),ylabel('houle (m)')
    grid on
    box on
    axis([JourMin JourMax Hmin_res Hmax_res])

figure((i-1)*2+2);clf;hold on
    plot(t,signe*(MoyGliss(:)),'c');
    plot(t,signe*(MoyGlissOrtho(:))*5,'m');
    plot(T_Hs-Tref+1,Hs*100-H0(i),'k')
    titre=[Nom(i,:)];
    title(titre)
end
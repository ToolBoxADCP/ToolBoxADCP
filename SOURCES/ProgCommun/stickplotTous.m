figure(1),
nb_i=25;ech=1;

%% petite passe
DonneesCampagne('MS ')
load(MouillagePropre)
time1=(datum_str(Temps)-T0)*24*3600;% en secondes
pp=eval(input('ième_maille_P_Adcp.fond_f_et_vitesse_PP=','s'));
subplot(2,2,1),stickplot(pp,nb_i,vitesse,time1,0,ech)


%% Grande passe
DonneesCampagne('MN1')
load(MouillagePropre)
time1=(datum_str(Temps)-T0)*24*3600;% en secondes
gp=eval(input('ième_maille_P_Adcp.fond_f_et_vitesse_GP=','s'));
subplot(2,2,2),stickplot(gp,nb_i,vitesse,time1,0,ech)

%% Centre du lagon
DonneesCampagne('MN2')
load(MouillagePropre)
time1=(datum_str(Temps)-T0)*24*3600;% en secondes
mc=eval(input('ième_maille_P_Adcp.fond_f_et_vitesse_MC=','s'));
subplot(2,2,3),stickplot(mc,nb_i,vitesse,time1,0,ech)

%% Passe nord
DonneesCampagne('MB ')
load(MouillagePropre)
time1=(datum_str(Temps)-T0)*24*3600;% en secondes
pn=eval(input('ième_maille_P_Adcp.fond_f_et_vitesse_PN=','s'));
subplot(2,2,4),stickplot(pn,nb_i,vitesse,time1,0,ech)

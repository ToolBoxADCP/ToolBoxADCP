%ComparaisonTansportBarriereHoule
DescriptifCampagne
DT_MoyGlissante=1;
T_init=T0;
T0_houle=T0+datenum(1999,12,31);

load FluxReconst_MN
DonneesCampagne('MN ')
load(MouillagePropre_proj);
t=datum_str(Temps)-T_init;
t_MN=t(1:end-1);
[MoyGliss_MN,Fl_MN]=MoyGlissante(t_MN,Flux.u,DT_MoyGlissante/2,0);

load FluxReconst_MS
DonneesCampagne('MS2')
load(MouillagePropre_proj);
t=datum_str(Temps)-T_init;
t_MS=t(1:end-1);
[MoyGliss_MS,Fl_MS]=MoyGlissante(t_MS,Flux.u,DT_MoyGlissante/2,0);
MoyGliss_MN_=interp1(t_MN,MoyGliss_MN,t_MS);

MoyGliss_Barr=-(MoyGliss_MN_-MoyGliss_MS);

figure, hold on
plot(t_MN,MoyGliss_MN,':b')
plot(t_MS,-MoyGliss_MS,'k')
plot(t_MS,-MoyGliss_Barr,'c')
mean(-MoyGliss_MN)
mean(MoyGliss_MS)

load TransportBarriere
t=T_Hs-T0_houle;
ii=find(t>t_MS(1)&t<t_MS(end));
t_MB=t(ii);
Tr_MB=Fl(ii);   % Transport en MS
MoyGliss_Barr_=interp1(t_MS,MoyGliss_Barr,t_MB);
Correlation(MoyGliss_Barr_,Tr_MB)

plot(t_Hs,Tr_MB*17000/1.8,':c')
Hs=(Tr_MS+0.28225)/0.34728;
figure, plot(-MoyGliss_Barr_,Tr_MS*17000/1.8,'.')

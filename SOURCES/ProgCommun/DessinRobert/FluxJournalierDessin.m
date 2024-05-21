Jour=datenum('02-Oct-0007');
DT=T0-Jour;DT=DT*24;

%% Flux Passe
figure(1),clf

DonneesCampagne('MS2')
load(FluxReconst(1,:))

T=FluxSection.temps/24;
ii=find(T+T0-Jour>0&T+T0-Jour<1);
T=T(ii);
Flux_=Flux.u(ii);

plot((T+T0-Jour)*24,(Flux_),'k')
Flux_MS2=Flux_;
T_MS2=T;

hold on

DonneesCampagne('MN ')
load(FluxReconst(1,:))
T=FluxSection.temps/24;
ii=find(T+T0-Jour>0&T+T0-Jour<1);
T=T(ii);
Flux_=-Flux.u(ii);

plot((T+T0-Jour)*24,(Flux_),':k')
Flux_MN=Flux_;
T_MN=T;

axis([0 24 -15000 10000])

%% Volume Lagon :
load(MouillagePropre)
T=datum_str(Temps);
ii=find(T-Jour>0&T-Jour<1);
T=T(ii);
H=detrend(P.depth);H=H(ii,:);

load Bath
Bath_=reshape(Bath,1,size(Bath,1)*size(Bath,2));
Bath_t=H*ones(size(Bath_))+ones(size(H))*Bath_;
bath_t=Bath_t;
bath_t(isnan(Bath_t)==1)=0;
bath_t(bath_t<0)=0;

dx=0.0025*dLong;
dy=0.0025*dLat;
vol=sum(bath_t')*dx*(dy)/1E6;
plot((T-Jour)*24,detrend(vol*100),':c')

%%
DT_MoyGlissante=1/24;
Vol=diff(vol')*1E6./(diff(T)*24*3600);
[MoyGliss,Vit_]=MoyGlissante(T(1:end-1),Vol,DT_MoyGlissante,0);
figure,plot((T(1:end-1)-Jour)*24,MoyGliss,'r')
hold on
Flux_MS2_=interp1(T_MS2,Flux_MS2,T_MN);
plot((T_MN+T0-Jour)*24,Flux_MN+Flux_MS2_,'b')

%% Ecart entre flux et vitesse d'augmentation de volume
figure(2),clf
Fl=Flux_MN+Flux_MS2_;
plot((T_MN(2:end-1)+T0-Jour)*24,detrend(Fl(2:end-1)),'b')
hold on
plot((T(1:end-1)-Jour)*24,detrend(MoyGliss),'r')

%% Flux barriere
figure(3),clf
MoyGliss_=interp1((T(1:end-1)-Jour)*24,MoyGliss,(T_MN(2:end-1)+T0-Jour)*24);
plot((T_MN(2:end-1)+T0-Jour)*24,(MoyGliss_-Fl(2:end-1)),'r')
hold on
plot((T_MN(2:end-1)+T0-Jour)*24,(Fl(2:end-1)),'b')
plot((T-Jour)*24,detrend(vol*100),':c')
plot((T(1:end-1)-Jour)*24,(MoyGliss),':m')

%% Dessin Article
figure(4)
clf
plot((T_MN(2:end-1)+T0-Jour)*24,(MoyGliss_-Fl(2:end-1)),'r')
hold on
plot((T-Jour)*24,detrend(vol*100),':c')
plot((T_MN+T0-Jour)*24,(Flux_MN),':k')
plot((T_MS2+T0-Jour)*24,(Flux_MS2),'k')




load (Ftransth)
Pcel=celM;
%maxFond=50;
for Tronc=1:nbTronc;
clear P_temps P P_vitesse_s P_vitesse_f P_adcp
P=[];P_vitesse_f=[];P_vitesse_s=[];
A=[dfile_th(Tronc,:) '*'];a=ls(A);NbTrans(Tronc)=size(a,1);

ProfMax_=0;
for j=1:NbTrans(Tronc);
  Tfile_th=[dfile_th(Tronc,:) num2str(j)];load (Tfile_th);
  ProfMax_=max(max(max(dsurface_th)),ProfMax_);
end
maxFond=min(floor(ProfMax_/celM)+1,50);
Pcel=max(celM,(floor(ProfMax_/maxFond*1000)+1)/1000);

for j=1:NbTrans(Tronc);
  Tfile_th=[dfile_th(Tronc,:) num2str(j)];load (Tfile_th);
  NbPoints=length(T_Temps_th.year);
  figure(j),clf,pcolor(Tvitesse_th.u'),colorbar,caxis([-500 150])
  for i=1:NbPoints;
    Pprof=Pcel:Pcel:maxFond*Pcel;
    
    P_temps(i).year(j)=T_Temps_th.year(i);
    P_temps(i).month(j)=T_Temps_th.month(i);
    P_temps(i).day(j)=T_Temps_th.day(i);
    P_temps(i).hour(j)=T_Temps_th.hour(i);
    P_temps(i).minute(j)=T_Temps_th.minute(i);
    P_temps(i).seconde(j)=T_Temps_th.seconde(i);
   
    P(i).lat(j)=GPSth(Tronc).ypas(i);
    P(i).long(j)=GPSth(Tronc).xpas(i);
    P(i).depth(j)=Tdepth_th(i);
    Pprof=blankM+hadcpM:Pcel:maxFond*Pcel;
    P(i).surface_s(j,:)=Pprof;
    P(i).fond_s(j,:)=Tdepth_th(i)-Pprof;
    Pprof=blankM+hadcpM:Pcel:maxFond*Pcel;
    P(i).fond_f(j,:)=Pprof;
    P(i).surface_f(j,:)=Tdepth_th(i)-Pprof;
    maxFond_=min(size(dsurface_th,2),maxFond);
    P_vitesse_s(i).u(j,:)=interp1(dsurface_th(i,1:maxFond_),Tvitesse_th.u(i,1:maxFond_),P(i).surface_s(j,:));
    P_vitesse_s(i).v(j,:)=interp1(dsurface_th(i,1:maxFond_),Tvitesse_th.v(i,1:maxFond_),P(i).surface_s(j,:));

    P_vitesse_f(i).u(j,:)=interp1(dsurface_thm(i,1:maxFond_),Tvitesse_thm.u(i,1:maxFond_),P(i).surface_f(j,:));
    P_vitesse_f(i).v(j,:)=interp1(dsurface_thm(i,1:maxFond_),Tvitesse_thm.v(i,1:maxFond_),P(i).surface_f(j,:));

    
    P_adcp(i).depth(j)=depth_adcp_th;
    P_adcp(i).ubt(j)=Tvitesse_th.ubt(i);
    P_adcp(i).vbt(j)=Tvitesse_th.vbt(i);
  end
end

for i=1:NbPoints;
 [ii,jj]=find(isnan(P_vitesse_s(i).u)==0 & isnan(P_vitesse_s(i).v)==0);
 m1=min(jj);m2=max(jj);
 if(size(m1,1)~=0)
    P_vitesse_s(i).u=P_vitesse_s(i).u(:,m1:m2);
    P_vitesse_s(i).v=P_vitesse_s(i).v(:,m1:m2);
    P(i).surface_s=P(i).surface_s(:,m1:m2);
    P(i).fond_s=P(i).fond_s(:,m1:m2);
 else
      disp('Pb pour données surface')
        i
    P_vitesse_s(i).u=[];
    P_vitesse_s(i).v=[];
    P(i).surface_s=[];
    P(i).fond_s=[];
 end

 [ii,jj]=find(isnan(P_vitesse_f(i).u)==0 & isnan(P_vitesse_f(i).v)==0);
 m1=min(jj);m2=max(jj);
 if(size(jj,1)~=0)
    P_vitesse_f(i).u=P_vitesse_f(i).u(:,m1:m2);
    P_vitesse_f(i).v=P_vitesse_f(i).v(:,m1:m2);
    P(i).fond_f=P(i).fond_f(:,m1:m2);
    P(i).surface_f=P(i).surface_f(:,m1:m2);
  else
      disp('Pb pour données fond')
        i
    P_vitesse_f(i).u=[];
    P_vitesse_f(i).v=[];
    P(i).fond_f=[];
    P(i).surface_f=[];
 end
end
H=[];
for nb=1:NbPoints;
    ii=find(P(nb).depth~=0.1);
      h=P(nb).depth(ii);
    P(nb).prof=mean(h);
    if(~isempty(P(nb).surface_s))
    H(nb)=max(max(P(nb).surface_s));
    end
end
[Hmax,nbMax]=max(H);
for nb=1:NbPoints;
    P(nb).DiscrVert=P(nbMax).surface_s(1,:);
end
save(point(Tronc,:),'P', 'P_adcp', 'P_vitesse_f', 'P_vitesse_s', 'P_temps')
end


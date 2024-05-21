load (Ftransth)
load (point(Tronc,:))
A=[dfile_th(Tronc,:) '*'];a=ls(A);NbTrans(Tronc)=size(a,1);

Usurf=NaN*ones(100,3);
Vsurf=NaN*ones(100,3);
t=NaN*ones(100,3);tb=t;
x=NaN*ones(100,3);

ii=1;
Day=P_temps(10).day(1)
t0=datum(P_temps(3).year(1),P_temps(3).month(1),P_temps(3).day(1),0,0,0)
Jour=1;
for j=1:NbTrans(Tronc);
  %Tfile_th=[dfile_th(Tronc,:) num2str(j)];load (Tfile_th);
  NbPoints=size(P_vitesse_s,2);
  NbPoints=size(GPSth(Tronc).dpas,2);
  if(P_temps(10).day(j)~=Day)
      Day=P_temps(10).day(j)
      t0=datum(P_temps(10).year(j),P_temps(10).month(j),P_temps(10).day(j),0,0,0);
      ii,t0
      Jour=Jour+1;
      ii=1;
  end
  for i=1:NbPoints;
    if(size(P_vitesse_s(i).u,1)>=j)
       Usurf(ii,Jour)=P_vitesse_s(i).u(j,i_T)/1000;
       Vsurf(ii,Jour)=P_vitesse_s(i).v(j,i_T)/1000;
       tb(ii,Jour)=datum(P_temps(i).year(j),P_temps(i).month(j),P_temps(i).day(j),P_temps(i).hour(j),P_temps(i).minute(j),P_temps(i).seconde(j));
       t(ii,Jour)=(tb(ii,Jour)-t0)*24;
       tb(ii,Jour)=(tb(ii,Jour)-T0)*24;
       x(ii,Jour)=GPSth(Tronc).dpas(i);
    else
       Usurf(ii,Jour)=NaN;
       Vsurf(ii,Jour)=NaN;
       t(ii,Jour)=NaN;
       tb(ii,Jour)=NaN;
       x(ii,Jour)=NaN;
   end
    ii=ii+1;
  end
end
pause
close all
ech=1;
figure(1)
for J=1:Jour;
    figure,axis equal
    hold on,quiver(x(:,J)/1000,t(:,J),Usurf(:,J)/ech,Vsurf(:,J)/ech,0,'r'),axis equal
    axis('xy'),axis equal
    figure(1),hold on,quiver(x(:,J)/1000,tb(:,J),Usurf(:,J)/ech,Vsurf(:,J)/ech,0,'r'),axis equal
end
% for J=1:Jour;
%     figure,axis equal
%     [Usurf_proj,Vsurf_proj]=ProjectionVitesse_surEllipse(Usurf,Vsurf,-tetaMoy);
%     hold on,quiver(x(:,J)/1000,t(:,J),Usurf_proj(:,J)/ech,Vsurf_proj(:,J)/ech,0,'r'),axis equal
%     axis('xy'),axis equal
%     figure(1),hold on,quiver(x(:,J)/1000,tb(:,J),Usurf_proj(:,J)/ech,Vsurf_proj(:,J)/ech,0,'r'),axis equal
% end

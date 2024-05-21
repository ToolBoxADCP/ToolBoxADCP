% %Unite=(1:N)'*ones(1,M);
% t=ones(N,1)*HarmoniqueU(1).temps/3600/24;

DonneesCampagne('MS1'),
load (MouillagePropre_proj)
v_M1=vitesse.v(:,1);V_M1=[v_M1 v_M1]';
u_M1=vitesse.u(:,1);U_M1=[u_M1 u_M1]';
t_M1=ones(2,1)*(datum_str(Temps)-T0)';
M=size(U_M1,2);
Unite_M1=(1:2)'*ones(1,M);

DonneesCampagne('MS2')
load (MouillagePropre_proj)
v_M2=vitesse.v(:,1);V_M2=[v_M2 v_M2]';
u_M2=vitesse.u(:,1);U_M2=[u_M2 u_M2]';
t_M2=ones(2,1)*(datum_str(Temps)-T0)';
M=size(U_M2,2);N=size(U_M2,1);
t_M2=ones(2,1)*(datum_str(Temps)-T0)';
Unite_M2=(1:2)'*ones(1,M);

figure,pcolor(t_M2,Unite_M2+N-1,U_M2)
hold on,%pcolor(t,Unite_M2,U_M2(:,:,1))
pcolor(t_M1,Unite_M1,U_M1)
shading flat,%axis([-20 -12 0 N+2])

figure,pcolor(t_M2,Unite_M2+N-1,V_M2)
hold on,%pcolor(t,Unite_M2,V_M2(:,:,1))
pcolor(t_M1,Unite_M1,V_M1)
shading flat,%axis([-20 -12 0 N+2])

figure,pcolor(t_M2,Unite_M2+N-1,sqrt(V_M2.^2+U_M2.^2))
hold on,%pcolor(t,Unite_M2,sqrt(V_M2(:,:,1).^2+U_M2(:,:,1).^2))
pcolor(t_M1,Unite_M1,sqrt(V_M1.^2+U_M1.^2))
shading flat,%axis([-20 -12 0 N+2])
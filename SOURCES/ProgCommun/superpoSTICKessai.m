ii=1;
nb_i=60;
u=[];
v=[];
for i=1:nb_i;
    u(:,i)=vitesse.u(i:nb_i:end-nb_i+i-1,ii);
    v(:,i)=vitesse.v(i:nb_i:end-nb_i+i-1,ii);
end
U=mean(u,2);
V=mean(v,2);
figure,
h=quiver(time1(1:nb_i:end-nb_i)/3600/24,-1.5*ones(size(time1(1:nb_i:end-nb_i))),U,V)
set(h,'ShowArrowHead','off');
hold on
ii=2;
nb_i=60;
u=[];
v=[];
for i=1:nb_i;
    u(:,i)=vitesse.u(i:nb_i:end-nb_i+i-1,ii);
    v(:,i)=vitesse.v(i:nb_i:end-nb_i+i-1,ii);
end
U=mean(u,2);
V=mean(v,2);
h=quiver(time1(1:nb_i:end-nb_i)/3600/24,-3*ones(size(time1(1:nb_i:end-nb_i))),U,V)
set(h,'ShowArrowHead','off');
axis equal
% figure(1),
% quiver(time1(1:nb_i:end-nb_i)/3600/24,-1.5*ones(size(time1(1:nb_i:end-nb_i))),U,V)
% hold on
% quiver(time1(1:nb_i:end-nb_i)/3600/24,-3*ones(size(time1(1:nb_i:end-nb_i))),U,V)
% hold on
% quiver(time1(1:nb_i:end-nb_i)/3600/24,-4.5*ones(size(time1(1:nb_i:end-nb_i))),U,V)
% hold on
% quiver(time1(1:nb_i:end-nb_i)/3600/24,-6*ones(size(time1(1:nb_i:end-nb_i))),U,V)
%axis equal
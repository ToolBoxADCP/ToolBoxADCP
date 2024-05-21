function stickplot(ii,nb_i,vitesse,time1,pos,ech)
%ii=1 :        numero de maille
%nb_i=60 :     interpolation sur nb_i pas
%vitesse :     vitesse.u et vitesse.v la vitesse
%time1 :       le temps
%pos :         la position

u=[];
v=[];
for i=1:nb_i;
%disp('Je pense inutile de mettre le "-1" pas encore testé')
%   u(:,i)=vitesse.u(i:nb_i:end-nb_i+i-1,ii);
%    v(:,i)=vitesse.v(i:nb_i:end-nb_i+i-1,ii);
    u(:,i)=vitesse.u(i:nb_i:end-nb_i+i,ii);
    v(:,i)=vitesse.v(i:nb_i:end-nb_i+i,ii);
end
U=mean(u,2);
V=mean(v,2);
max(max(abs(U)));
max(max(abs(V)));
h=quiver(time1(1:nb_i:end-nb_i+1)/3600/24,pos*ones(size(time1(1:nb_i:end-nb_i+1))),U/ech,V/ech,0)
set(h,'ShowArrowHead','off');
axis equal

% % Mise en forme des données Bottom Tracking
% col=size(Tdir_deg,2);
% vectY=ones(1,col);
% Tubt=Tubt*vectY;
% Tvbt=Tvbt*vectY; 

%% Suppression des valeurs physique aberrantes (pics)
[Tvitesse.u,Tvitesse.v]=clean(3000, Tvitesse.u,Tvitesse.v);


%% Définition et calcul des distances par rapport au fond et à la surface
depth_adcp=hadcpM;
ligne=size(Tvitesse.u,1);
col=size(Tvitesse.u,2);
vectX=ones(ligne,1);
vectY=ones(1,col);
vect=0:col-1;
dsurface=celTr*vectX*vect+bl;
dfond=Tdepth*vectY-dsurface;

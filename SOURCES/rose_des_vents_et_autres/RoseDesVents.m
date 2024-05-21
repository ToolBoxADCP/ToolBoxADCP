function RoseDesVents(fich,seuil)
%load(fich)
%cap=uv2cap(Vn,Ve);
%int=uv2speed(Vn,Ve)
cap = 2*pi*rand(1,500);
int = 100*rand(1,500);

ii=find(int<seuil);
[alphe,t]=rose(cap);polar(alphe,t/size(int,2)*100,'r')
hold on
[alphe,t]=rose(cap(ii));polar(alphe,t/size(int,2)*100)

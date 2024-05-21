function cap=uv2dir(u,v)

% function cap=uv2dir(u,v)
% Calcul du cap a partir de composantes u et v
% Coco 17/04/1996

cap=atan2(u,v)/pi*180;

i=find(cap<0);
cap(i)=cap(i)+360;
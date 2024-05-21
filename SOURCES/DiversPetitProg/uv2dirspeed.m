function [cap,module]=uv2dirspeed(u,v)
% G.R. 02/02/2008

cap=uv2dir(u,v);
module=speed(u,v);


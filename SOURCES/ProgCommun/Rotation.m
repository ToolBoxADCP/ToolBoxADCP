function [U,V]=rotation(u,v,err)

[cap,module]=uv2dirspeed(u,v);
cap=cap+err;
[U,V]=dir2uv(cap,module);

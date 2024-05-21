function [u,v]=dir2uv(direct,speed)
% uv2dir rechnet aus Richtung und Geschwindigkeit Stomkomponenten 
% function [u,v]=dir2uv(direct,speed)
% J.Reppin 3.12.90
u=speed.*sin(direct*pi./180);
v=speed.*cos(direct*pi./180);

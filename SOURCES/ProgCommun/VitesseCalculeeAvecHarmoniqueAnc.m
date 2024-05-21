%function u=VitesseCalculeeAvecHarmoniqueAnc(NbOndes,Harm,t)

% u=0;
% for ind=1:NbOndes;
% om=Harm.omega(ind);
%   u=u+Harm.ampl(ind).*sin(-om*t+Harm.phase(ind)/2-pi);
% end
% 
% for ind=1:2
%   a=Harm.lin(ind);
%   u=u+a.*((t).^(ind-1));        %t en heure
% end
A=Harm.ampl;
phi=Harm.phase;
w=Harm.omega

ap=sum((A'*ones(size(t))).*exp(i*(w'*t+phi'*ones(size(t)))),1);
am=sum(conj(ap),1);
plot(t,ap+am,'b'),pause

hold on 
x=sum(2*(A'*ones(size(t))).*sin(w'*t+phi'*ones(size(t))+pi/2),1);
plot(t,x,'r')
function u=VitesseCalculeeAvecHarmonique(NbOndes,Harm,tim,T0)
%Temps en jour
%reste encore à bien verif la partie linéaire

% 
% u=0;
% for ind=1:NbOndes;
%   om=Harm.omega(ind);
%   u=u+Harm.ampl(ind).*sin(om*t+Harm.phase(ind));
% end
% 
% for ind=1:2
%   a=Harm.lin(ind);
%   u=u+a.*((t).^(ind-1));        %t en heure
% end

  ap=Harm.ampl'/2.*exp(-i*Harm.phase'*pi/180);
  am=conj(ap);
jdmid=(tim(1)+tim(end))/2;
lat=-12.75;
[v,u,f]=t_vuf(jdmid+T0,Harm.Num,lat);

% f=Harm.Corr(:,1);
% u=Harm.Corr(:,2);
% v=Harm.Corr(:,3);

 ap=ap.*f.*exp(+i*2*pi*(u+v));
 am=am.*f.*exp(-i*2*pi*(u+v));
% 
ti=tim-jdmid;

 [n,m]=size(ti);
%ti=ti(:)';
  
% Mean at central point (get rid of one point at end to take mean of
% odd number of points if necessary).
u=sum(exp(i*Harm.omega'*ti'*24).*ap(:,ones(size(ti))),1)+ ...
     sum(exp(-i*Harm.omega'*ti'*24).*am(:,ones(size(ti))),1);

 
 u=u' + Harm.lin(1)+Harm.lin(2)*tim*24;  
  %yout=0*reshape(yout,n,m);


function u=VitesseCalculeeAvecHarmonique (NbOndes,Harm,tim,T0)
%Temps en jour � partir de T0
%reste encore � bien verif la partie lin�aire

lat=-12.75;
[v,u,f]=t_vuf(T0+730485,Harm.Num,lat);

ap=f.*Harm.amplForeman'/2.*exp(i*2*pi*((u+v)-Harm.phaseForeman'/360));
am=conj(ap);
% ap=0*ap;am=0*am;
% Mean at central point (get rid of one point at end to take mean of
% odd number of points if necessary).

u=sum(exp(i*Harm.omega'*tim').*ap(:,ones(size(tim))),1)+ ...
     sum(exp(-i*Harm.omega'*tim').*am(:,ones(size(tim))),1);
 
onde=exp(i*Harm.omega'*tim').*ap(:,ones(size(tim))) + ...
    exp(-i*Harm.omega'*tim').*am(:,ones(size(tim)));
 
 u=u' + Harm.lin(1)+Harm.lin(2)*tim;  
  %yout=0*reshape(yout,n,m);


function [ampl,ph]=ReducPhase_verif2(amplI,phI,om);

ph=phI;phI=phI';

%% Dessin Sabrina
t=0:60:10*24*3600;
phS=[4.02 4.09 -1.25]'*60;
ph=phS.*om'+phI;
td=(ones(size(phS))*t+phS*ones(size(t)));
vect=ones(1,size(td,2));
x=sum(-((amplI'*vect).*sin((om'*vect).*td/3600+phI*vect)));size(x)
figure(2),hold on,plot(t/3600,(x)/500,'m');
ph=ph';
ampl=amplI;

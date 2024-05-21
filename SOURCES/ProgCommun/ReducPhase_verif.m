function [ampl,ph]=ReducPhase_verif(t,amplI,phI,om);
% a partir d'une phase, d'une amplitude et d'une periode dessine la valeur
% de la fonction (vitesse ou niveau)

ampl=amplI;
ph=phI;phI=phI;


%% Dessin
% clf
x=sum(-((amplI'*ones(size(t))).*sin(om'*t/3600+phI'*ones(size(t)))));
hold on,plot(t/3600/24,x,'k');




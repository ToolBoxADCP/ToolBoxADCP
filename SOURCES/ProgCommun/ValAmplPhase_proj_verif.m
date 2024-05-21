%% Dessine les variables, mesurées, interpolées, etc...

% en vert : var mesurée
% en bleu : var det par HarmoniqueNondes
% en noir : Foreman


%% Définition boucle

for i = 1:size(Nom,1);
%% Travail dans la boucle
% lecture des variables
    Nom(i,:),DonneesCampagne(Nom(i,:))
    close all

load (MouillageAnalyse)
load (MouillagePropre)

% Dessine les niveaux:
figure(1),
if (strcmp(Pression,'Non  ')==0)
   t=(datum_str(Temps)-T0)*24*3600;% en secondes
   Harm=HarmoniqueNondes('div',detrend(P.depth),t,1,size(t,1),t);
   hold on
   [amplV,phV]=ReducPhase_verif(t',(-HarmoniqueH.ampl),(HarmoniqueH.phase),(HarmoniqueH.omega));
pause
end
end
figure,DessinDephasage
break

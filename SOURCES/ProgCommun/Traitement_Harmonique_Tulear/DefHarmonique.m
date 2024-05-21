function [Harmonique]=DefHarmonique(NbOndes,Ondes,T0,fichierE,fichierS,BolFig)

fichierGlobal=fichierS;

%BolFig=0;

%% Foreman
MareeMouillage
fclose('all')

% En sortie Foreman nous donne 
%   * tidestruct qui est une structure avec
%       .name, le nom
%       .freq, la frequence
%       .tidecon : les valeurs de l'harmonique
%   * xpout
      
%% Calcul des Harmoniques 
transfHarm

Harmonique.name

% Validation du choix des ondes
[harm,IX]=sortrows(tidestruc.tidecon(:,1),-1);
a=tidestruc.name(IX,:);a=cellstr(a);
disp('Ordre d importance des ondes'),a'

u=VitesseCalculeeAvecHarmonique(NbOndes,Harmonique,tuk_time/24,T0);

%% Sélection des Harmoniques (par ordre de nommination)
% Harmonique sauvegardée
MareeMouillageReduit

transfHarm

%% Calcul de la residuelle linéaire et non linéaire
% recalcule car on a moins d'ondes que dans Foreman
% 
% % Calcul résiduelle
% ii=find(isnan(tuk_elev-pout)==0);
% Harmonique.lin=[0 0];
% U=VitesseCalculeeAvecHarmonique(NbOndes,Harmonique,t_foreman);
% res=tuk_elev(ii)-U(ii);
% 
% % Calcul de la partie linéaire
% pp=polyfit(t_foreman(ii),res,1);
% Harmonique.lin(2)=pp(1);
% Harmonique.lin(1)=pp(2);
% 
      
% Calcul de la partie Non linéaire
U=VitesseCalculeeAvecHarmonique(NbOndes,Harmonique,tuk_time/24,T0);
res=tuk_elev-U;
Harmonique.res=interp1(tuk_time,res,tuk_time);
Harmonique.temps=tuk_time+T0*24;  %en heure


   %% Correlation :
Harmonique.correlation=Correlation(tuk_elev,U);

%% Dessin
% rouge : signal
% cyan : foreman
% magenta : réduit
if(BolFig==1)
    close all
    HarmoniqueNondes('h');
    hold on
   plot(tuk_time/24,pout,'c',tuk_time/24,tuk_elev-pout,'m')
   'erreur moy'
   '  Foreman :',mean(abs(tuk_elev-pout))
   '  Nous :', nanmean(abs(res))
   figure(2),
   subplot(2,1,1),hold on,
   plot(tuk_time,tuk_elev,'r',tuk_time,pout,'c')
   plot(tuk_time,U,'m')
   subplot(2,1,2),hold on,
  %hold on,plot(t_foreman,u,'--b');'dessin Fait',pause
   plot(tuk_time,tuk_elev-pout,'c')
   plot(tuk_time,tuk_elev-U,'g',tuk_time,tuk_time*Harmonique.lin(2)+Harmonique.lin(1),'r')
end
      

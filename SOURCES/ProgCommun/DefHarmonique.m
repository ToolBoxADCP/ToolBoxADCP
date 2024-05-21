function [Harmonique]=DefHarmonique(Jour,Heure,Vit,...
                    NbOndes,Ondes,T0,fichierE,fichierS,BolFig)


%% Moyenne Glissante
DT_MoyGlissante=34/24;
DT_MoyGlissante=1;
if(DT_MoyGlissante~=0)
  [MoyGliss,Vit_]=MoyGlissante(Jour+Heure/24,Vit,...
                                        DT_MoyGlissante,BolFig);
else
   Vit_= Vit;
   MoyGliss=0*Vit;
end
                
courant=[Jour Heure Vit_];
save(fichierE,'courant')

fichierGlobal=fichierS;

%BolFig=0;

%% Foreman
MareeMouillage
fclose('all');

% En sortie Foreman nous donne 
%   * tidestruct qui est une structure avec
%       .name, le nom
%       .freq, la frequence
%       .tidecon : les valeurs de l'harmonique
%   * xpout
      
%% Calcul des Harmoniques 
t_foreman=(tuk_time);       %en heure
transfHarm

% Validation du choix des ondes
[harm,IX]=sortrows(tidestruc.tidecon(:,1),-1);
a=tidestruc.name(IX,:);a=cellstr(a);
if(BolFig==1|BolFig==2)
disp('Ordre d importance des 5 principales ondes'),a(1:5,:)'
disp('Ondes choisies'),Harmonique.name
disp('  ')
end

% u=VitesseCalculeeAvecHarmonique(NbOndes,Harmonique,t_foreman/24,T0);
% 
% %% S�lection des Harmoniques (par ordre de nommination)
% % Harmonique sauvegard�e
% MareeMouillageReduit
% 
% transfHarm


%% Dessin
% rouge : signal
% cyan : foreman
% magenta : r�duit
% BolFig=1;
if(BolFig==1)
   figure(1),
    close all
    HarmoniqueNondes('h');
    hold on
    plot(tuk_time/24,pout,'c',tuk_time/24,tuk_elev-pout,'m')
    'erreur moyenne : '
    gd=find(isfinite(tuk_elev));
    varx=cov(tuk_elev(gd));varxp=cov(pout(gd));varxr=cov(tuk_elev(gd)-pout(gd));
    disp('  Foreman :'),[nanmean(abs(tuk_elev-pout)) 100*(varxr/varx)]
    varx=cov(tuk_elev(gd));varxr=cov(res);
    '  Nous :',[nanmean(abs(res)) 100*(varxr/varx)]
    
    varx=cov(Vit(gd));varxp=cov(pout(gd));varxr=cov(Vit(gd)-pout(gd));
    disp('  Foreman :'),[nanmean(abs(Vit(gd)-pout(gd))) 100*(varxr/varx)]
    varx=cov(Vit(gd));varxr=cov(Harmonique.res(gd));
    '  Nous :',[nanmean(abs(Harmonique.res)) 100*(varxr/varx)]
    
   figure(2),
   subplot(2,1,1),hold on,
    %plot(tuk_time,tuk_elev,'r',tuk_time,pout,'c')
    plot(Jour*24+Heure,Vit,'r',tuk_time,pout+Harmonique.MoyGliss,'c')
    plot(tuk_time,U+Harmonique.MoyGliss,'m')
    
   subplot(2,1,2),hold on,
  % hold on,plot(t_foreman,u,'--b');'dessin Fait',pause
    plot(tuk_time,tuk_elev-pout,'c')
    plot(tuk_time,tuk_elev-U,'g',tuk_time,tuk_time*Harmonique.lin(2)+Harmonique.lin(1),'r')
    %pause
end

fich='./DessinRobert/pcolor/';
dir='./DessinRobert/pcolor';[a,b]=mkdir (dir);

      Fich=[fich 'U'];
      pcol_uni(time1(ii),P_Adcp.fond_f(ii,:),vitesse.u(ii,:), ...
               Fich,nom,DebDessin(mois).month, ...
               NomMois(mod(DebDessin(mois).month-1,12)+1),...
               floor(DebDessin(mois).month/12)+DebDessin(mois).year,...
               'U',...
               Tmes,T_fin,...
               JourMin,JourMax,Campagne)

      Fich=[fich 'V'];
      pcol_uni(time1(ii),P_Adcp.fond_f(ii,:),vitesse.v(ii,:),...
               Fich,nom,DebDessin(mois).month,...
               NomMois(mod(DebDessin(mois).month-1,12)+1),...
               floor(DebDessin(mois).month/12)+DebDessin(mois).year,...
               'V',...
               Tmes,T_fin,...
               JourMin,JourMax,Campagne)

      Fich=[fich 'U_long'];
      pcol_uni(time1(ii),P_Adcp.fond_f(ii,:),vitesse_proj.u(ii,:),...
               Fich,nom,DebDessin(mois).month,...
               NomMois(mod(DebDessin(mois).month-1,12)+1),...
               floor(DebDessin(mois).month/12)+DebDessin(mois).year,...
               'Ulong',...
               Tmes,T_fin,...
               JourMin,JourMax,Campagne)

      Fich=[fich 'U_ortho'];
      pcol_uni(time1(ii),P_Adcp.fond_f(ii,:),vitesse_proj.v(ii,:),...
               Fich,nom,DebDessin(mois).month,...
               NomMois(mod(DebDessin(mois).month-1,12)+1),...
               floor(DebDessin(mois).month/12)+DebDessin(mois).year,...
               'Uortho',...
               Tmes,T_fin,...
               JourMin,JourMax,Campagne)
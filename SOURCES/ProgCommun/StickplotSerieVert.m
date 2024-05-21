Zmax=-1;Zmin=50;
N=MaxProf(Nom(i,:));
if(Nb_maille~=1)
    deb=1;
   dn=max(((N-1)/(Nb_maille-1)),1);
   for ind=1:dn:N;
       ii=floor(ind);
%        Zmin=min(Zmin,P_Adcp.fond_f(1,ii)/echG);
%        Zmax=max(Zmax,P_Adcp.fond_f(1,ii)/echG);
    hold on,
    I0=min(find(isnan(P_Adcp.fond_f(:,ii))==0));
    [Zmin Zmax]=stickplot(ii,nb_i,Vitesse_loc,time_loc,P_Adcp.fond_f(I0,ii)/echG,ech)
   end
else
    ii=floor(N/2);
    dn=1;
       Zmin=P_Adcp.fond_f(1,ii);
       Zmax=P_Adcp.fond_f(1,ii);
    hold on,
    [Zmin Zmax]=stickplot(ii,nb_i,Vitesse_loc,time_loc,P_Adcp.fond_f(1,ii)/echG,ech)
end
box on

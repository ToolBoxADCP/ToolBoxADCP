function u=VitesseCalculeeAvecHarmonique_ssCor(NbOndes,Harm,t,T0)
%Temps en heure à partir de T0
%reste encore à bien verif la partie linéaire

u=sum(((ones(size(t))*Harm.ampl).*...
    sin(t*Harm.omega+ones(size(t))*Harm.phase)),2);
u=u + Harm.lin(1)+Harm.lin(2)*t;  

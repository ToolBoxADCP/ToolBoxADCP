clear Harmonique
Harmonique.temps=t_foreman;  %en heure à partir de T0
for iOndes=1:size(Ondes,1);
   nOnde=size(char(Ondes(iOndes)),2);
   iiOndes=find((strncmp(cellstr(tidestruc.name),Ondes(iOndes),nOnde)==1));
   if ~isempty(iiOndes)
       Harmonique.omega(iOndes)=2*pi*tidestruc.freq(iiOndes);
       Harmonique.name(iOndes)=cellstr(tidestruc.name(iiOndes,:));
       Harmonique.Num(iOndes)=tidestruc.Num(iiOndes);
       Harmonique.amplForeman(iOndes)=tidestruc.tidecon(iiOndes,1);
       Harmonique.phaseForeman(iOndes)=tidestruc.tidecon(iiOndes,3);
   else
       Harmonique.ampl(iOndes)=0;
       Harmonique.phase(iOndes)=0;
       Harmonique.Num(iOndes)=1;
       Harmonique.omega(iOndes)=1;
       Harmonique.name(iOndes)=cellstr(Ondes(iOndes));
       Harmonique.amplForeman(iOndes)=0;
       Harmonique.phaseForeman(iOndes)=0;
       
   end
end

lat=-12.75;
[vF,uF,f]=t_vuf(T0+730485,Harmonique.Num,lat);
Harmonique.ampl=f'.*Harmonique.amplForeman;
Harmonique.phase=pi/2-Harmonique.phaseForeman*pi/180+2*pi*(uF'+vF');

% 'tidestruc'
% tidestruc.Lin(1)
% tidestruc.Lin(2)

% %% Calcul Harmonique à la main (sans Foreman) :
% fu=tidestruc.freq;
% N=size(fu,1);
% nobs=length(t_foreman);
% nobsu=nobs-rem(nobs-1,2);
% DT=diff(t_foreman);dt=DT(1);
% t=dt*([1:nobs]'-ceil(nobsu/2)); 
% tc=[ones(length(t),1) cos((2*pi)*t*fu') sin((2*pi)*t*fu') ];
% DT=t(1)-t_foreman(1);
% xout=tc*coef;
% 
% Harmonique.lin(1)=coef(1);
% 
% for onde=1:N
%    Harmonique.ampl(onde)=sqrt(coef(onde+1)^2+coef(onde+1+N)^2);
%    Harmonique.phase(onde)=atan(coef(onde+1)/coef(onde+1+N))+(sign(coef(onde+1+N))==-1)*pi;
%    Harmonique.phase(onde)=Harmonique.phase(onde)+2*pi*tidestruc.freq(onde)*DT;
%        Harmonique.Num(onde)=tidestruc.Num(iiOndes);
%        Harmonique.omega(onde)=2*pi*tidestruc.freq(iiOndes);
%        Harmonique.name(onde)=cellstr(tidestruc.name(iiOndes,:));
% end
% 
% Harmonique.lin(2)=0;
% u=VitesseCalculeeAvecHarmonique(N,Harmonique,t_foreman/24,T0);
% 
% if(BolFig==1)
%     clf
%     plot(t-DT,tuk_elev,'r',t-DT,xout,'c')
%     hold on,plot(t_foreman,u,'--b');
%     'dessin Fait',pause
% end
% 
% 
%% Calcul de la residuelle linéaire et non linéaire
% recalcule car on a moins d'ondes que dans Foreman
% 
% % Calcul résiduelle
Harmonique.lin=[0 0];
Harmonique.res=Harmonique.temps*0;
U=VitesseCalculeeAvecHarmonique(NbOndes,Harmonique,Harmonique.temps,T0);
% clf,plot(Harmonique.temps,U)
% u=VitesseCalculeeAvecHarmonique_ssCor(NbOndes,Harmonique,Harmonique.temps,T0);
% hold on,plot(Harmonique.temps,U,':r'),
% pause
ii=find(isnan(tuk_elev)==0);
res=tuk_elev(ii)-U(ii);

% Calcul de la partie linéaire
pp=polyfit(t_foreman(ii),res,1);
Harmonique.lin(2)=pp(1);
Harmonique.lin(1)=pp(2);

      
% Calcul de la partie Non linéaire
U=VitesseCalculeeAvecHarmonique(NbOndes,Harmonique,Harmonique.temps,T0);
res=tuk_elev(ii)-U(ii);
Harmonique.res=interp1(t_foreman(ii),res,Harmonique.temps);

% ii=find(isnan(MoyGliss)==1);
% di=diff(ii);i0=1;i1=max(find(di>1)+1);
% MoyGliss(ii(i0:i1-1))=MoyGliss(ii(i1-1)+1);
% MoyGliss(ii(i1:end))=MoyGliss(ii(i1)-1);


ii=find(isnan(MoyGliss)==0);
MoyGliss=MoyGliss(ii);
Jour=Jour(ii);Heure=Heure(ii);
Harmonique.MoyGliss=interp1(Jour*24+Heure,MoyGliss,Harmonique.temps);

Harmonique.res=Harmonique.res+Harmonique.MoyGliss;


   %% Correlation :
Harmonique.correlation=Correlation(tuk_elev,U);
%if(isnan(Harmonique.correlation)),pause,end



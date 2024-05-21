function u=CalcVitesse(x,A,degPol,ImpVit_M,NbOndes);
% 'calcVitesse',degPol,ImpVit_M
CouplVitesse=1;
u=zeros(size(A,1),1);
X=0;
for deg=ImpVit_M:degPol;
    ii=deg-ImpVit_M;
    ind_A=2*ii*(1+CouplVitesse)*(NbOndes+1)+1+ii;% Indice de A correspondant au polynome pur
    X=x(1+ii).*A(:,ind_A)+X;%X=x(1+ii).*A(:,2*ii*(NbOndes+2)+1+ii);
end
u=zeros(size(A,1),1);
for deg=ImpVit_M:degPol;
  %pour u  
  ii=(deg-ImpVit_M);
  for ind=1:NbOndes;
      i=ii*(2*2*(NbOndes+1)+1);%2*ii*(NbOndes+1)+ind;ii,i
      ind_A=i+ind+1; % 2*i+ii; correspondant à l'indice des sin dans la matrice A
      i=ii*2*(NbOndes+2);
      ind_x=(degPol-ImpVit_M+1)+i+ind;
      u=u+x(ind_x)*(A(:,ind_A)+X.*A(:,ind_A+1));
  end
  ind=NbOndes+1;
  i=ii*(2*2*(NbOndes+1)+1);%2*ii*(NbOndes+1)+ind;ii,i
  ind_A=i+NbOndes+ind+1; % 2*i+ii; correspondant à l'indice des sin dans la matrice A
  i=ii*2*(NbOndes+2);
  ind_x=(degPol-ImpVit_M+1)+i+ind;
  u=u+(x(ind_x)*A(:,ind_A)+x(ind_x+1)*A(:,ind_A+1));

  %pour v  
  ii=(deg-ImpVit_M);
  for ind=1:NbOndes;
      i=ii*(2*2*(NbOndes+1)+1);%i=(2*ii+1)*(NbOndes+1)+ind;
      u=u+x(ind_x)*(A(:,ind_A)+X.*A(:,ind_A+1));%u=u+x(i+3*ii+2)*(A(:,2*(i)+ii)+X.*A(:,2*(i)+ii+1));
  end
  ind=NbOndes+1;
  i=ii*(2*2*(NbOndes+1)+1);%i=(2*ii+2)*(NbOndes+1);
  ind_A=i+ind+1+2*(NbOndes+1); % 2*i+ii; correspondant à l'indice des sin dans la matrice A
  i=ii*2*(NbOndes+2);
  ind_x=(degPol-ImpVit_M+1)+i+ind+(NbOndes+2);
  u=u+(x(ind_x)*A(:,ind_A)+x(ind_x+1)*A(:,ind_A+1));%u=u+(x(i+3*ii+2)*A(:,2*(i)+ii)+x(i+2*ii+3)*A(:,2*(i)+ii+1));
end
       
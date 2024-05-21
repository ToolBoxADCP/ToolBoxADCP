function u=CalcVitesse(x,A,degPol,ImpVit_M,NbOndes);
% 'calcVitesse',degPol,ImpVit_M
u=zeros(size(A,1),1);
X=0;
for deg=ImpVit_M:degPol;
    ii=deg-ImpVit_M;
    X=x(1+ii).*A(:,2*ii*(NbOndes+2)+1+ii);
end
u=zeros(size(A,1),1);
for deg=ImpVit_M:degPol;
  %pour u  
  ii=(deg-ImpVit_M);
  for ind=1:NbOndes;
      i=2*ii*(NbOndes+1)+ind;%ii,i
      u=u+x(i+3*ii+1)*(A(:,2*(i)+ii)+X.*A(:,2*(i)+ii+1));
  end
  i=(ii+1)*(NbOndes+1);
  u=u+(x(i+ii+1)*A(:,2*(i)+ii)+x(i+ii+2)*A(:,2*(i)+ii+1));

  %pour v  
  ii=(deg-ImpVit_M);
  for ind=1:NbOndes;
      i=(2*ii+1)*(NbOndes+1)+ind;
      u=u+x(i+3*ii+2)*(A(:,2*(i)+ii)+X.*A(:,2*(i)+ii+1));
  end
  i=(2*ii+2)*(NbOndes+1);
  u=u+(x(i+3*ii+2)*A(:,2*(i)+ii)+x(i+2*ii+3)*A(:,2*(i)+ii+1));
end
       
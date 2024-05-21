function f=MoindreCarre(x);
global par degPol ImpVit_M NbOndes

      b=size(par,2);
      B=par(:,b);
      A=par(:,1:b-1);
   %f=A(:,1)*(x(1).^1)+A(:,2:end)*(x(2:end).^1)-B(:);
   U=CalcVitesse(x,A,degPol,ImpVit_M,NbOndes);
   f=U-B;

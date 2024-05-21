function Harm=CalculPhaseetAmpl(time,var,J,I,k)
NbOndes = 2;

time=time*24;  
%var_=detrend(var);  

%%              ESTIMATION DES COEF A L AIDE DE TIME
%Creation de la matrice A
omega(1)=2*pi/(12.42060126);      %ondeM2
omega(2)=2*pi/(12.0000);          %onde S2

% Matrice d'interpolation
A=[ones(size(time)) time]; 

for onde=1:NbOndes
   A=[A cos(omega(onde).*time) sin(omega(onde).*time)];
   m(onde)=2*onde+1;
end

if k == 0
coef = A\var;
else
% Projection de u sur une somme de sinus et cosinus (inv(A)*u)
coef=A\var(:,J,I);
end

for onde=1:NbOndes
       Harm.ampl(onde)=sqrt(coef(m(onde))^2+coef(m(onde)+1)^2);  %temps en heure
   if    (coef(m(onde))~=0)                                     %phase en radian

       Harm.phase(onde)=  atan(coef(m(onde))/coef(m(onde)+1))...
                        + (sign(coef(m(onde)))==-1)*pi;
   else
         Harm.phase(onde)=pi/2+ ...
                        (sign(coef(m(onde)))==-1)*pi;
   end     
         Harm.omega(onde)=omega(onde);
end
Harm.phase = ((Harm.phase*180)/pi);
Harm.phase(Harm.phase<0)=Harm.phase(Harm.phase<0)+360;

% figure,
% UnT=ones(size(time,1),size(time,2));  
% plot(time,var,time,nansum(Harm.ampl.*...
%                 sin((time*Harm.omega+UnT.*...
%                                    Harm.phase*pi/180)),2));
end
% for onde=1:NbOndes
%        Harm.ampl(onde)=sqrt(coef(m(onde))^2+coef(m(onde)+1)^2);  %temps en heure
%        Harm.phase(onde)=  atan(coef(m(onde))/coef(m(onde)+1))...
%                         + (sign(coef(m(onde)))==-1)*pi;
% end




function ii=ChoixOndes(NbOndes)
            %   tide   freq       
% X(4)=1;      %   M2   0.0805114    
% X(5)=2 ;     %   S2   0.0833333    
% X(9)=3 ;     %   MS4  0.1638447    
% X(3)=4 ;     %   K1   0.0417807    
% X(1)=5 ;     %   MSF  0.0028219    
% X(2)=10 ;     %   O1   0.0387307    
% X(6)=10 ;     %   M3   0.1207671    
% X(7)=10 ;     %   SK3  0.1251141    
% X(8)=10 ;     %   M4   0.1610228    
% X(10)=10 ;    %   S4   0.1666667    
% X(11)=10 ;    %   2MK5 0.2028035    
% X(12)=10  ;   %   2SK5 0.2084474    
% X(13)=10  ;   %   M6   0.2415342    
% X(14)=10  ;   %   2MS6 0.2443561    
% X(15)=10  ;   %   2SM6 0.2471781    
% X(16)=10  ;   %   3MK7 0.2833149    
% X(17)=10  ;   %   M8   0.3220456    

% ii=find(X~=0);
% if(size(ii,2)<NbOndes),disp('Probleme dans le choix des ondes'),pause,end
% ii=find(X~=0 & X<=NbOndes);

jj=[cellstr('M2'); cellstr('S2'); ...
    cellstr('K1');cellstr('M4');cellstr('N2');cellstr('S4')];
ii=jj(1:NbOndes);

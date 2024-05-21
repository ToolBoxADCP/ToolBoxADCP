ii=find(detrend(MareeProf)>0.3);
T=MareeTemps;

jj=find(diff(ii)>1);
jj=[0;jj;size(ii,1)];
Jdeb=jj(1:end-1)+1;Jfin=jj(2:end);
[Jdeb Jfin];
Ideb=ii(Jdeb);Ifin=ii(Jfin);
[Ideb Ifin];
Tdeb=T(Ideb);Tfin=T(Ifin);
II=[];
for k=1:size(Ideb,1); 
    II=find(t>Tdeb(k) & t<Tfin(k)) ;
    plot(t(II)/3600,abs(vitesse.u(II,5)),'r')
    plot(t(II)/3600,abs(vitesse.v(II,5)),'g')
end
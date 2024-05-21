   %P0=2650; %MN2
    % P0=1400; %MN1
     %P0=400; %MS
%Pini=2500; %MN2
% Pini=1250; %MN1
 %Pini=250; %MS
 Pini=150; %MN
 Pini=2900; %MS2
BolFig=0;
    degPol=6;
%degPol=10;
clear ErreurU ErreurV CorrelationU CorrelationV
for i=0:20;
    P0=Pini+i*50
    pre_traitement_dephasage
    ErreurU(i+1)=ErrU
    ErreurV(i+1)=ErrV;
    CorrelationU(i+1)=rU
    CorrelationV(i+1)=rV;
end
figure
i=0:20;
ideg=4
pp=polyfit(i,ErreurU,ideg);
err=polyval(pp,i);
subplot(2,2,1),plot(Pini+i*50,err,'r',Pini+i*50,ErreurU,'.r')
pp=polyfit(i,ErreurV,ideg);
err=polyval(pp,i);
subplot(2,2,2),plot(Pini+i*50,err,'r',Pini+i*50,ErreurV,'.r')
pp=polyfit(i,CorrelationU,ideg);
err=polyval(pp,i);
subplot(2,2,3),plot(Pini+i*50,err,'r',Pini+i*50,CorrelationU,'.r')
pp=polyfit(i,CorrelationV,ideg);
err=polyval(pp,i);
subplot(2,2,4),plot(Pini+i*50,err,'r',Pini+i*50,CorrelationV,'.r')

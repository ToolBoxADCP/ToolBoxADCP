BolFig=0;
degPol=10;
clear ErreurU ErreurV CorrelationU CorrelationV
for degPol=1:15;
    degPol
BolFig=1;
    pre_traitement_dephasage
    degPol
    ErreurU(degPol)=ErrU
    ErreurV(degPol)=ErrV;
    CorrelationU(degPol)=rU;
    CorrelationV(degPol)=rV;
end
figure
degPlot=1:15;
ideg=4
pp=polyfit(degPlot,ErreurU,ideg);
err=polyval(pp,degPlot);
subplot(2,2,1),plot(degPlot,err,'r',degPlot,ErreurU,'.r')
pp=polyfit(degPlot,ErreurV,ideg);
err=polyval(pp,degPlot);
subplot(2,2,2),plot(degPlot,err,'r',degPlot,ErreurV,'.r')
pp=polyfit(degPlot,CorrelationU,ideg);
err=polyval(pp,degPlot);
subplot(2,2,3),plot(degPlot,err,'r',degPlot,CorrelationU,'.r')
pp=polyfit(degPlot,CorrelationV,ideg);
err=polyval(pp,degPlot);
subplot(2,2,4),plot(degPlot,err,'r',degPlot,CorrelationV,'.r')

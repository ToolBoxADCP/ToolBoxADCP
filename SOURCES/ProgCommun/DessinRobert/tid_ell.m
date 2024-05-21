for n=1:size(HarmU.ampl,2)
   T=2*pi/HarmV.omega(n);
   t=0:T/100:T-T/25;
   x= HarmU.ampl(n)*cos(HarmU.omega(n)*t+HarmU.phase(n));
   y= HarmV.ampl(n)*cos(HarmV.omega(n)*t+HarmV.phase(n));
   plot(x,y,c_e(n,:))
end
legend(HarmV.name,'location','best')
plot(x0,y0,'*r')
for n=1:size(HarmU.ampl,2)
   t=0;
   x= x0+HarmU.ampl(n)*cos(HarmU.omega(n)*t+HarmU.phase(n));
   y= y0+HarmV.ampl(n)*cos(HarmV.omega(n)*t+HarmV.phase(n));
   plot([x0 x(1)],[y0 y(1)],c_f(n,:))
end

box on,axis equal
titre=[cellstr([Nom(i,:),' -  Niveau : ',num2str(niv)])];
title(titre)
xlabel('vitesse est (mm/s)')
ylabel('vitesse nord (mm/s)')

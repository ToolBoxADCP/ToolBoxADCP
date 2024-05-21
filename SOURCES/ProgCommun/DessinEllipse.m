function DessinEllipse(E,prof,c,ech,X0,Y0);
GlobaleVar

alpha=[0:pi/20:2*pi];
x= 2*E.eta*cos(alpha);
y= 2*E.nu*sin(alpha);
%expression de l'ellipse dans le rep�re Nord-Est
X= E.umoy+ x * cos(E.teta) - y * sin(E.teta);
Y= E.vmoy+ x* sin(E.teta) + y * cos(E.teta);
Val=['Prof : ' num2str(prof) ...
    '     Vitesse moyenne u // v // amplitude : ' ...
    num2str([E.umoy E.vmoy sqrt(E.umoy.^2+E.vmoy.^2)])];
disp(Val)

figure(3),plot(X0+X/ech,Y0+Y/ech,'Color',c,'LineWidth',2),hold on
quiver(X0,Y0,E.umoy/ech,E.vmoy/ech,0,'Color',c,'LineWidth',2)

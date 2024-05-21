function DefBorneMouillage(i)
GlobaleVar

DonneesCampagne(i)

t=[];time1=[];
tn1=251:8882;
tn2=541:8912;
tb=38:5563;
ts=970:8943;
i_niv=2;

param_form_mouillageC
i_niv=min(i_niv,size(vitesse.u,2));
figure(1),clf,plot(vitesse.u(:,i_niv))
Niv_eau
figure(2),clf,plot(depth)

tmi=1;tmin=tmi;
tma=size(vitesse.u,1);tmax=tma;
while (tmi>=0),
    tmin=tmi;
    figure(1),clf,plot(vitesse.u(:,i_niv))
    figure(2),clf,plot(depth)
    t=tmin:tmax;
    figure(1),hold on,plot(t,vitesse.u(t,i_niv),'.r')
    title('Vitesse')
    %figure(2),hold on,plot(t,depth(t),'.r')
    if (FichPression=='ADCP ')
        figure(2),hold on,plot(t,depth(t,1),'.r')
    end
    title('Niveau')
    tmi = eval(input('tmin (valeur négative si ok) = ', 's'));
end
while (tma>0),
    tmax=tma;
    figure(1),clf,plot(vitesse.u(:,i_niv))
    figure(2),clf,plot(depth)
    t=tmin:min(tmax,size(vitesse.u(:,i_niv)));
    figure(1),hold on,plot(t,vitesse.u(t,i_niv),'.r')
    %figure(2),hold on,plot(t,depth(t),'.r')
    figure(2),hold on,plot(t,depth(t,1),'.r')
    tma = eval(input('tmax (valeur négative si ok) = ', 's'));
end
    
[a,b]=mkdir (Dir_BorneMouillage);
  save (BorneMouillage, 't')
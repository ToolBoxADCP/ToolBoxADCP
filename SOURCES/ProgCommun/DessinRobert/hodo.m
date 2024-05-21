function hodo(vit,t,x_0,y_0,t_0,h,dlat,dlong,Fig,DTexpr)
ech=1;

%% Attention on suppose que t est lin�airement continu

c1=['k';'c';'m'];
c2=['.k';'.c';'.m'];
c3=['.-k';'.-c';'.-m'];

u=vit.u*1E-3; u(3)=NaN;%en m/s
ii=find(isnan(u)==0);
if(size(ii,1)>=2)
    u=interp1(t(ii),u(ii),t);
    v=vit.v*1E-3; %en m/s
    ii=find(isnan(v)==0);v=interp1(t(ii),v(ii),t);
    if(size(ii,1)~=size(v,1))
        figure(1),clf,plot(t,v,'.b'),hold on,...
            plot(t(ii),v(ii),'.r'),
    end
    dt=min(diff(t*24*60))*60; %on suppose que dt est constant
    dt_jour=floor(DTexpr/dt*24*3600);
    A=ones(size(u,1),size(u,1));

    x=x_0+dt/ech*tril(A)*u/dlong;
    y=y_0+ (tril(A)*v)*dt/ech/dlat;

    figure(Fig+1),
      plot(x_0,y_0,'*r')
      hold on
      plot(x,y,c1(h,:))

    figure(Fig+2),
      plot(x_0,y_0,'*r')
      hold on
      plot(x(1:dt_jour:end),y(1:dt_jour:end),c3(h,:))

    for i=size(t,1):-dt_jour:1;
       figure(Fig+1),plot(x(i),y(i),c2(h,:),'MarkerSize',15)
       figure(Fig+2),plot(x(i),y(i),c2(h,:),'MarkerSize',15)
    end

    figure(Fig+1),
      if(h==1),
        i=1;text(x(i),y(i),datestr(t(i)+t_0))
        i=size(t,1);text(x(i),y(i),datestr(t(i)+t_0))
      end
    figure(Fig+2),
      if(h==1),
        i=1;text(x(i),y(i),datestr(t(i)+t_0))
        i=size(t,1);text(x(i),y(i),datestr(t(i)+t_0))
      end
end


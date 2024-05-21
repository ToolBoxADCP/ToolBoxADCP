function [vit]=Vit_Mouillage(temps,prof,Harmonique,Hcellule);
% Temps est en seconde et on le convertit en heure ...
%Harmonique.temps est en heure, mais à partir du 0 de matlab
% donc faire Harmonique.temps-T0*24 pour avoir l'origine T0
GlobaleVar

I=1;
Harm=[];
vit=[];
i=round(prof/celM);
if(isstruct(temps)==1)
  t=(datum_str(temps)-T0)*24; % en heure
else
    t=temps'/3600;
end

HcMin=min(Hcellule);HcMax=max(Hcellule);
prof=max(prof,HcMin);prof=min(prof,HcMax); % pour éviter les NaN dus aux depassement de prof
u1=0;u2=0;u=0;
ome=[1.4052e-004;1.4544e-004]*3600;
for ind=1:NbOndes;
  Harm.ampl=interp1(Hcellule,Harmonique.ampl(:,ind),prof,'nearest');
  Harm.phase=interp1(Hcellule,Harmonique.phase(:,ind),prof,'nearest');
%   aaa=interp1(Hcellule,Harmonique.ampl(:,ind),prof,'nearest');
%   bbb=interp1(Hcellule,Harmonique.ampl(:,ind),prof);
%   Harm.ampl=bbb;
%   aaa=interp1(Hcellule,Harmonique.phase(:,ind),prof,'nearest');
%   bbb=interp1(Hcellule,Harmonique.phase(:,ind),prof);
%   Harm.phase=aaa;
  om=Harmonique.omega(1,ind);%om=ome(2)
  vit(:,I)=Harm.ampl.*sin(om*t+Harm.phase);I=I+1;
  vit(:,I)=Harm.ampl.*cos(om*t+Harm.phase);I=I+1;
end

vect=ones(1,size(Harmonique.temps,2));
vit(:,I)=interp2(Harmonique.temps-T0*24,Hcellule'*vect,Harmonique.res,t,prof);
a=interp1(Hcellule,Harmonique.lin(:,2),prof);
jdmid=(Harmonique.temps(1,1)+Harmonique.temps(end,end))/2
vit(:,I)=vit(:,I)+a.*(t-jdmid);
I=I+1;% sum(vit(:,2)-Harmonique.res(ii,:)')

u=0;
%u=[];
for ind=1:1%2
  a=interp1(Hcellule,Harmonique.lin(:,ind),prof);
  u=a.*((t).^(ind-1));
  vit(:,I)=u;I=I+1;
  %u(:,ind)=a.*((t/3600).^(ind-1));
end


%   vit(:,1)=vit(:,1)+u;
 % vit(:,I)=u;

%  vit(:,3)=u(:,1);
 % vit(:,2)=vit(:,2)+u(:,2);

%  u=0;
% for ind=1:NbOndes;
% om=Harm.omega(ind);
% u=u+Harm.ampl(ind).*sin(om*t+Harm.phase(ind));
% end
% vit(:,1)=u;
% vit(:,2)=Harm.res;
% u=0;
% for ind=1:2
% a=Harm.lin(ind);
% u=u+a.*((t/3600).^(ind-1));
% end
% vit(:,3)=u;
% u=sum(vit');



%ii=find(isnan(vit(:,1))==1 | isnan(vit(:,2))==1 );
%figure,pcolor(Harmonique.temps,Hcellule'*ones(1,size(Harmonique.temps,2)),Harmonique.res)
%shading flat,hold on,plot(t,prof,'*'),plot(t(ii),prof(ii),'or')


%figure,plot(t,vit.u(:,2),'ob')
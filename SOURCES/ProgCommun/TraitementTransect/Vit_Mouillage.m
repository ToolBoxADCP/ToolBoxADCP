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
    t=temps/3600;
end

N_harm=size(Harmonique,2);
M_harm=size(Harmonique(1).temps,1);
ampl=NaN*ones(N_harm,NbOndes);phase=ampl;
lin=NaN*ones(N_harm,size(Harmonique(1).lin,2));
res=NaN*ones(N_harm,size(Harmonique(1).res,1));
for k =1:N_harm
  ampl(k,:)=Harmonique(k).ampl;
  phase(k,:)=Harmonique(k).phase;
  lin(k,:)=Harmonique(k).lin;
  res(k,:)=Harmonique(k).res;
  MoyGliss(k,:)=Harmonique(k).MoyGliss;
end

HcMin=min(Hcellule);HcMax=max(Hcellule);
prof=max(prof,HcMin);prof=min(prof,HcMax); % pour éviter les NaN dus aux depassement de prof
u1=0;u2=0;u=0;
ome=[1.4052e-004;1.4544e-004]*3600;
for ind=1:NbOndes;
  Harm.ampl=interp1(Hcellule,ampl(:,ind)',prof,'nearest');
  Harm.phase=interp1(Hcellule,phase(:,ind)',prof,'nearest');
%   aaa=interp1(Hcellule,Harmonique.ampl(:,ind),prof,'nearest');
%   bbb=interp1(Hcellule,Harmonique.ampl(:,ind),prof);
%   Harm.ampl=bbb;
%   aaa=interp1(Hcellule,Harmonique.phase(:,ind),prof,'nearest');
%   bbb=interp1(Hcellule,Harmonique.phase(:,ind),prof);
%   Harm.phase=aaa;
  om=Harmonique(1).omega(ind);%om=ome(2)
  vit(:,I)=Harm.ampl.*sin(om*t+Harm.phase);I=I+1;
  vit(:,I)=Harm.ampl.*cos(om*t+Harm.phase);I=I+1;
end

vectY=ones(1,M_harm);
vectX=ones(N_harm,1);
Moy_gliss=interp2(vectX*Harmonique(1).temps',Hcellule'*vectY,MoyGliss,t,prof,'linear');
vit(:,I)=interp2(vectX*Harmonique(1).temps',Hcellule'*vectY,res,t,prof)-Moy_gliss;
% a=interp1(Hcellule,lin(:,2),prof);
% vit(:,I)=vit(:,I)+a.*t;
I=I+1;% sum(vit(:,2)-Harmonique.res(ii,:)')

u=0;
%u=[];
for ind=1:2
  a=interp1(Hcellule,lin(:,ind),prof);
  u=u+a.*((t).^(ind-1));
  %u(:,ind)=a.*((t/3600).^(ind-1));
end
u=u+Moy_gliss;
vit(:,I)=u;
I=I+1;
% Vitesse=sum(vit,2);
% plot(t/24,Vitesse)
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
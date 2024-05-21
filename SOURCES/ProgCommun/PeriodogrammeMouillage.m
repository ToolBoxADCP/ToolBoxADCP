function [sortie,f]=periodogrammeMouillage(varargin)
%2 variables demand�es: le type de variable : u, v ou h et nbtirage, le
%nombre de tirages

nbtirages=cell2mat(varargin(1));

GlobaleVar

var=cell2mat(varargin(2));
if(size(var,2)==1)
  if (var==['u'])
      var=='uuu';
  elseif (var==['v'])
      var=='vvv';
  elseif (var==['h'])
      var=='hhh';
  end
end
if (var==['uuu'])
    i=cell2mat(varargin(3));
    load (MouillagePropre)
    disp('FFT sur u')
    S=vitesse.u(:,i);
    jjadcp=(datum_str(Temps)-T0);
    load (MouillageAnalyse)
         Harm=HarmoniqueU(i);
%     Harm=HarmoniqueNondes('u',i);
elseif (var==['vvv'])
    i=cell2mat(varargin(3));
    load (MouillagePropre)
    disp('FFT sur v')
    S=vitesse.v(:,i);
    jjadcp=(datum_str(Temps)-T0);
    load (MouillageAnalyse)
         Harm=HarmoniqueV(i);
%     Harm=HarmoniqueNondes('v',i);
elseif (var==['hhh'])
    load (MouillagePropre)
    disp('FFT sur h')
    S=P.depth;
    jjadcp=(datum_str(Temps)-T0);
    load (MouillageAnalyse)
         Harm=HarmoniqueH;
%     Harm=HarmoniqueNondes('h');
elseif (var==['Upr'])
    disp('FFT sur Uproj')
    i=cell2mat(varargin(3));
    load (MouillageAnalyse)
    S=Projection.u(:,i);
    jjadcp=(datum_str(Temps)-T0);
    load (MouillageAnalyse_proj)
         Harm=HarmoniqueU(i);
%     Harm=HarmoniqueNondes('Upr',i);
elseif (var==['Vpr'])
    i=cell2mat(varargin(3));
    load (MouillageAnalyse)
    disp('FFT sur Vproj')
    S=Projection.v(:,i);
    jjadcp=(datum_str(Temps)-T0);
    load (MouillageAnalyse_proj)
         Harm=HarmoniqueV(i);
%     Harm=HarmoniqueNondes('Vpr',i);    
elseif (var==['Div'])
    disp('FFT')
    S=cell2mat(varargin(3));
    jjadcp=cell2mat(varargin(4));
    %Harm=HarmoniqueNondes('div',S,jjadcp,1,size(S,1),jjadcp);
end

%ind=find(isnan(S)==0);S=S(ind);jjadcp=jjadcp(ind);size(ind)
Ssauv=S;jjadcp_sauv=jjadcp;
S=interpnan(S);S=detrend(S);

deltaT=nanmean(diff(jjadcp));%*24*3600;
% f=((0:((((length(jjadcp))/nbtirages))-2)))/((length(jjadcp)*deltaT*2));
f=((0:((((length(jjadcp))/nbtirages))-2))+1)/((length(jjadcp)*deltaT*2));%Sab

%f=(1./f)/3600;
%nantest=sum(isnan(S));
% if nantest>=1
%     ind=find(isnan(S));
%    kdo=interp1(S,ind(1))
%    for i=1:length(S)
%        if isnan(S(i))
%           S(i)=(S(i-1)+S(i))/2;
%       end
%   end
% end

for i=1:nbtirages;
    
Scov=S(i:nbtirages:end-nbtirages+i-1);
conv=xcorr(Scov',Scov');
clear tampon
taille=length(detrend(conv));
x=0:taille-1;
hanning=0.5*(1-cos(2*pi*x/(taille)));
%hanningmoins=0.5*(1+cos(-2*pi*x/(taille)));
%hanning=[fliplr(hanningmoning.*conv')));
% tampon=abs(fft(detrend(hains),hanning];
%figure;plot(hanning)
% conv=conv'; % sab

if size(hanning,1) ~= size(conv,1)
    conv=conv';
end;

tampon=abs(fft(detrend(hanning.*conv)));% SAB

DSP(i,:)=tampon(1:((length(tampon)/2)+1))/length(hanning);

end
DSP;
%sortie=nanmean(DSP,1);
for i=1:length(DSP)
    sortie(i)=nanmean(DSP(:,i));
end
sortie=sortie*nbtirages;
if length(sortie)~= length(f)
    sortie=sortie(1:end-1);
end;
'alex'
figure
subplot(2,1,1),plot(f,sortie)
subplot(2,1,2),plot(jjadcp_sauv,Ssauv,'c')

%%Dessin
if (var~=['Div'])
t=Harm.temps;
u=VitesseCalculeeAvecHarmonique(NbOndes,Harm,t,T0);
hold on,
plot(t'/24,u,'r')
%hold on,plot(t'/24,-u,'r')
grid,box on
%Fin
end


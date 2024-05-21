function [ampl,ph]=ReducPhase(amplI,phI_d,om,fid1);

BolFig=1;

phI=phI_d*pi/180;
%% Dessin
if(BolFig==1)
clf
t=0:10*24;
x=-sum((amplI'*ones(size(t))).*sin(om'*t+phI'*ones(size(t))));
hold on,plot(t,x,'k');
end

%% Reduction
% Le premier pas aurait pu etre inutile, mais cela me semble plus clair
n=floor(phI/(2*pi));
ph=phI-n*2*pi;

n=floor(ph/pi);
ph=ph-n*pi;
ampl=(-1).^n.*amplI;

%% Verif Dessin
if(BolFig==1)
x=-sum((ampl'*ones(size(t))).*sin(om'*t+ph'*ones(size(t))));
hold on,plot(t,x,'--g');
%pause
end

%% Ecriture ecran
phI;
% Inscription dans le fichier dédié
    fprintf(fid1,'\n Amplitude : ');
         fprintf(fid1,'%8.2f ');
    for k=1:size(ampl,2)
         fprintf(fid1,'%8.2f ',ampl(k));
         fprintf(fid1,'%t ');
    end
    
    fprintf(fid1,'\n Phase  en radian : ');
    for k=1:size(ampl,2)
         fprintf(fid1,'%8.2f ',ph(k));
         fprintf(fid1,'%t ');
    end
    
    fprintf(fid1,'\n Phase  en degre : ');
    for k=1:size(ampl,2)
         fprintf(fid1,'%8.2f ',ph(k)*180/pi);
         fprintf(fid1,'%t ');
    end
    
    fprintf(fid1,'\n Phase  en heure : ');
    for k=1:size(ampl,2)
         fprintf(fid1,'%8.2f ',ph(k)./om(k));
         fprintf(fid1,'%t ');
    end

    fprintf(fid1,'\n');
texte=['Phase en radian :' num2str(ph)];disp(texte)
texte=['Phase en degre :' num2str(ph*180/pi)];disp(texte)
texte=['Phase en heure :' num2str(ph./om)];disp(texte)
texte=['Amplitude mm/s :' num2str(ampl)];disp(texte)
ph=ph./om;

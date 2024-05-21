function [Temps ,vitesse,depth]=lecture(Jfile,bmin,bmax,inv,Bt);
global hadcpTr

load (Jfile)

if(bmax>bmin)
    t=bmin:bmax;
else
    t=1:size(SerDay,1);
end
Temps.day=SerDay(t,:);'jour',Temps.day(1)
Temps.month=SerMon(t,:);
Temps.year=SerYear(t,:);
Temps.hour=SerHour(t,:);
Temps.minute=SerMin(t,:);
Temps.seconde=SerSec(t,:);
vitesse.ubt=AnBTEmmpersec(t,:);
vitesse.vbt=AnBTNmmpersec(t,:);
vitesse.u=SerEmmpersec(t,:);
vitesse.v=SerNmmpersec(t,:);
if (Bt==1)
  vitesse.u=SerEmmpersec(t,:)+vitesse.ubt*ones(1,size(SerEmmpersec,2));
  vitesse.v=SerNmmpersec(t,:)+vitesse.vbt*ones(1,size(SerEmmpersec,2));
end
if(inv==1),vitesse.u=fliplr(vitesse.u);end
if(inv==1),vitesse.v=fliplr(vitesse.v);end
depth=(AnBTDepthcmB4(t,:)+AnBTDepthcmB3(t,:)+AnBTDepthcmB2(t,:)+AnBTDepthcmB1(t,:))/400;
depth=depth+hadcpTr;
%depth=min([AnBTDepthcmB1(t),AnBTDepthcmB4(t,:),AnBTDepthcmB3(t,:),AnBTDepthcmB2(t)]')'/100;

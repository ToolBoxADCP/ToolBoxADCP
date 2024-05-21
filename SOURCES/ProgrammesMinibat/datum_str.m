function [jjadcpA]=datum_str(temps);

jjadcpA=datenum(temps.year,temps.month,temps.day,temps.hour,temps.minute,temps.seconde);


% load prof_barriere.txt
% t=300:8800;
% t1=1:length(prof_barriere);
% jjadcp=datenum(prof_barriere(t1,5)-2000,prof_barriere(t1,4),prof_barriere(t1,3),prof_barriere(t1,6),prof_barriere(t1,7),prof_barriere(t1,8));
% figure, plot(jjadcp,prof_barriere(t1,2)-mean(prof_barriere(t1,2)))
% load mn1
% jjadcp_mn1=datenum(SerYear,SerMon,SerDay,SerHour,SerMin,SerSec);
% hold on, plot(jjadcp_mn1(t),AnDepthmm(t)*1e-3-mean(AnDepthmm(t)*1e-3),'r')

%addpath ..\..\Mayotte\ProgrammesTraitementGlobal_sept09\ProgCommun\DessinRobert
NomMois=[cellstr('Janvier');cellstr('Fevrier');cellstr('Mars');...
         cellstr('Avril');cellstr('Mai');cellstr('Juin');...
         cellstr('Juillet');cellstr('Aout');cellstr('Septembre');...
         cellstr('Octobre');cellstr('Novembre');cellstr('Decembre')];
Tmin=999999;
Tmax=0;
close all, 

%% Determination du premier jour des mesures (en mouillage)
for i = 1:size(Nom,1);
  Nom(i,:);DonneesCampagne(Nom(i,:))
  load(MouillagePropre)
  T=datum_str(Temps);
  Tmin=min(min(T),Tmin);
  Tmax=max(max(T),Tmax);
end
Xmin=datestr(Tmin,24);
  PremMes.day=str2num(Xmin(1:2));
  PremMes.month=str2num(Xmin(4:5));
  PremMes.year=str2num(Xmin(7:10));
  PremMes.hour=0;
  PremMes.minute=0;
  PremMes.seconde=0;

Xmax=datestr(Tmax,24);
  DerMes.day=str2num(Xmax(1:2));
  DerMes.month=str2num(Xmax(4:5));
  DerMes.year=str2num(Xmax(7:10));
  DerMes.hour=0;
  DerMes.minute=0;
  DerMes.seconde=0;

  
%% Date du premier et dernier dessin (� partir du 1er de chaque mois)
% ATTENTION on suppose que l'ann�e est la m�me

NbMois=(DerMes.year-PremMes.year)*12....
        + DerMes.month-PremMes.month+1;

% if (DerMes.year~=PremMes.year)
%     disp('Probleme')
%     break
% end

mois=0;
for i=PremMes.month:PremMes.month+NbMois
    mois=mois+1;
  DebDessin(mois)=PremMes;
  DebDessin(mois).day=1;
  DebDessin(mois).month=PremMes.month+mois-1;
  DebDessin(mois).year=PremMes.year;
%  DebDessin(mois).year=floor(DebDessin(mois).month/12)+PremMes.year;
  
  FinDessin(mois)=PremMes;
  FinDessin(mois).day=1;
  FinDessin(mois).month=DebDessin(mois).month+1;
  %FinDessin(mois).year=floor(FinDessin(mois).month/12)+PremMes.year;
  FinDessin(mois).year=PremMes.year;
end

if(NbMois>1)
    JourMin=1;JourMax=32;
else
    JourMin=PremMes.day;
    JourMax=DerMes.day+1;
end


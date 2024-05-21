echof=[];
temperaturef=[];
Pf.lat=PositionMouillage.lat;
Pf.long=PositionMouillage.long;
Pf.depth=[];
Nmax=size(NomCouranto,1);    vectY=ones(1,Nmax);

for i = 1:Nmax;
  close all
  DonneesCampagne(NomCouranto(i,:));
  load(MouillagePropre)
    if (exist('EchoPropre','var'))
        load(EchoPropre)
    end
    if (exist('TemperaturePropre','var'))
        load(TemperaturePropre)
    end    
    Tempsf=Temps;

    Pf.depth(:,i)=P.depth+hadcpM;
    vitessef.u(:,i)=vitesse.u;
    vitessef.v(:,i)=vitesse.v;
    echof(:,i)=echo;
    temperaturef(:,i)=temperature;

    ligne=size(vitesse.u,1);    vectX=ones(ligne,1);   
    Pf_Adcp.surface_f(:,i)=P.depth;
    Pf_Adcp.fond_f(:,i)=vectX*hadcpM; 
end

%% Changement Noms
Temps=Tempsf;
P=Pf;
vitesse=vitessef;
echo=echof;
temperature=temperaturef;
P_Adcp=Pf_Adcp;

save(NivMax,'Nmax')



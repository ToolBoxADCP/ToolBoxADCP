% Caractéristiques au niveau de l'ADCP : 
%   AnDepthmm     = Profondeur en mm              
%   AnP100thDeg   = Pitch   * 100           
%   AnR100thDeg   = Roll    * 100             
%   AnT100thDeg   = Temperature   * 100 

% Caractéristiques Programmation et appareil : 
%   RDIBin1Mid   = Niveau de la bin 1               
%   RDIBinSize   = taille des cellules               
%   SerBins      = Nb  de bin 
%   RDIEnsDate                     
%   RDIEnsInterval                   
%   RDIEnsTime                       
%   RDIFileName                       
%   RDIPingsPerEns                 
%   RDISecPerPing                  
%   RDISystem                        
%   SerEnsembles   = valeur allant de 1 à la fin des mesure               
%   SerHund    = 0              

% Temps : 
%   SerYear       = année
%   SerMon        = mois        
%   SerDay        = jour
%   SerHour       = heure          
%   SerMin        = minute         
%   SerSec        = seconde   
 
% Echo
%   SerEA1cnt    =  echo amplitude cellule 1           
%   SerEA2cnt    =  echo amplitude cellule 2             
%   SerEA3cnt    =  echo amplitude cellule 3             
%   SerEA4cnt    =  echo amplitude cellule 4             
%   SerEAAcnt    =  echo amplitude moyenne

% Vitesse
%   SerEmmpersec  =  Vitesse Est             
%   SerNmmpersec  =  Vitesse Nord             
%   SerErmmpersec =  Vitesse Verticale             
%   SerVmmpersec  =  Erreur vitesse             

load (DonneesMouillage)
if (size(t)==0); t=1:size(SerEmmpersec,1);end
vitesse.u=SerEmmpersec(t,:);
vitesse.v=SerNmmpersec(t,:);
if (FichPression(1:5)=='ADCP ')
  depth=AnDepthmm(t)/1000;
end
if (NomTemp(1:3)=='RDI')|(NomTemp(1:3)=='ADI'); 
    temperature=AnT100thDeg(t,:);
end
if (NomTemp(1:3)=='txt'); 
    disp('A FAIRE')
end
if size(NomEcho,1)>0
    if (NomEcho(1:3)=='RDI'); 
        echo=SerEAAcnt(t,:);
    %     if (FichPression=='ADCP '); 
    %       depth=D_Mouil(t,10);plot(depth,'.')
    %end
    end
end

Temps.day=SerDay(t,:);
Temps.month=SerMon(t,:);
Temps.year=SerYear(t,:);
   if(Temps.year(1)<1000),Temps.year=Temps.year+2000;end
Temps.hour=SerHour(t,:);
Temps.minute=SerMin(t,:);
Temps.seconde=SerSec(t,:);
if exist('RDIBin1Mid','var')
    blankM = RDIBin1Mid;
end
if exist('RDIBinSize','var')
    celM = RDIBinSize;
end

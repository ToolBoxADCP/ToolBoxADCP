%%  Transect Th�orique :
%%%% D�finition de la droite de transect th�orique passe SUD � partir de TS21:
%%%% on obtient une droite passant par le plus de points
load (MouillageAnalyse)
load (GPStrans)
TransTheo


%%  D�finition des Transects :
 %Rep�rage des transects : fichier T14
 %Rep�rage des transects : fichier T21
 %Rep�rage des transects : fichier T22
load (BorneTransect)
load (GPS_Donnees)
NbTrans=zeros(nbTronc);

if(Reponse==1)
    RepFich=load(FichierReponse)
    iReponse=1;
end
  
load(MouillageMoy)
for nb=1:size(Jfile,1)
    celTr=TcelTr(nb)
    bl=blankTr(nb)+hadcpTr;
    DefTrans
end


 


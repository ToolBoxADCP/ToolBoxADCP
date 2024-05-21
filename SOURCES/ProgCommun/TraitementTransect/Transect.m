%%  Transect Théorique :
%%%% Définition de la droite de transect théorique passe SUD à partir de TS21:
%%%% on obtient une droite passant par le plus de points
load (MouillageAnalyse)
load (GPStrans)
TransTheo


%%  Définition des Transects :
 %Repérage des transects : fichier T14
 %Repérage des transects : fichier T21
 %Repérage des transects : fichier T22
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


 


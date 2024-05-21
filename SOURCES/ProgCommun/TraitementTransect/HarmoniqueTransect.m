%% Initialisation :
%% Choix de Ondes
Ondes=ChoixOndes(NbOndes);

fichierE=['TempE'];
fichierS=['TempS'];


for Tronc=1:nbTronc;
   load(VitReconst(Tronc,:))
   N=size(Tr_reconst.z,2);    

   %% Creation du fichier � lire par Foreman
   t=Tr_reconst.Temps/24;% en jour
   Jour=floor(t);Heure=(t-Jour)*24;
   
   clear HarmReconstV HarmReconstU HarmReconstVmoy HarmReconstUmoy
   for pas=1:1:size(Tr_reconst.dpas,2);
      disp(['Nom : ' nom ' - Troncon : ' num2str(Tronc) ...
            ' - Pas : ' num2str(pas)]),
      for niv=1:N;
      
        u=Tr_reconst.U(:,pas,niv);
        v=Tr_reconst.V(:,pas,niv);
        
        jj=find(isnan(u)==0 | isnan(v)==0  );
        if (isempty(jj)==0)
        
%% Vitesse U : Pour chaque niveau on execute Foreman 
           HarmReconstU(pas,niv)=DefHarmonique(Jour,Heure,u,...
             NbOndes,Ondes,T0,fichierE,fichierS,0);

%% Vitesse V :  
           HarmReconstV(pas,niv)=DefHarmonique(Jour,Heure,v,...
             NbOndes,Ondes,T0,fichierE,fichierS,0);
        else
%% Vitesse U : Pour chaque niveau on execute Foreman 
           HarmReconstU(pas,niv)=AnnulHarmonique;

%% Vitesse V :  
           HarmReconstV(pas,niv)=AnnulHarmonique;
            
         
        end

      end
        u=nanmean(squeeze(Tr_reconst.U(:,pas,:)),2);
        v=nanmean(squeeze(Tr_reconst.V(:,pas,:)),2);
        
        jj=find(isnan(u)==0 | isnan(v)==0  );
        if (isempty(jj)==0)
        
%% Vitesse U : Pour chaque niveau on execute Foreman 
           HarmReconstUmoy(pas)=DefHarmonique(Jour,Heure,u,...
             NbOndes,Ondes,T0,fichierE,fichierS,0);

%% Vitesse V :  
           HarmReconstVmoy(pas)=DefHarmonique(Jour,Heure,v,...
             NbOndes,Ondes,T0,fichierE,fichierS,0);
        else
      
%% Vitesse U : Pour chaque niveau on execute Foreman 
           HarmReconstUmoy(pas)=AnnulHarmonique;

%% Vitesse V :  
           HarmReconstVmoy(pas)=AnnulHarmonique;
            
        end
   end
   save(HarmVitReconst(Tronc,:),'HarmReconstU','HarmReconstUmoy', ...
                             'HarmReconstV','HarmReconstVmoy')
end


   

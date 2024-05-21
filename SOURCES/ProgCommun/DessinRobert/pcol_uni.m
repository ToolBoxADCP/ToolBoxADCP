function pcol_uni(t,z,vit,fich,mouil,mois,NomMois,Annee,NomDessin,...
    Tmes,T_fin,JourMin,JourMax,Campagne);
clf,
  Zmin=min(min(z));
  Zmax=max(max(z));
      [ligne,col]=size(vit);vectY=ones(1,col);
      pcolor(t*vectY,z,vit),box on
      colorbar,shading flat,
      titre=[cellstr([char(NomMois) ' ' num2str(Annee)]) ...
          cellstr([NomDessin ' - Mouillage ',mouil])];
      title(titre), axis([JourMin JourMax Zmin Zmax])
xlabel('Jour')
texte=['Profondeur'];ylabel(texte)
if(strcmp(Campagne,'Tulear1')|strcmp(Campagne,'Tulear2'))
    BarrePrelev(Tmes,T_fin,mouil)
end


      Fichier=[fich '_' mouil '_' num2str(mois) '_' num2str(Annee)];
      saveas(gcf,Fichier,'fig')
      %saveas(gcf,Fichier,'png')
        

DescriptifCampagne
BinMouillage=['Bin_Te';'Bin_Is';'Bin_CN';'Bin_PI'];
DirBin='Beam/';
for i = 1:size(Nom,1);
  Nom(i,:);
  Fich=[DirBin BinMouillage(i,:)]
  FichDessin=['PourMarc/' BinMouillage(i,:)];
  FichAscii=['PourMarc/Ascii_' BinMouillage(i,:)];
  FichHoussem=['PourMarc/Houssem_' BinMouillage(i,:)];
  DonneesCampagne(Nom(i,:))
  load (BorneMouillage)
  N_t(i)=MaxProf(Nom(i,:));
  if NomADCP=='ADI   '
      load(DonneesMouillage)
      Bin=SerEAAcnt(t,1:N_t(i));
      load(MouillageMoy)
      T=datum_str(Temps);

      figure,plot(T,Bin(:,N_t(i)))
      hold on
      plot(T,Bin(:,1),'r')
      title(Nom(i,:))
          saveas(gcf,FichDessin,'fig')
          axis([5014 5028 100 200])
          saveas(gcf,FichDessin,'png')
      save (Fich,'Temps','Bin')
      toto=[Temps.year Temps.month Temps.day Temps.hour Temps.minute ...
            Temps.seconde Bin];
      save(FichAscii,'toto','-ascii')
  elseif NomADCP=='SONTEK'
      Mfile=[DonneesMouillage '.a1'];
      D_Mouil=load(Mfile);
      Bin1=D_Mouil(t,2:N_t(i)+1);
      Mfile=[DonneesMouillage '.a2'];
      D_Mouil=load(Mfile);
      Bin2=D_Mouil(t,2:N_t(i)+1);
      Mfile=[DonneesMouillage '.a3'];
      D_Mouil=load(Mfile);
      Bin3=D_Mouil(t,2:N_t(i)+1);
      
      load(MouillageMoy)
      T=datum_str(Temps);
      
      Bin=(Bin1+Bin2+Bin3)/3;
      figure,plot(T,Bin(:,N_t(i)))
      hold on
      plot(T,Bin(:,2),'r')
      title(Nom(i,:))
          saveas(gcf,FichDessin,'fig')
          axis([5014 5028 40 140])
          saveas(gcf,FichDessin,'png')
      save (Fich,'Temps','Bin')
      toto=[Temps.year Temps.month Temps.day Temps.hour Temps.minute ...
            Temps.seconde Bin1 Bin2 Bin3 Bin];
      save(FichAscii,'toto','-ascii')
      save(FichHoussem,'T','Bin')
  end
end
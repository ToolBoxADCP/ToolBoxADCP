fichMouillage='./DessinRobert/DispersalEllipse/';
dirMouillage='./DessinRobert/DispersalEllipse';
[a,b]=mkdir (dirMouillage);

for i = 1:size(Nom,1);
  close,figure(3),clf,hold on
  DonneesCampagne(Nom(i,:));
  
  %faire changer un trait de couleur en fonction de la profondeur
  Nmax=MaxProf(Nom(i,:))
  c=zeros(Nmax,3);colormap(c);c=colormap('jet');
  load(MouillageAnalyse)
  for niv=1:Nmax;
      DessinEllipse(Ellipse(niv),1,c(niv,:),1,0,0)
  end
  xlabel('Vitesse Est (mm/s)'),ylabel('Vitesse Nord (mm/s)')
  colorbar
  box on
  titre=[cellstr([Nom(i,:)])];title(titre)

  fichM=[num2str(fichMouillage) num2str(char(cellstr(Nom(i,:))))];
  saveas(gcf,fichM,'fig')
  saveas(gcf,fichM,'png')

  pause
end


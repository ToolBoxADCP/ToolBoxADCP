fichMouillage='./DessinRobert/TidalEllipse/';
dirMouillage='./DessinRobert/TidalEllipse';
[a,b]=mkdir (dirMouillage);

NbNiv=3;
c_e=[':r';':b';':k';':m';':c';':g'];
c_f=['r';'b';'k';'m';'c';'g'];
c_e=['r';'b';'k';'m';'c';'g'];
x0=0;y0=0;

clf,

for i = 1:size(Nom,1);
  DonneesCampagne(Nom(i,:));
  load(MouillageAnalyse)
  %subplot(2,2,i),
  for niv = floor(linspace(1,size(HarmoniqueU,2),NbNiv));
    HarmU=HarmoniqueU(niv);
    HarmV=HarmoniqueV(niv);
    figure(i),clf,hold on
    tid_ell
    fichM=[num2str(fichMouillage) num2str(char(cellstr(Nom(i,:))))  ...
      '_Niv' num2str(niv)];
    saveas(gcf,fichM,'fig')
    saveas(gcf,fichM,'png')
  end
end
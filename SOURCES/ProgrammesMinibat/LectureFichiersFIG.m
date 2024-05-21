clear Fich
Fich=[];
DossierFIG='Dessins/TransectsTheoriques';
Dir=dir(DossierFIG);
for i=1:size(Dir,1)
    if (size(Dir(i).name,2)>4)
        if((Dir(i).name(end-3:end))=='.fig')
            Fich=[DossierFIG '/' Dir(i).name];
            open(Fich)
            orient tall
            saveas(gcf,Fich,'png')
            close all
        end
    end
end
 
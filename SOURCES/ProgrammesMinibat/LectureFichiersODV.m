clear Fich
Fich=[];
Dir=dir(DossierODV);
for i=1:size(Dir,1)
    if (size(Dir(i).name,2)>4)
        if((Dir(i).name(end-3:end))=='.txt')
            Fich=[Fich;{Dir(i).name}];
        end
    end
end
 
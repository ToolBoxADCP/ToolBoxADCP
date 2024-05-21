automatique=1;
for i = 1:size(Nom,1);
    Nom(i,:);DonneesCampagne(Nom(i,:))
    load(MouillagePropre)
    Nmax(i)=MaxProf(Nom(i,:));
end

if(automatique==2);
for m=1:max(Nmax)
    DSPfondMouillages
    DSPfondMouillages_proj
end
end

if(automatique==1);
NivMax=3
for niv=1:NivMax
    NbNiv=(niv-1)/(NivMax-1)
    DSPfondMouillages
    DSPfondMouillages_proj
end
end

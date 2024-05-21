function [Mouil]=CalculVitMouillage(Vit)

    c_M.u=ones(size(Vit.u));
    c_M.u(:,2:2:end-2)=zeros(size(c_M.u(:,2:2:end-2)));
    c_M.v=ones(size(Vit.v));
    c_M.v(:,2:2:end-2)=zeros(size(c_M.v(:,2:2:end-2)));
    
    Mouil.u=sum(Vit.u.*c_M.u,2);
    Mouil.v=sum(Vit.v.*c_M.v,2);

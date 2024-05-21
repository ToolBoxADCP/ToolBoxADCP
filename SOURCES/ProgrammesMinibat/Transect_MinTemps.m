T_Heure_ 
t_=t(1,:);
    tM=ones(size(T_Heure_,2),1)*t_;
    T_HeureM=T_Heure_'*ones(1,size(t_,2));
    tt=(sqrt((tM-T_HeureM).^2);
[Tmin,I]=nanmin(tt',[],1);

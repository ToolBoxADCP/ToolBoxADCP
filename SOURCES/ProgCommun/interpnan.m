function vecteur=interpnan(X);
t=1:length(X);t=t';
A=isnan(X);
if (sum(A)~=0),
    a=num2str(sum(A));
    disp(['interpolation de ' a ' valeurs pour le periodogramme']) 
    disp('source possible d erreur')
    disp('� v�rifier')
    disp('  ')
    disp('  ')
end
i=find(A==0);xp=X(i);tp=t(i);
if(i(1)~=1)
    xp=[X(i(1));xp];tp=[t(1);tp];
end
if(tp(end)~=t(end))
    xp=[xp;X(i(end))];tp=[tp;t(end)];
end
vecteur=interp1(tp,xp,t);
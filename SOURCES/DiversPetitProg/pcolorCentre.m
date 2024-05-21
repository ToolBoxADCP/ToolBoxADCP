function pcolorCentre(X,Y,Z)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    X_=[X(:,1:end-1)-diff(X')'/2 X(:,end-1:end)+diff(X(:,end-2:end,:)')'/2];
        X_=[X_;X_(end,:)+diff(X_(end-1:end,:))];
    Y_=[Y(1:end-1,:)-diff(Y)/2;Y(end-1:end,:)+diff(Y(end-2:end,:))/2];
        Y_=[Y_ Y_(:,end)+diff(Y_(:,end-1:end)')'];
    Z_=[Z ;Z(end,:)];Z_=[Z_ Z_(:,end)];
    pcolor(X_,Y_,Z_)
end


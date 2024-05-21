function r=Correlation(X,Y);

%% Correlation :
ii=find(isnan(X)==0&isnan(Y)==0);
X=X(ii);Y=Y(ii);
Xm=nanmean(X);Ym=nanmean(Y);
r=nansum((X-Xm).*(Y-Ym))/sqrt((nansum((X-Xm).^2))*(nansum((Y-Ym).^2)));
mean(abs(X-Y));

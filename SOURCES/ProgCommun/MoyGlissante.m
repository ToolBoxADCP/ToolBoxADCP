function [Umoy,Umoy_]=MoyGlissante(time1,Vit,...
                                    DT_MoyGlissante,BolFig);

%DT_MoyGlissante=0;
DT=floor(DT_MoyGlissante/min(diff(time1)));
if(DT_MoyGlissante~=0&(size(Vit,1)-DT)>=1)
  Umoy_=[];
  Temps_=[];
  for ii=1:size(Vit,1)-DT;
    Umoy_(ii)=nanmean(Vit(ii:ii+DT));
    Temps_(ii)=nanmean(time1(ii:ii+DT));
  end
  Umoy=interp1(Temps_,Umoy_,time1);
  ii=find(isnan(Umoy)==1);
di=diff(ii);i0=1;i1=max(find(di>1)+1);
Umoy(ii(i0:i1-1))=Umoy(ii(i1-1)+1);
Umoy(ii(i1:end))=Umoy(ii(i1)-1);

  if(BolFig==1)
     figure, plot(time1,Vit),hold on
     plot(time1,Umoy,'r')
  end
else
   Umoy=0;
end
Umoy_=Vit-Umoy;

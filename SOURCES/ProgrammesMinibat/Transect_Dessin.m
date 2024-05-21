            clf
            subplot(2,1,1),pcolor(d0,z0,Param),shading flat,colorbar
                        axis([min(D0) max(D0) min(Z0_(1,:)) max(Z0_(1,:))])
                        box on
                        xlabel('Distance')
                        ylabel('Profondeur')
            subplot(4,1,3),[Tm,ii]=min((T));
                        plot(D0,(T-floor(T(ii)))*24),colorbar
                        axis([min(D0) max(D0) min((T-floor(T(ii)))*24) max((T-floor(T(ii)))*24)])
                        box on
                        xlabel('Distance')
                        ylabel('Temps')
         if(strcmp(Campagne,'OLZO')==1);
            subplot(4,1,4),Hm=interp1(TMaree,HauteurMaree,T);
                        plot(D0,Hm),colorbar
                        axis([min(D0) max(D0) min(Hm) max(Hm)])
                        box on
                        xlabel('Distance')
                        ylabel('Hauteur')
         end
                        
            
            

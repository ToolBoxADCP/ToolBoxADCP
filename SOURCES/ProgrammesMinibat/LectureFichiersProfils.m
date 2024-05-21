    clear PositionFichier
    temp=importdata(FichPosition);

   
    nom=temp.textdata(:,:);
    ii=[];
    for ind=1:size(nom,1)  
       if (isequal(nom(ind),{''})==0)
           ii=[ii;ind];
       end
    end
    PositionFichier.Nom=temp.textdata(ii,:);
    PositionFichier.Lon=temp.data(ii,2);
    PositionFichier.Lat=temp.data(ii,1);
 
    
%  clear Fich
%  dir=ls (Dossier);
% p_f=[];
% for i=1:size(dir,2)-3
%     if((dir(i:i+3))=='.csv')
%         p_f=[p_f i];
%     end
% end
% Fich(1)={[dir(1:p_f(1)) 'csv']};
% 
% for i=1:size(p_f,2)-1
%     fich=[dir(p_f(i)+5:p_f(i+1)) 'csv'];
%     p_d=0;
%     for ind=1:size(fich,2)
%         if(fich(ind)==' ')
%             p_d=p_d+1;
%         end
%     end
%         
%    Fich(i+1)={[dir(p_f(i)+5+p_d:p_f(i+1)) 'csv']}
% end

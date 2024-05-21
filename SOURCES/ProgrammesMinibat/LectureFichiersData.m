 clear Fich
%  Dir=ls (DossierData);
% p_f=[];
% for i=1:size(Dir,2)-3
%     if((Dir(i:i+3))=='.csv')
%         p_f=[p_f i];
%     end
% end
% Fich(1)={[Dir(1:p_f(1)) 'csv']};
% 
% for i=1:size(p_f,2)-1
%     fich=[Dir(p_f(i)+5:p_f(i+1)) 'csv'];
%     p_d=0;
%     for ind=1:size(fich,2)
%         if(fich(ind)==' ')
%             p_d=p_d+1;
%         end
%     end
%         
%    Fich(i+1)={[Dir(p_f(i)+5+p_d:p_f(i+1)) 'csv']};
% end
Fich=[];
Dir=dir(DossierData);
for i=1:size(Dir,1)
    if (size(Dir(i).name,2)>4)
        if((Dir(i).name(end-3:end))=='.csv')
            Fich=[Fich;{Dir(i).name}];
        end
    end
end

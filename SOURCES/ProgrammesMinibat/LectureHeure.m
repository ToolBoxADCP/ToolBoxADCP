clear Temps temps T
%     for ind=1:size(Text,1)
%         text=cell2mat(Text(ind,1));
%         p_=[];
%         for i=1:size(text,2)
%             if(text(i)==',')
%                 text(i)='.';
%             end
%         end
if date==1
    T=datenum(Text(:,1),'dd/mm/yyyy')+datenum(Text)-floor(datenum(Text));
else
    T=datenum(Text(:,1),'mm/dd/yyyy')+datenum(Text)-floor(datenum(Text));
end
if (strcmp(Campagne,'Cozomed1')==1)
    if (str2num(datestr(T,'dd'))>5)
        DecalGMT=0;
    else
        DecalGMT=0;
    end
end
       T=T-DecalGMT/24;
        
        % Extraction des valeurs abérrantes
       ind=1:size(T,1);ind=ind';
       if(size(T,1)>=2)
          ii=find(diff(T)>0);ii=ii+1;
          clf,plot(T-T0,'.b'),hold on,plot(ii,T(ii)-T0,'*r')
       T=interp1(ii,T(ii),ind,'linear','extrap');
       end
       plot(T-T0,'.k')
       
       clf
    % Extraction des valeurs abérrantes en temps
    if ConstanteDiffTemps == 1
            [T,I]=sort(T); 
            iiEnd=[0 0];
            while (size(iiEnd,1)~=0)
                 dt=mean(abs(diff(T)));
                 ii=find(abs(diff(T))<=dt+epsilon);ii=[ii;size(T,1)];
                 T=interp1(ind(ii),T(ii),ind);
                 iiEnd=find(diff(T)>dt+epsilon);
             end
             subplot(2,1,1),plot((T-T(1))*24)
             subplot(2,1,2),plot(diff(ii))
    %         pause
    %         clf
    
    % ATTENTION NE PAS OUBLIER DE REMETTRE LES DONN2ES DANS LE MEME ORDRE
    % QUE LE TEMPS
    Data=Data(I,:);
    end
    
        
    % Extraction des valeurs abérrantes
    temps.year=str2num(datestr(T,'yyyy'));
    temps.month=str2num(datestr(T,'mm'));
    temps.day=str2num(datestr(T,'dd'));
    temps.hour=str2num(datestr(T,'HH'));
    temps.minute=str2num(datestr(T,'MM'));
    temps.seconde=str2num(datestr(T,'SS'));
%     end
    



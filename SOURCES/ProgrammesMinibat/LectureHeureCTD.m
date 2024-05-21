clear Temps temps T
for ind=1:size(Text,1)
       T(ind)=datenum([cell2mat(Text(ind,1)) ' ' cell2mat(Text(ind,2))]...
           ,'dd/mm/yyyy HH:MM:SS');
end
T=T-DecalGMT/24;

% Extraction des valeurs abérrantes
ind=1:size(T,2);ind=ind';
ii=find(diff(T)==0);ii=[1 ii];
    jj=find(diff(ii)>1);jj0=[1 jj+1];jj=[jj size(ii,2)-1];
    T(ii(jj)+1)=T(ii(jj0))+5/60/24;
ii=find(diff(T)==0);    T(ii+1)=NaN;
ii=find(isnan(T)==0);  T=interp1(ii,T(ii),ind,'linear','extrap');
ii=find(diff(T)>0);ii=ii+1;
clf,plot(T-T0,'.b'),hold on,plot(ii,T(ii)-T0,'*r')
T=interp1(ii,T(ii),ind,'linear','extrap');
plot(T-T0,'.k')
        
% Enregistrement
temps.year=str2num(datestr(T,'yyyy'));
temps.month=str2num(datestr(T,'mm'));
temps.day=str2num(datestr(T,'dd'));
temps.hour=str2num(datestr(T,'HH'));
temps.minute=str2num(datestr(T,'MM'));
temps.seconde=str2num(datestr(T,'SS'));
    
    
T_=T;
T_Heure=(T_-floor(T_(1)))*24;



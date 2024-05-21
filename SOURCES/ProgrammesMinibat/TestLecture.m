 %Fich='Test.txt'  %indiquer le fichier à lire
 
 nc=fopen(Fich);c=textscan(nc,'%s','delimiter','$');
 aa=c{1};
 Conserve=[];indVal=0;
             Lat=[];
             Lon=[];
             Heure=[];
             Minute=[];
             Seconde=[];

 for ind=1:size(aa,1)
     text=cell2mat(aa(ind));
     if(size(text,2)>=5)
         if(text(1:5)=='GPGLL')
             indVal=indVal+1;
             Conserve=[Conserve;aa(ind)];
             Lat(indVal)=NaN;
             Lon(indVal)=NaN;
             Heure(indVal)=NaN;
             Minute(indVal)=NaN;
             Seconde(indVal)=NaN;
             ip=0;
             if(size(text,2)>=15)
                 if(isnumeric(str2num(text(7:8)))==1 ...
                         & isnumeric(str2num(text(9:15)))==1)
                 if(isempty(str2num(text(7:8)))==0 ...
                         & isempty(str2num(text(9:15)))==0....
                    & size(str2num(text(7:8)),1)==1 ....
                         & size(str2num(text(9:15)),1)==1 ...
                    & size(str2num(text(7:8)),2)==1 ....
                         & size(str2num(text(9:15)),2)==1)
                        Lat(indVal)=str2num(text(7:8))+str2num(text(9:15))/60;
                        if(text(15)==',')
                            ip=ip-1;
                        end
                 end
                 end
             end
             if(size(text,2)>=28+ip)
                 if(isnumeric(str2num(text(20+ip:21+ip)))==1 ...
                         & isnumeric(str2num(text(22+ip:28+ip)))==1)
                 if(isempty(str2num(text(20+ip:21+ip)))==0 ...
                    & isempty(str2num(text(22+ip:28+ip)))==0 ....
                    & size(str2num(text(20+ip:21+ip)),1)==1 ....
                       & size(str2num(text(22+ip:28+ip)),1)==1 ...
                    & size(str2num(text(20+ip:21+ip)),2)==1 ....
                       & size(str2num(text(22+ip:28+ip)),2)==1)
                       Lon(indVal)=str2num(text(20+ip:21+ip))+...
                                      str2num(text(22+ip:28+ip))/60;
                        if(text(28+ip)==',')
                            ip=ip-1;
                        end
                 end
                 end
             end
             if(size(text,2)>=33+ip)
                        if(text(32+ip)==',')
                            indVal;
                            ip=ip+1;
                        end
                 if(isnumeric(str2num(text(32+ip:33+ip)))==1)
                 if(isempty(str2num(text(32+ip:33+ip)))==0 ....
                         & size(str2num(text(32+ip:33+ip)),1)==1 ...
                         & size(str2num(text(32+ip:33+ip)),2)==1)
                    Heure(indVal)=str2num(text(32+ip:33+ip));
                 end
                 end
             end
             if(size(text,2)>=35+ip)
                 if(isnumeric(str2num(text(34+ip:35+ip)))==1)
                 if(isempty(str2num(text(34+ip:35+ip)))==0 ....
                         & size(str2num(text(34+ip:35+ip)),1)==1 ...
                         & size(str2num(text(34+ip:35+ip)),2)==1)
                    Minute(indVal)=str2num(text(34+ip:35+ip));
                 end
                 end
             end
             if(size(text,2)>=37+ip)
                 if(isnumeric(str2num(text(36+ip:37+ip)))==1)
                 if(isempty(str2num(text(36+ip:37+ip)))==0....
                         & size(str2num(text(36+ip:37+ip)),1)==1 ...
                         & size(str2num(text(36+ip:37+ip)),2)==1)
                    %text(36+ip:37+ip)
                    Seconde(indVal)=str2num(text(36+ip:37+ip));                 
                 end
                 end
             end
         end
     end
 end
 T=Heure+Minute/60+Seconde/3600;
 
 save TempLatLonT Lat Lon T Annee Mois Jour Heure Minute Seconde 
 
     
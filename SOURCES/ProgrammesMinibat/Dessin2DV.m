Taille=5;    
if size(find(isnan(Parametre)==0),1)>=2
  disp('Echelle de Parametre :')
     Smin=min(Parametre);Smax=max(Parametre);
    disp(['Smin (bleu) :', num2str(Smin)])
    disp(['Smax (rouge) :',num2str(Smax)])
    %Col=linspace(Smax,Smin,11);Col=Col(2:end);
    Col=linspace(1,0,11);Col=Col(1:end-1)+mean(diff(Col))/2;Col_=Col;
     [P_,I]=sort(Parametre);     P_=P_(isnan(P_)==0);
     N=size(P_,1);iCol=max(floor(Col*N),1);Col=P_(iCol);
     
    ii=find(Parametre>Col(1));R=0;
    clf,plot(T_Heure(ii),-Pression(ii),'.k','MarkerSize',Taille,'Color',[1 0 R])
    ii=find(Parametre<=Col(1) & Parametre>Col(2));R=0.1;
    hold on,plot(T_Heure(ii),-Pression(ii),'.b','MarkerSize',Taille,'Color',[1-R 0 R])
    ii=find(Parametre<=Col(2) & Parametre>Col(3));R=0.2;
    hold on,plot(T_Heure(ii),-Pression(ii),'.c','MarkerSize',Taille,'Color',[1-R 0 R])
    ii=find(Parametre<=Col(3) & Parametre>Col(4));R=0.3;
    hold on,plot(T_Heure(ii),-Pression(ii),'.m','MarkerSize',Taille,'Color',[1-R 0 R])
    ii=find(Parametre<=Col(4) & Parametre>Col(5));R=0.4;
    hold on,plot(T_Heure(ii),-Pression(ii),'.r','MarkerSize',Taille,'Color',[1-R 0 R])
    ii=find(Parametre<=Col(5) & Parametre>Col(6));R=0.5;
    hold on,plot(T_Heure(ii),-Pression(ii),'.b','MarkerSize',Taille,'Color',[1-R 0 R])
    ii=find(Parametre<=Col(6) & Parametre>Col(7));R=0.6;
    hold on,plot(T_Heure(ii),-Pression(ii),'.c','MarkerSize',Taille,'Color',[1-R 0 R])
    ii=find(Parametre<=Col(7) & Parametre>Col(8));R=0.7;
    hold on,plot(T_Heure(ii),-Pression(ii),'.m','MarkerSize',Taille,'Color',[1-R 0 R])
    ii=find(Parametre<=Col(8) & Parametre>Col(9));R=0.8;
    hold on,plot(T_Heure(ii),-Pression(ii),'.r','MarkerSize',Taille,'Color',[1-R 0 R])
    ii=find(Parametre<=Col(9) & Parametre>Col(10));R=0.9;
    hold on,plot(T_Heure(ii),-Pression(ii),'.r','MarkerSize',Taille,'Color',[1-R 0 R])
    ii=find(Parametre<=Col(10));R=1;
    hold on,plot(T_Heure(ii),-Pression(ii),'.r','MarkerSize',Taille,'Color',[1-R 0 R])
    
    legend(['>' num2str(Col(1))],...
           ['>' num2str(Col(2))], ...
           ['>' num2str(Col(3))], ...
           ['>' num2str(Col(4))], ...
           ['>' num2str(Col(5))], ...
           ['>' num2str(Col(6))], ...
           ['>' num2str(Col(7))], ...
           ['>' num2str(Col(8))], ...
           ['>' num2str(Col(9))], ...
           ['>' num2str(Col(10))], ...
           ['<' num2str(Col(10))], ...
          'location','EastOutside')
        
    title([NomDossier ' le ' Jour])
end
    xlabel('Heure')
    ylabel('Profondeur')


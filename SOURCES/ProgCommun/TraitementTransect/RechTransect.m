%% Recherche des transects
%Interaction avec l'utilisateur


 Itrans=[1];
 figure(1),hold on,plot(t_ADCP,ADCP_T(Tronc).long,'*g')
 %clear ADCPpr ADCP Temps vitesse depth
 nbTrans=0;
 for i=2:length(ADCPpr_T(Tronc).long)-1;
   figure(3),hold on,plot(GPSth(Tronc).dpas,nbTrans*ones(size(GPSth(Tronc).dpas)),'.-m')
   if(sign(ADCPpr_T(Tronc).dp(i)-ADCPpr_T(Tronc).dp(i-1))==sign(ADCPpr_T(Tronc).dp(i+1)-ADCPpr_T(Tronc).dp(i)))
     figure(2),plot(ADCP_T(Tronc).long(i),-ADCP_T(Tronc).lat(i),'+k','LineWidth',2)
     figure(3),plot(ADCPpr_T(Tronc).dp(i),nbTrans,'ok','LineWidth',2)
   else
    figure(2),plot(ADCP_T(Tronc).long(i),-ADCP_T(Tronc).lat(i),'+b','LineWidth',3)
    figure(3),plot(ADCPpr_T(Tronc).dp(i),nbTrans,'ob','LineWidth',4)
     if(Reponse==1)
         reply=RepFich(iReponse);
         if(reply==1),reply='Y';end
         if(reply==0),reply='N';end
         iReponse=iReponse+1;
         %if(iReponse>21),pause,end
     else
         reply = input('Fin de transect ? Y/N [Y]: ', 's');
%      if isempty(reply)
%         reply = 'Y';
%      end
     end
     if (reply=='Y')
         Itrans=[Itrans;i];nbTrans=nbTrans+1;disp('nb transect='),nbTrans
         figure(2),plot(ADCP_T(Tronc).long(i),-ADCP_T(Tronc).lat(i),'+m','LineWidth',3)
         figure(3),plot(ADCPpr_T(Tronc).dp(i),nbTrans,'or','LineWidth',4)
         clf,
         figure(3),hold on,plot(GPSth(Tronc).dpas,nbTrans*ones(size(GPSth(Tronc).dpas)),'.-m')
     end
   end 
 end
 Itrans=[Itrans;length(ADCPpr_T(Tronc).long)];
 nbTrans=nbTrans+1;disp('Nombre transects='),nbTrans
 
 dItrans=Itrans(2:end)-Itrans(1:end-1);

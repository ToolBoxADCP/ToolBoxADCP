%% Explication :
% --------------
% Un hodographe pour chaque jour de pr�l�vement, si le fichier existe
% Sinon, entre Tmin et Tmax, tous les DT jours

% Figure 1 : hodographe integre durant DT jour
% Figure 2 : hodographe integre avec 1 point chaque jour durant DT jour 
% Figure 3 : Pr�sentation des vitesse et de leur interpolation 
%            lorsque les valeurs sont NaN
%=================================================================
% Attention les vitesses doivent être en m/s et non plus en mm/s
%=================================================================
hodo_loc
dLat=1000;
dLong=1000;

if ((~exist('dLat','var')) || (~exist('dLong','var')))
    dLat=110000;
    dLong=110000;
end
dir='./DessinRobert/HodoInt';[a,b]=mkdir (dir);
fich1='./DessinRobert/HodoInt/temps_';
fich2='./DessinRobert/HodoInt/jour_';
close all
if(strcmp(Campagne,'Tulear1') || strcmp(Campagne,'Tulear2') || strcmp(Campagne,'Tulear3'))
  load DatePrelev.txt;
  decalTemps=((-3)+[3;3;0;1.5])/24;
    ii=find(DatePrelev(:,4)==0);DatePrelev(ii,4)=8;
  t_Prelev=datum(DatePrelev(:,3),DatePrelev(:,1),DatePrelev(:,2),...
    DatePrelev(:,4),DatePrelev(:,5),0*DatePrelev(:,1));
end


close all,

if(strcmp(Campagne,'Tulear1') || strcmp(Campagne,'Tulear2') || strcmp(Campagne,'Tulear3'))
  ti_Prelev=t_Prelev(1:end-1);tp_Prelev=t_Prelev(2:end);
  ind_min=max(1,find(ti_Prelev<tmin&tp_Prelev>tmin)+1) 
  if(isempty(ind_min)),ind_min=1,end
%ind_min=find(ti_Prelev<tmin&tp_Prelev>tmin) 
  ind_max=min(size(t_Prelev,1),find(ti_Prelev<tmax&tp_Prelev>tmax))
  if(isempty(ind_max)),ind_max=size(t_Prelev,1),end
end

       

for ind=ind_min:ind_max-1 
%   if(~isempty(Photo))
%     figure(1),image(Ylong,Xlat,Photo)
%     figure(2),image(Ylong,Xlat,Photo)
%   end

  for i = 1:size(Nom,1);
    Fig=2*(i-1);
    figure(Fig+1),clf,axis('equal'),axis xy,hold on
    figure(Fig+2),clf,axis('equal'),axis xy,hold on
    Nom(i,:);DonneesCampagne(Nom(i,:))
    load(MouillagePropre)
    N=MaxProf(Nom(i,:));
    time1=datum_str(Temps);
    
%% Selection des vitesses DT(=une semaine) avant chaque prelevement:
    ii=find(time1<=t_Prelev(ind)+decalTemps(i) & time1>=t_Prelev(ind)+decalTemps(i)-DT);
    if(isempty(ii)==0 & ii(end)<size(time1,1))
        ind_coul=1;
        for h=floor(linspace(1,N,3));
          vit.u=vitesse.u(ii,h);
          vit.v=vitesse.v(ii,h);
          t=time1(ii)-time1(ii(1));
%           HodoInv(vit,t,...
%               PositionMouillage.long,PositionMouillage.lat,...
%               time1(ii(1)),ind_coul,dLat,dLong)
          hodo(vit,t,...
              PositionMouillage.long,PositionMouillage.lat,...
              time1(ii(1)),ind_coul,dLat,dLong,Fig,DTexpr)
        ind_coul=ind_coul+1;
      end
    end
    figure(Fig+1)
      axis equal
      xlabel('Vers l Est')
      ylabel('Vers le Nord')
      Titre=[cellstr('Hodographe integre a chaque pas de temps'),...
          cellstr(['au mouillage : ' Nom(i,:)]),...
          cellstr(['à la date : ' datestr(t_Prelev(ind),2)])];
      title(Titre)
      Fichier=[fich1 nom '_Jour_',num2str(ind)];
          saveas(gcf,Fichier,'fig')
          saveas(gcf,Fichier,'png')
          
     figure(Fig+2)
      axis equal
      xlabel('vers l Est')
      ylabel('vers le Nord')
      Titre=[cellstr(['Hodographe integre chaque ' num2str(DTexpr) ' jour(s)']),...
          cellstr(['au mouillage : ' Nom(i,:)]),...
          cellstr(['à la date : '  datestr(t_Prelev(ind),2)])];
      title(Titre)
      Fichier=[fich2 nom '_Jour_',num2str(ind)];
          saveas(gcf,Fichier,'fig')
          saveas(gcf,Fichier,'png')
      
   
  end
  datestr(t_Prelev(ind),0)
  'Appuyer sur une touche ...'
  %pause

      
end


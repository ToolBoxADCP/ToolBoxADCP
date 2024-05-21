function BarrePrelev(Tmes,T_fin,Nom);

Prelev=0;
if(Prelev)
fich=['DatePrelev' Nom  '.txt'];
DatePrelev=load (fich);
Limites=axis;hold on,
%% Recherche des jours de chaque prélèvement pour le mois étudié
t_Prelev=datum(DatePrelev(:,3)-2000,DatePrelev(:,2),DatePrelev(:,1),...
    DatePrelev(:,4),DatePrelev(:,5),0*DatePrelev(:,1))-Tmes;

idate=find(t_Prelev<T_fin & t_Prelev>1);,t_Prelev(idate);
if(isempty(idate)==0)
   for ind_date=1:size(idate,1); 
%      plot([t_Prelev(idate(ind_date)) t_Prelev(idate(ind_date))],[Zmin-(Zmax-Zmin)/3 Zmax+(Zmax-Zmin)/3],'-.c')
      plot([t_Prelev(idate(ind_date)) t_Prelev(idate(ind_date))],[Limites(3) Limites(4)],'-.c')
      t_Prelev(idate(ind_date));
   end
end
end

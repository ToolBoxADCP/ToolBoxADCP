for i = 1:size(Nom,1);
  Nom(i,:);DonneesCampagne(Nom(i,:))
  load(MouillageMoy)
    time1=datum_str(Temps);

    u=VitMoy_proj.u;
    v=VitMoy_proj.v;
 
    u_maree=VitesseCalculeeAvecHarmonique(NbOndes,HarmoniqueMoyU_proj,...
        (datum_str(Temps)-T0)*24,T0);
    v_maree=VitesseCalculeeAvecHarmonique(NbOndes,HarmoniqueMoyV_proj,...
        (datum_str(Temps)-T0)*24,T0);

    Harm=HarmoniqueMoyU_proj;vit=VitMoy_proj.u;
    u_moy=interp1(Harm.temps,Harm.MoyGliss,(time1-T0)*24);
    Harm=HarmoniqueMoyV_proj;vit=VitMoy_proj.v;
    v_moy=interp1(Harm.temps,Harm.MoyGliss,(time1-T0)*24);

    
    plot(time1-T0,u,time1-T0,u_maree,time1-T0,u_moy)
    ii=find(isnan(u_moy)==0&isnan(u)==0);
    Nom(i,:)
%     [sqrt(nanmean(u.^2))...
%         sqrt(nanmean((u-u_moy).^2))/sqrt(nanmean(u-u.^2))*100  ...
%         sqrt(nanmean((u_maree).^2))/sqrt(nanmean(u.^2))*100. ...
%         sqrt(nanmean((u_moy).^2))/sqrt(nanmean(u.^2))*100]
    [sqrt(nanmean(u.^2))...
       sqrt(nanmean((u_maree).^2))/sqrt(nanmean(u.^2))*100. ...
       sqrt(nanmean((u_maree).^2))/sqrt(nanmean((u-u_moy).^2))*100. ...
       sqrt(nanmean((u_moy).^2))/sqrt(nanmean(u.^2))*100]
%    [cov(u(ii)) cov(u_maree(ii)) cov(u_moy(ii))]
%    [cov(u_maree(ii))/cov(u(ii))*100....
%        cov(u_moy(ii))/cov(u(ii))*100]   
%     [cov(u_maree(ii))/cov(u(ii)-u_moy(ii))*100....
%         cov(u_moy(ii))/cov(u(ii))*100]   
end
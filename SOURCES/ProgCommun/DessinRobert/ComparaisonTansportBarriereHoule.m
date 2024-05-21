fichierGlobal='Houle_Flux';
fichierGlobal_inst='Houle_Flux_inst';

DT_MoyGlissante=1;
T_init=T0;
T_2000=datenum(1999,12,31)
T0_houle=T0+datenum(1999,12,31);
%T0_houle=0;

figure(1),clf,hold on, 
FormatTrait=['  k';'  c';'  r';'  b'];
FormatTrait2=[':k';':c';':r';':b'];

% Pas Modification pas teste. C'etait avant ce qui est à present commenté.
for i = 1:size(Nom,1);
    % Recupération Données :
    DonneesCampagne(Nom(i,:));
    load(MouillagePropre_proj);Niv=P.depth;
    load(MouillageMoy);
        Fl=Niv.*VitMoy_proj.u;
        Fl2=Niv(1:end-1).*HarmoniqueMoyU_proj.res;
    temps=datum_str(Temps)-T_init;
    temps2=HarmoniqueMoyU_proj.temps/24;
    [MoyGliss(:,i),Fl_]=MoyGlissante(temps,Fl,DT_MoyGlissante,0);
    [MoyGliss_u(:,i),Vit_]=MoyGlissante(temps,VitMoy_proj.u,DT_MoyGlissante,0);
    load ('Houle')
% save(FichierSauv,'T_Hs','Hs','T_Tp','Tp','T_T02','T02',...
%                  'T_Hs0','T_Hs0','T_Si0','Si0','T_Th0','Th0','T_Tp0','Tp0',...
%                  'T_Hs1','Hs1','T_Tp1','Tp1',...
%                  'T_Dir','Dir','T_Dp','Dp','T_Th0','Th0','T_Th1','Th1')

    
    % Dessins
    figure(1),plot(temps,MoyGliss(:,i),FormatTrait(i,:))
    nanmean(MoyGliss)
    plot(temps2,Fl2,FormatTrait2(i,:))
    plot(T_Hs-T0_houle,Hs*300,'r')
    plot(T_Hs-T0_houle,Hs0*300,'r')
    plot(T_Hs-T0_houle,Hs1*300,'r')
    
    % Mise sous un meme format des données:
    T=T_Hs-T0_houle;
    ii=find(T>min(temps)&T<max(temps));
    T=T(ii);
    Hs_=Hs(ii);Tp_=Tp(ii);
    Hs0_=Hs0(ii);Tp0_=Tp(ii);
    Hs1_=Hs1(ii);Tp1_=Tp(ii);
    
    MoyGliss_(:,i)=interp1(temps,MoyGliss(:,i),T);
    MoyGliss_u_(:,i)=interp1(temps,MoyGliss_u(:,i),T);
    Ures_=interp1(temps(1:end-1),HarmoniqueMoyU_proj.res,T);
    U_=interp1(temps,VitMoy_proj.u,T);
    Fl2_=interp1(temps(1:end-1),Fl2,T);
    
    plot(T,MoyGliss_)
    axis([min(T) max(T) -200 1500])
    
    %Dessin suppl
    figure,plot(Hs_,MoyGliss_/1000,'.b')
    hold on,
    %plot(Hs0_,MoyGliss_,'.r')
    %plot(Hs1_,MoyGliss_,'.c')
    ii=find(Tp_<7);plot(Hs_(ii),MoyGliss_(ii)/1000,'.r')
end

%% Impression
b='  ';
a=[];
for i_nom = 1:size(T,1);
   a=[a;b];
end

Impr=datestr(T+T0_houle); 
Entete=[b,' Jour',b];
for i_nom = 1:size(Nom,1);
    Entete=[Entete,b,b,b,'Vitesse (mm/s)',...
             b,' Transport (10-3 m2/s)',b,'Amplitude Hs',b,...
            'Amplitude Hs0',b,'Amplitude Hs1',b,'Periode Tp',b,b,...
            'Periode Tp0',b,b,'Periode Tp1'];
    Impr=[Impr,a,a,a,num2str(round(MoyGliss_u_(:,i_nom)*100)/100),...
          a,a,a,num2str(round(MoyGliss_(:,i_nom)*100)/100),...
          a,a,a,a,a,num2str(Hs_),...
          a,a,a,a,a,num2str(Hs0_),a,a,a,a,a,num2str(Hs1_),...
          a,a,a,a,a,num2str(Tp_),...
          a,a,a,a,num2str(Tp0_),a,a,a,a,num2str(Tp1_)];
end


fid1=fopen(fichierGlobal,'wt');
fprintf(fid1,'Transport Integr� sur la verticale en m2 /s \n ');
fprintf(fid1,' \n ');
fprintf(fid1,'%s \n',Entete);
fprintf(fid1,' \n');
for i=1:size(Impr,1);
   fprintf(fid1,'%s \n',Impr(i,:));
end
fclose(fid1);

Impr=datestr(T+T0_houle); 
Entete=[b,' Jour',b];
for i_nom = 1:size(Nom,1);
    Entete=[Entete,b,b,b,'Vitesse (mm/s)',...
             b,'Vitesse res (mm/s)',b,...
             ' Transport (10-3 m2/s)',b,'Amplitude Hs',b,...
             'Amplitude Hs0',b,'Amplitude Hs1',b,'Periode Tp',b,b,...
             'Periode Tp0',b,b,'Periode Tp1'];
    Impr=[Impr,a,a,a,num2str(round(U_(:,i_nom)*100)/100),...
          a,a,a,num2str(round(Ures_*100)/100),...
          a,a,a,num2str(round(Fl2_*100)/100),...
          a,a,a,a,a,num2str(Hs_),...
          a,a,a,a,a,num2str(Hs0_),a,a,a,a,a,num2str(Hs1_),...
          a,a,a,a,a,num2str(Tp_),...
          a,a,a,a,num2str(Tp0_),a,a,a,a,num2str(Tp1_)];
end


fid1=fopen(fichierGlobal_inst,'wt');
fprintf(fid1,'Transport Integr� sur la verticale en m2 /s \n ');
fprintf(fid1,' \n ');
fprintf(fid1,'%s \n',Entete);
fprintf(fid1,' \n');
for i=1:size(Impr,1);
   fprintf(fid1,'%s \n',Impr(i,:));
end
fclose(fid1);

DT_MoyGlissante=1;
T_init=T0;
figure(1),clf
figure(2),clf
FormatTrait=[' :c';'  k';'  k';'  b'];
FormatTrait2=[':k';':c';':r';':b'];

% Pas Modification pas teste. C'etait avant ce qui est à present commenté.
for i = 1:size(Nom,1);
    DonneesCampagne(Nom(i,:));
    load(MouillagePropre_proj);Niv=P.depth;
    load(MouillageMoy);
        Fl=Niv.*VitMoy_proj.u;
        Fl2=Niv(1:end-1).*HarmoniqueMoyU_proj.res;
    temps=datum_str(Temps)-T_init;
    temps2=HarmoniqueMoyU_proj.temps/24;
    [MoyGliss(:,i),Fl_]=MoyGlissante(temps,Fl,DT_MoyGlissante,0);
    figure(1),plot(temps,MoyGliss(:,i),FormatTrait(i,:))
    % D�calage en temps pour mettre les jours (5 10 15) en face du sticker.
    figure(2),plot(temps-1,MoyGliss(:,i),FormatTrait(i,:)) 
    nanmean(MoyGliss)
    figure(1),hold on, plot(temps2,Fl2,FormatTrait2(i,:))
    figure(2),hold on, plot(temps2,Fl2,FormatTrait2(i,:))
end

% DonneesCampagne('MS2')
% load(MouillagePropre_proj);Niv=P.depth;
% load(MouillageMoy);Fl=Niv.*VitMoy_proj.u;
% temps=datum_str(Temps)-T_init;
% [MoyGliss,Fl_]=MoyGlissante(temps,Fl,DT_MoyGlissante,0);
% figure(1),plot(temps,(MoyGliss),':c')
% % D�calage en temps pour mettre les jours (5 10 15) en face du sticker.
% figure(2),plot(temps+1,(MoyGliss),':c') 
% nanmean(MoyGliss)
% figure(1),hold on
% figure(2),hold on
% 
% DonneesCampagne('MS1')
% load(MouillagePropre_proj);Niv=P.depth;
% load(MouillageMoy);Fl=Niv.*VitMoy_proj.u;
% temps=datum_str(Temps)-T_init;
% [MoyGliss,Fl_]=MoyGlissante(temps,Fl,DT_MoyGlissante,0);
% figure(1),plot(temps,(MoyGliss),'k')
% % D�calage en temps pour mettre les jours (5 10 15) en face du sticker.
% figure(2),plot(temps+1,(MoyGliss),'k') 
% nanmean(MoyGliss)
% figure(1),hold on
% figure(2),hold on
% 
% DonneesCampagne('MN ')
% load(MouillagePropre_proj);Niv=P.depth;
% load(MouillageMoy);Fl=Niv.*VitMoy_proj.u;
% temps=datum_str(Temps)-T_init;
% [MoyGliss,Fl_]=MoyGlissante(temps,Fl,DT_MoyGlissante,0);
% MoyGliss=-MoyGliss;
% figure(1),plot(temps,(MoyGliss),':k')
% % D�calage en temps pour mettre les jours (5 10 15) en face du sticker.
% figure(2),plot(temps+1,(MoyGliss),':k') 
% nanmean(MoyGliss)
% figure(1),hold on
% figure(2),hold on
% 
% 

%% Impression
b='  ';
a=[];
for i_nom = 1:size(temps,1);
   a=[a;b];
end

Impr=datestr(datum_str(Temps)-T_init); 
Entete=[b,' Jour',b];
for i_nom = 1:size(Nom,1);
    Entete=[Entete,b,b,' Flux ',Nom(i_nom,:)];
    Impr=[Impr,a,num2str(round(MoyGliss(:,i_nom)*100)/100)];
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

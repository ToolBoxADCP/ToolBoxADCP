%% Tulear
%Nom=['MS2';'MS1';'MN ';'MC '];

if (strcmp(Campagne,'Tulear1')==1),

   nb_i=15;ech=500;
   echG_t=[6;6;6;2];
   fig=[1;1;2;2];
   NomFig=['MS2_MS1';'MN_MC  '];
   nfig=[1;2;1;2];

   DX=52;DY=10;
   Xmin=[-40;-40;-40;-40];Xmax=Xmin+DX;
   Ymin=[-5;-5;-5;-5];Ymax=Ymin+DY;
end

%% Mayotte
%Nom=['MS ';'MB ';'MN1';'MN2'];

if (strcmp(Campagne,'Mayotte1')==1),
   nb_i=30;DT=15*60; %seconde
   ech_t=[500;500;500;500];ech=500;
   echG_t=[6;2;6;6];
   fig=[1;1;2;2];
   NomFig=['MS_MB  ';'MN1_MN2'];
   nfig=[1;2;1;2];

   DX=13;DY=5;
   Xmin=[-2;-2;-2;-2];Xmax=Xmin+DX;
   Ymin=[0;0.5;0;0];Ymax=Ymin+DY;
end

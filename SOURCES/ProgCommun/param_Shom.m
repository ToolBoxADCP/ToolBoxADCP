% Fichier *.hdr
    % DateTime	: c1-->c6
    % Battery	: c9
    %
    % Heading	: c11
    % Pitch	:     c12
    % Roll	:     c13
    % Depth	:     c14
    % Temperature	: c15
    % AnalogIn1	: c16
    % AnalogIn2 : c17

    Mfile=[DonneesMouillage];
    D_Mouil=importdata(Mfile);

    if (~exist('t','var')); t=1:size(D_Mouil,1)-4;end
    if (size(t)==0); t=1:size(D_Mouil,1)-4;end

    Temps.year=1000+D_Mouil(t,1);
    Temps.day=D_Mouil(t,2);
    Temps.month=str2num(datestr(datenum(Temps.year,0,Temps.day),'mm'));
    
    Temps.hour=floor(D_Mouil(t,3)/60);
    Temps.minute=D_Mouil(t,3)-Temps.hour*60;
    Temps.seconde=0*D_Mouil(t,3);

    if (NomTemp=='Non   '); 
      temperature=0*D_Mouil(t,3);
    end
    if (FichPression=='Non  '); 
      depth=0*D_Mouil(t,3);plot(depth,'.')
    end
    
    vitesse.u=D_Mouil(t,4);
    vitesse.v=D_Mouil(t,5);
    
    echo=0*D_Mouil(t,3);



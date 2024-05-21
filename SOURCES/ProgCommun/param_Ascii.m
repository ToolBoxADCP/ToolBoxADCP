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

    Temps.year=D_Mouil(t,1);
    Temps.day=D_Mouil(t,2);
    Temps.month=datestr(datenum(Temps.year,0,Temps.day),'mm')
    Temps.hour=D_Mouil(t,4);
    Temps.minute=D_Mouil(t,5);
    Temps.seconde=D_Mouil(t,6);

    if (NomTemp=='AQP'); 
      temperature=D_Mouil(t,15);
    end
    if (FichPression=='ADCP '); 
      depth=D_Mouil(t,14);plot(depth,'.')
    end
    
    Mfile=[DonneesMouillage '.v1'];
    D_Mouil=load (Mfile);
    vitesse.u=D_Mouil(t,2:end)*1000;

    Mfile=[DonneesMouillage '.v2'];
    D_Mouil=load (Mfile);
    vitesse.v=D_Mouil(t,2:end)*1000;
    
    Mfile=[DonneesMouillage '.a1'];
    D_Mouil=load (Mfile);
    echo1=D_Mouil(t,2:end)*10;
    Mfile=[DonneesMouillage '.a2'];
    D_Mouil=load (Mfile);
    echo2=D_Mouil(t,2:end)*10;
    Mfile=[DonneesMouillage '.a3'];
    D_Mouil=load (Mfile);
    echo3=D_Mouil(t,2:end)*10;
    [M,N]=size(echo1);
    echo=reshape(mean([reshape(echo1,M*N,1),...
                       reshape(echo2,M*N,1),...
                       reshape(echo3,M*N,1)],2),M,N);



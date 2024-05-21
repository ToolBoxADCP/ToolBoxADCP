if (NomADCP=='ADI   ' | NomADCP=='RDI   ')
    param_RDI
elseif (NomADCP=='AQP   ')
    param_AQP
elseif (NomADCP=='Shom  ')
    param_Shom
elseif NomADCP=='SONTEK'
    Mfile=[DonneesMouillage '.hdr'];
    D_Mouil=load (Mfile);
    if (size(t)==0); t=1:size(D_Mouil,1);end

    Temps.year=D_Mouil(t,2);
    if (exist('ANNEE','var'));
      if (~isempty(ANNEE));
            Temps.year=ones(size(Temps.year))*ANNEE;
      end
    end
    Temps.month=D_Mouil(t,3);
    Temps.day=D_Mouil(t,4);
    Temps.hour=D_Mouil(t,5);
    Temps.minute=D_Mouil(t,6);
    Temps.seconde=D_Mouil(t,7);

    %Mfile=[MAYOT001 '.dir'];
    %load (Mfile)
    %SerDir10thDeg=10*MAYOT001(:,2:end);

    if (NomTemp(1:5)=='ADCP '); 
      temperature=D_Mouil(t,13);
    end
    if (FichPression(1:5)=='ADCP '); 
      depth=D_Mouil(t,9);plot(depth,'.')
    end
    
    Mfile=[DonneesMouillage '.ve'];
    D_Mouil=load (Mfile);
    vitesse.u=D_Mouil(t,2:end)*10;

    Mfile=[DonneesMouillage '.vn'];
    D_Mouil=load (Mfile);
    vitesse.v=D_Mouil(t,2:end)*10;
    
    if size(NomEcho,1)>0
        if (NomEcho=='ADCP '); 
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
    
        end
    end
%     Mfile=[DonneesMouillage '.sd1'];
%     D_Mouil=load (Mfile);
%     test=D_Mouil(t,2:end);valid=ones(size(test));
%     iiValid=find(test>2);
%     valid(iiValid)=NaN*valid(iiValid);
    
%     vitesse.u=vitesse.u.*valid;
%     vitesse.v=vitesse.v.*valid;
elseif NomADCP=='Antare'
    Mfile=[DonneesMouillage];
    D_Mouil=load (Mfile);
    if (size(t)==0); t=1:size(D_Mouil,1);end

    Temps.day=D_Mouil(t,2);
    Temps.month=D_Mouil(t,1);
    Temps.year=D_Mouil(t,3);
    Temps.hour=D_Mouil(t,4);
    Temps.minute=D_Mouil(t,5);
    Temps.seconde=D_Mouil(t,6);

    vitesse.u=D_Mouil(t,9);
    vitesse.v=D_Mouil(t,10);

    echo=mean(D_Mouil(t,12:14),2);
    depth=D_Mouil(t,22);plot(depth,'.')
    temperature=D_Mouil(t,23);
end;
if Temps.year(1) < 1000
    Temps.year=Temps.year+2000;
end



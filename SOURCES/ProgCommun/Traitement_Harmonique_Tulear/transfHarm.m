clear Harmonique

for iOndes=1:size(Ondes,1);
   nOnde=size(char(Ondes(iOndes)),2);
   iiOndes=find((strncmp(cellstr(tidestruc.name),Ondes(iOndes),nOnde)==1));
   if ~isempty(iiOndes)
       Harmonique.ampl(iOndes)=tidestruc.tidecon(iiOndes,1);
       Harmonique.phase(iOndes)=tidestruc.tidecon(iiOndes,3);
       Harmonique.Num(iOndes)=tidestruc.Num(iiOndes);
       Harmonique.omega(iOndes)=2*pi*tidestruc.freq(iiOndes);
       Harmonique.name(iOndes)=cellstr(tidestruc.name(iiOndes,:));
   end
end

Harmonique.lin(1)=tidestruc.Lin(1);
Harmonique.lin(2)=tidestruc.Lin(2);

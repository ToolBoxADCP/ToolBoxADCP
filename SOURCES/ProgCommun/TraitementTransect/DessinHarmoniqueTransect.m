clear Ampl_M2 Ampl_M2moy Phase_M2 Phase_M2moy                        
for Tronc=1:nbTronc;
  load(VitReconst(Tronc,:))
  load(HarmVitReconst(Tronc,:))
  N=size(Tr_reconst.z,2);    
  for  pas=1:1:size(Tr_reconst.dpas,2);
         for niv=1:N;
             if ~isempty(HarmReconstU(pas,niv).temps)
               Ampl_M2(pas,niv)=HarmReconstU(pas,niv).amplForeman(1);
               Phase_M2(pas,niv)=HarmReconstU(pas,niv).phaseForeman(1);
             else
               Ampl_M2(pas,niv)=NaN;
               Phase_M2(pas,niv)=NaN;
             end
         end
         if ~isempty(HarmReconstUmoy(pas).temps)
            Ampl_M2moy(pas)=HarmReconstUmoy(pas).amplForeman(1);
            Phase_M2moy(pas)=HarmReconstUmoy(pas).phaseForeman(1);
         else
            Ampl_M2moy(pas)=NaN;
            Phase_M2moy(pas)=NaN;
         end
      end
      figure(index_nom)
      subplot(2,1,1),plot(Tr_reconst.dpas,Ampl_M2moy,'k',...
                          Tr_reconst.dpas,Ampl_M2(:,1),'b')
      subplot(2,1,2),plot(Tr_reconst.dpas,Phase_M2moy,'k',...
                          Tr_reconst.dpas,Phase_M2(:,1),'b')
end


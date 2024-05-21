function [Ampl,Ph]=Ecri_Ampl(Harm,fid,reduc)

fprintf(fid,'Ondes: ');
for k =1:size(Harm.name,2),
        if(~isempty(cell2mat(Harm.name(k)))),
          A=(char(Harm.name(k)));
          fprintf(fid,'%c',A(:));
          fprintf(fid,'\t');
        end
end
%if (reduc==1)    
[Ampl,Ph]=ReducPhase(Harm.amplForeman,Harm.phaseForeman,...
        Harm.omega,fid);
%end

function [txt] = num2txt(var,N)
% var, la variable à convertir en texte
% N nombre de caractere demande ==> transforme 2 en 02, etc ...
    txt=num2str(var);
    while size(txt,2)<N
        txt=['0' txt];
    end
end


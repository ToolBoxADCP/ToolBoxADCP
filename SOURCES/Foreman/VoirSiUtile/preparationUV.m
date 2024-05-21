load f10093b.txt
res=f10093b;
Date=[datenum(res(:,1)+1900,1,res(:,2)) res(:,3)/60 sqrt(res(:,4).^2+res(:,5).^2)];
save M10093bUV Date -ascii

load f10094b.txt
res=f10094b;
Date=[datenum(res(:,1)+1900,1,res(:,2)) res(:,3)/60 sqrt(res(:,4).^2+res(:,5).^2)];
save M10094bUV Date -ascii

load f10095b.txt
res=f10095b;
Date=[datenum(res(:,1)+1900,1,res(:,2)) res(:,3)/60 sqrt(res(:,4).^2+res(:,5).^2)];
save M10095bUV Date -ascii

load f10096b.txt
res=f10096b;
Date=[datenum(res(:,1)+1900,1,res(:,2)) res(:,3)/60 sqrt(res(:,4).^2+res(:,5).^2)];
save M10096bUV Date -ascii

load f20294.txt
res=f20294;
Date=[datenum(res(:,1)+1900,1,res(:,2)) res(:,3)/60 sqrt(res(:,4).^2+res(:,5).^2)];
save M20294UV Date -ascii

load f20295.txt
res=f20295;
Date=[datenum(res(:,1)+1900,1,res(:,2)) res(:,3)/60 sqrt(res(:,4).^2+res(:,5).^2)];
save M20295UV Date -ascii

load f20296.txt
res=f20296;
Date=[datenum(res(:,1)+1900,1,res(:,2)) res(:,3)/60 sqrt(res(:,4).^2+res(:,5).^2)];
save M20296UV Date -ascii

load f20297.txt
res=f20297;
Date=[datenum(res(:,1)+1900,1,res(:,2)) res(:,3)/60 sqrt(res(:,4).^2+res(:,5).^2)];
save M20297UV Date -ascii
 
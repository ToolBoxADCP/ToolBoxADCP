function    Nmax=MaxProf(vitesse);
GlobaleVar  

Nmax=[];
if(ischar(vitesse) |  iscell(vitesse))
   nom=char(vitesse);
   fichier=[Dir 'BorneMouillage/NivMax_' nom];
   if(exist(fichier))
%    if(~isempty(ls(fichier)))
       Nmax=load(fichier);
   else
     load(MouillagePropre)
   end
end

if(isempty(Nmax))
   load(MouillagePropre)
   Nbmax_NaN=100;
   Nbmax_NaN=0.1*size(vitesse.u,1); % 10% de NaN
   N=size(vitesse.u,2);
   indice=zeros(size(vitesse.u));
   for i = 1:N;
       ii=(find(isnan(vitesse.u(:,i))==1));
       indice(ii,i)=ones(size(ii));
   end
   %figure,plot(ii,'.-')
   Nmax=max(find(sum(indice)<Nbmax_NaN));
end

GlobaleVar

var=cell2mat(varargin(1));
if(size(var,2)==1)
  if (var==['u'])
      var='uuu';
  elseif (var==['v'])
      var='vvv';
  elseif (var==['h'])
      var='hhh';
  end
end

if (var=='hhh')
  if (Nargin==1)
      tmin=1;
      tmax=NaN;
      ti=NaN;
  elseif (Nargin==2)
      tmin=1;
      tmax=NaN;
      ti=cell2mat(varargin(2));
  elseif (Nargin==3)
      tmin=cell2mat(varargin(2));
      tmax=cell2mat(varargin(3));
      ti=NaN;
  elseif (Nargin==4)
      tmin=cell2mat(varargin(2));
      tmax=cell2mat(varargin(3));
      ti=cell2mat(varargin(4));
  end
elseif (var=='uuu' | var=='vvv' | var=='Upr' | var=='Vpr' | var=='U_p' | var=='V_p')
    if (Nargin==1)
      i=1;    
      tmin=1;
      tmax=NaN;
      ti=NaN;
   elseif (Nargin==2)
      i=cell2mat(varargin(2)); 
      tmin=1;
      tmax=NaN;
      ti=NaN;
   elseif (Nargin==3)
      i=cell2mat(varargin(2));
      tmin=1;
      tmax=NaN;
      ti=cell2mat(varargin(3));
   elseif (Nargin==4)
      i=cell2mat(varargin(2));
      tmin=cell2mat(varargin(3));
      tmax=cell2mat(varargin(4));
      ti=NaN;
   elseif (Nargin==5)
      i=cell2mat(varargin(2));
      tmin=cell2mat(varargin(3));
      tmax=cell2mat(varargin(4));
      ti=cell2mat(varargin(5));
    end
end

  if (var==['uuu'])
    load (MouillagePropre)
    disp('vitesse sur u')
    S=vitesse.u(:,i);
    t=(datum_str(Temps)-T0)*24*3600;
  elseif (var==['vvv'])
    load (MouillagePropre)
    disp('vitesse sur v')
    S=vitesse.v(:,i);
    t=(datum_str(Temps)-T0)*24*3600;
  elseif (var==['hhh'])
    load (MouillagePropre)
    disp('vitesse sur h')
    S=P.depth(:,1);
    t=(datum_str(Temps)-T0)*24*3600;
  elseif(var==['Upr'])
    load (MouillageAnalyse)
    disp('vitesse sur Uproj')
    t=(datum_str(Temps)-T0)*24*3600;
    S=Projection.u(:,i);
  elseif (var==['Vpr'])
    load (MouillageAnalyse)
    disp('vitesse sur Vproj')
    t=(datum_str(Temps)-T0)*24*3600;
    S=Projection.v(:,i);
  elseif (var==['div'])
    disp('Divers')
    S=cell2mat(varargin(2));
    t=cell2mat(varargin(3));
    tmin=cell2mat(varargin(4));
    tmax=cell2mat(varargin(5));
    ti=cell2mat(varargin(6));
  elseif (var==['U_p'])
    load (MouillagePropre_proj)
    disp('vitesse sur u')
    S=vitesse.u(:,i);
    t=(datum_str(Temps)-T0)*24*3600;
  elseif (var==['V_p'])
    load (MouillagePropre_proj)
    disp('vitesse sur v')
    S=vitesse.v(:,i);
    t=(datum_str(Temps)-T0)*24*3600;
end


if(isnan(tmax)==0)
    S=S(tmin:tmax);t=t(tmin:tmax);
end
if(isnan(ti)==1)
   ti=t;
end

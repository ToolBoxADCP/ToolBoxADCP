function yout=t_predic(tim,varargin);
% T_PREDIC Tidal prediction
% YOUT=T_PREDIC(TIM,NAMES,FREQ,TIDECON) makes a tidal prediction
% using the output of T_TIDE at the specified times TIM in decimal 
% days (from DATENUM). Optional arguments can be specified using
% property/value pairs: 
%
%       YOUT=T_PREDIC(...,TIDECON,property,value,...)
%
% Available properties are:
%
%    In the simplest case, the tidal analysis was done without nodal
%    corrections, and thus neither will the prediction. If nodal 
%    corrections were used in the analysis, then it is likely we will
%    want to use them in the prediction too and these are computed 
%    using the latitude.
%
%     'latitude'        decimal degrees (+north) (default: none)
%
%    The tidal prediction may be restricted to only some of the 
%    available constituents:
%
%     'synthesis'    0 - Use all selected constituents.  (default)
%                    scalar>0 - Use only those constituents with a SNR
%                               greater than that given (1 or 2 are
%                               good choices).
%
%
%  It is possible to call t_predic without using property names, in
%  which case the assumed calling sequence is
%
%    YOUT=T_PREDIC(TIM,NAMES,FREQ,TIDECON,LATITUDE,SYNTHESIS);
%
%  T_PREDIC can be called using the tidal structure available as an 
%  optional output from T_TIDE
%
%    YOUT=T_PREDIC(TIM,TIDESTRUC,...)
%
% R. Pawlowicz 11/8/99
% Version 1.0
'toto'
if nargin<2,  % Not enough
  error('Not enough input arguments');
end;

if isstruct(varargin{1}),
  names=varargin{1}.name;
  freq=varargin{1}.freq;
  tidecon=varargin{1}.tidecon;
  varargin(1)=[];
else
  if length(varargin)<3,
    error('Not enough input arguments');
  end;
  names=varargin{1};
  freq=varargin{2};
  tidecon=varargin{3};
  varargin(1:3)=[];
end;

lat=[];
synth=0;

k=1;
while length(varargin)>0,
  if ischar(varargin{1}),
    switch lower(varargin{1}(1:3)),
      case 'lat',
         lat=varargin{2};
      case 'syn',
         synth=varargin{2};
      otherwise,
         error(['Can''t understand property:' varargin{1}]);
    end;
    varargin([1 2])=[]; 
  else
    switch k,
      case 1,
        lat=varargin{1};
      case 2,
        synth=varargin{1};
      otherwise
        error('Too many input parameters');
     end;
     varargin(1)=[];
  end;
  k=k+1;
end;

% Do the synthesis.        

snr=(tidecon(:,1)./tidecon(:,2)).^2;  % signal to noise ratio
if synth>0,
   I=snr>synth;
   if ~any(I),
     warning('No predictions with this SNR');
     yout=NaN+zeros(size(tim));
     return;
   end;  
   tidecon=tidecon(I,:);
   names=names(I,:);
   freq=freq(I);  
end;    

if size(tidecon,2)==4,  % Real time series
  ap=tidecon(:,1)/2.*exp(-i*tidecon(:,3)*pi/180);
  am=conj(ap);
else
  ap=(tidecon(:,1)+tidecon(:,3))/2.*exp( i*pi/180*(tidecon(:,5)-tidecon(:,7)));
  am=(tidecon(:,1)-tidecon(:,3))/2.*exp( i*pi/180*(tidecon(:,5)+tidecon(:,7)))
end;

% Mean at central point (get rid of one point at end to take mean of
% odd number of points if necessary).
jdmid=mean(tim(1:2*fix((length(tim)-1)/2)+1));

const=t_getconsts;
ju=zeros(size(freq));

% Check to make sure names and frequencies match expected values.

for k=1:size(names,1),
  ju(k)=strmatch(names(k,:),const.name);
end;
%if any(freq~=const.freq(ju)),
%  error('Frequencies do not match names in input');
%end;

% Get the astronical argument with or without nodal corrections.
 if ~isempty(lat) & abs(jdmid)>1,
  [v,u,f]=t_vuf(jdmid,ju,lat);
 elseif abs(jdmid)>1, % a real date
   [v,u,f]=t_vuf(jdmid,ju);
 else
    v=zeros(length(ju),1);
    u=v;
    f=ones(length(ju),1);  
 end;

 ap=ap.*f.*exp(+i*2*pi*(u+v));
 am=am.*f.*exp(-i*2*pi*(u+v));


tim=tim-jdmid;

[n,m]=size(tim);
tim=tim(:)';

yout=sum(exp( i*2*pi*freq*tim*24).*ap(:,ones(size(tim))),1)+ ...
     sum(exp(-i*2*pi*freq*tim*24).*am(:,ones(size(tim))),1);
     
  yout=reshape(yout,n,m);
  %yout=0*reshape(yout,n,m);

  

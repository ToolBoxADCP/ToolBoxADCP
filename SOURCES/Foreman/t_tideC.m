%%Programme Modifi� pour Mayotte
%%
function [nameu,fu,tidecon,NodalCorr,xout]=t_tideC(BolFig,fichierGlobal,fichierS,xin,tuk_time,varargin);

global coef

% T_TIDE Harmonic analysis of a time series
% [NAME,FREQ,TIDECON,XOUT]=T_TIDE(XIN) computes the tidal analysis 
% of the (possibly complex) time series XIN.
%
% [TIDESTRUC,XOUT]=T_TIDE(XIN) returns the analysis information in
% a structure formed of NAME, FREQ, and TIDECON.
%
% Further inputs are optional, and are specified as property/value pairs
% [...]=T_TIDE(XIN,property,value,property,value,...,etc.)
%      
% These properties are:
%
%       'interval'       Sampling interval (hours), default = 1. 
%          
%   The next two are required if nodal corrections are to be computed,
%   otherwise not necessary. If they are not included then the reported
%   phases are raw constituent phases at the central time. 
%       'start time'     [year,month,day,hour,min,sec]
%                        - min,sec are optional OR 
%                        decimal day (matlab DATENUM scalar)
%       'latitude'       decimal degrees (+north) (default: none).
%
%   Where to send the output.
%       'output'         where to send printed output:
%                        'none'    (no printed output)
%                        'screen'  (to screen) - default
%                        FILENAME   (to a file)
%
%   Correction factor for prefiltering.
%       'prefilt'        FS,CORR
%                        If the time series has been passed through
%                        a pre-filter of some kind (say, to reduce the
%                        low-frequency variability), then the analyzed
%                        constituents will have to be corrected for 
%                        this. The correction transfer function 
%                        (1/filter transfer function) has (possibly 
%                        complex) magnitude CORR at frequency FS (cph). 
%                        Corrections of more than a factor of 100 are 
%                        not applied; it is assumed these refer to tidal
%                        constituents that were intentionally filtered 
%                        out, e.g., the fortnightly components.
%
%   Adjustment for long-term behavior ("secular" behavior).
%       'secular'        'mean'   - assume constant offset (default).
%                        'linear' - get linear trend.
%                     
%   Inference of constituents.
%       'inference'      NAME,REFERENCE,AMPRAT,PHASE_OFFSET
%                        where NAME is an array of the names of 
%                        constituents to be inferred, REFERENCE is an 
%                        array of the names of references, and AMPRAT 
%                        and PHASE_OFFSET are the amplitude factor and
%                        phase offset (in degrees)from the references. 
%                        NAME and REFERENCE are Nx4 (max 4 characters
%                        in name), and AMPRAT and PHASE_OFFSET are Nx1
%                        (for scalar time series) and Nx2 for vector 
%                        time series (column 1 is for + frequencies and
%                        column 2 for - frequencies).
%
%   Shallow water constituents
%       'shallow'        NAME
%                        A matrix whose rows contain the names of 
%                        shallow-water constituents to analyze.
%
%   Resolution criterions for least-squares fit.        
%       'rayleigh'       scalar - Rayleigh criteria, default = 1.
%                        Matrix of strings - names of constituents to
%                                   use (useful for testing purposes).
%  
%   Calculation of confidence limits.
%       'error'          'wboot'  - Boostrapped confidence intervals 
%                                   based on a correlated bivariate 
%                                   white-noise model.
%                        'cboot'  - Boostrapped confidence intervals 
%                                   based on an uncorrelated bivariate 
%                                   coloured-noise model (default).
%                        'linear' - Linearized error analysis that 
%                                   assumes an uncorrelated bivariate 
%                                   coloured noise model. 
%                                   
%   Computation of "predicted" tide (passed to t_predic, but note that
%                                    the default value is different).
%       'synthesis'      0 - use all selected constituents
%                        scalar>0 - use only those constituents with a 
%                                   SNR greater than that given (1 or 2 
%                                   are good choices, 2 is the default).
%                              <0 - return result of least-squares fit 
%                                   (should be the same as using '0', 
%                                   except that NaN-holes in original 
%                                   time series will remain).
%
%
%       It is possible to call t_tide without using property names,
%       in which case the assumed calling sequence is
%
%          T_TIDE(XIN,INTERVAL,START_TIME,LATITUDE,RAYLEIGH)
%
%
%  OUTPUT: 
%
%    nameu=list of constituents used
%    fu=frequency of tidal constituents (cycles/hr)
%    tidecon=[fmaj,emaj,fmin,emin,finc,einc,pha,epha] for vector xin
%           =[fmaj,emaj,pha,epha] for scalar (real) xin
%       fmaj,fmin - constituent major and minor axes (same units as xin)       
%       emaj,emin - 95% confidence intervals for fmaj,fmin
%       finc - ellipse orientations (degrees)
%       einc - 95% confidence intervals for finc
%       pha - constituent phases (degrees relative to Greenwich)
%       epha - 95% confidence intervals for pha
%    xout=tidal prediction
%
% Note: Although missing data can be handled with NaN, it is wise not
%       to have too many of them. If your time series has a lot of 
%       missing data at the beginning and/or end, then truncate the 
%       input time series.  The Rayleigh criterion is applied to 
%       frequency intervals calculated as the inverse of the input 
%       series length.
%
% A description of the theoretical basis of the analysis and some
% implementation details can be found in:
%
% Pawlowicz, R., B. Beardsley, and S. Lentz, "Classical Tidal 
%   "Harmonic Analysis Including Error Estimates in MATLAB 
%    using T_TIDE", Computers and Geosciences, 2002.
%
% (citation of this article would be appreciated if you find the
%  toolbox useful).


% R. Pawlowicz 11/8/99 - Completely rewritten from the transliterated-
%                        to-matlab IOS/Foreman fortran code by S. Lentz
%                        and B. Beardsley.
%              3/3/00  - Redid errors to take into account covariances 
%                        between u and v errors.
%              7/21/00 - Found that annoying bug in error calc! 
%              11/1/00 - Added linear error analysis.
%              8/29/01 - Made synth=1 default, also changed behavior 
%                        when no lat/time given so that phases are raw
%                        at central time. 
%              9/1/01  - Moved some SNR code to t_predic.
%              9/28/01 - made sure you can't choose Z0 as constituent.
%              6/12/01 - better explanation for variance calcs, fixed
%                        bug in typed output (thanks Mike Cook).
%
% Version 1.02



% ----------------------Parse inputs-----------------------------------
ray=1;
dt=10/60;
fid=1;
stime=[];
lat=[];
corr_fs=[0 1e6];
corr_fac=[1  1];
secular='mean';
%secular='lin';
inf.iname=[];
inf.irefname=[];
shallownames=[];
constitnames=[];
errcalc='cboot';
synth=2;

k=1;
while length(varargin)>0,
  if ischar(varargin{1}),
    switch lower(varargin{1}(1:3)),
      case 'int',
        dt=varargin{2};
      case 'sta',
         stime=varargin{2};
	     if length(stime)>1, 
	        stime=[stime(:)' zeros(1,6-length(stime))]; 
	        stime=datenum(stime(1),stime(2),stime(3),stime(4),stime(5),stime(6));
	     end;
      case 'lat',
         lat=varargin{2};
      case 'out',
         filen=varargin{2};
	     switch filen,
	       case 'none',
	         fid=-1;
	       case 'screen',
	         fid=1;
         otherwise
	       [fid,mesg]=fopen(filen,'w');
	       if fid==-1, error(msg); end;
	     end;
      case 'ray',
         if isnumeric(varargin{2}),
           ray=varargin{2};
         else
	       constitnames=varargin{2};
	       if iscellstr(constitnames), constitnames=char(constitnames); end;
	     end;
      case 'pre',
         corr_fs=varargin{2};
	     corr_fac=varargin{3};
         varargin(1)=[];
      case 'sec',
         secular=varargin{2};
      case 'inf',
         inf.iname=varargin{2};
	     inf.irefname=varargin{3};
	     inf.amprat=varargin{4};
	     inf.ph=varargin{5};
	     varargin(1:3)=[];
      case 'sha',
         shallownames=varargin{2};
      case 'err',
         errcalc=varargin{2};
      case 'syn',
         synth=varargin{2};
      otherwise,
         error(['Can''t understand property:' varargin{1}]);
      end;
      varargin([1 2])=[]; 
  else  
    switch k,
      case 1,
        dt=varargin{1};
      case 2,
        stime=varargin{1};
      case 3,
        lat=varargin{1};
      case 4,
        ray=varargin{1};
      otherwise
        error('Too many input parameters');
     end;
     varargin(1)=[];
  end;
  k=k+1;
end;

fid1=fopen(fichierGlobal,'at');
fid2=fopen(fichierS,'wt');

[inn,inm]=size(xin);
if ~(inn==1 | inm==1), error('Input time series is not a vector'); end;

xin=xin(:); % makes xin a column vector : xin=tuk_elev, valeur des donn�es
nobs=length(xin);

nobsu=nobs-rem(nobs-1,2);% makes series odd to give a center point

Duree=tuk_time(end)-tuk_time(1);
tuk_time_milieu=(tuk_time(end)+tuk_time(1))/2;
t=tuk_time-tuk_time_milieu;  % Time vector for entire time series,
                                 % centered at series midpoint. 
DT=diff(t);dt=DT(1);
if ~isempty(stime),
  centraltime=stime+tuk_time_milieu/24;
else
  centraltime=[];
end;

% -------Get the frequencies to use in the harmonic analysis-----------
% ATTENTION !!!
% La commande originale est modifiee.
%commande d'origine
%[nameu,fu,ju,namei,fi,jinf,jref]=constituents(ray/(dt*nobsu),constitnames,...
%                                          shallownames,inf.iname,inf.irefname,centraltime);
%Commande modifi�e
[nameu,fu,ju,namei,fi,jinf,jref]=constituents(ray/(Duree),constitnames,...
                                            shallownames,inf.iname,inf.irefname,centraltime);
 if (size(nameu,1)<10)
  [nameu,fu,ju,namei,fi,jinf,jref]=constituents(ray/(2*Duree),constitnames,...
                                             shallownames,inf.iname,inf.irefname,centraltime);
  %pause
 end
mu=length(fu); % # base frequencies
mi=length(fi); % # inferred

% Find the good data points (here I assume that in a complex time 
% series, if u is bad, so is v).

gd=find(isfinite(xin(1:end)));
ngood=length(gd);
if(BolFig==1)
fprintf('   Points used: %d of %d\n',ngood,nobs)
end


%----------------------------------------------------------------------
% Now solve for the secular trend plus the analysis. Instead of solving
% for + and - frequencies using exp(i*f*t), I use sines and cosines to 
% keep tc real.  If the input series is real, than this will 
% automatically use real-only computation. However, for the analysis, 
% it's handy to get the + and - frequencies ('ap' and 'am'), and so 
% that's what we do afterwards.

if secular(1:3)=='lin',
  tc=[ones(length(t),1) t*(2/Duree) cos((2*pi)*t*fu') sin((2*pi)*t*fu') ];

  coef=tc(gd,:)\xin(gd);

  z0=coef(1);dz0=coef(2);
  ap=(coef(3:mu+2)-i*coef(mu+3:end))/2;  % a+ amplitudes
  am=(coef(3:mu+2)+i*coef(mu+3:end))/2;  % a- amplitudes
else
    %global coef
  tc=[ones(length(t),1) cos((2*pi)*t*fu') sin((2*pi)*t*fu') ];
  
  coef=tc(gd,:)\xin(gd);
  res=xin(gd)-tc(gd,:)*coef;
%  coef,pause
  z0=coef(1);dz0=0;
  ap=(coef(2:mu+1)-i*coef(mu+2:end))/2;  % a+ amplitudes
  am=(coef(2:mu+1)+i*coef(mu+2:end))/2;  % a- amplitudes
  ampl1=ap+am;
end;

%----------------------------------------------------------------------
% Check variance explained (but do this with the original fit).

xout=tc*coef;  % This is the time series synthesized from the analysis
xres=xin-xout; % and the residuals! 
if(BolFig==1)
    plot(t,xin,'b',t,xout,'r')
    plot([xin xout])

    close all,figure(1),hold on
    plot(xin,'r')
    plot(xout,'b')
    legend('Signal Original','Signal interpole')
    saveas(gcf,fichierS,'fig')
    saveas(gcf,fichierS,'png')
end
%xres ne doit pas etre tr�s grand car tc*coef=xin !!!

if(BolFig==1)
if isreal(xin),    % Real time series
  varx=cov(xin(gd));varxp=cov(xout(gd));varxr=cov(xres(gd));
  fprintf('   percent of var residual after lsqfit/var original: %5.2f %%\n',100*(varxr/varx));  
else               % Complex time series
  varx=cov(real(xin(gd)));varxp=cov(real(xout(gd)));varxr=cov(real(xres(gd)));
  fprintf('   percent of X var residual after lsqfit/var original: %5.2f %%\n',100*(varxr/varx));

  vary=cov(imag(xin(gd)));varyp=cov(imag(xout(gd)));varyr=cov(imag(xres(gd)));
  fprintf('   percent of Y var residual after lsqfit/var original: %5.2f %%\n',100*(varyr/vary));
end;
end

%---------- Correct for prefiltering-----------------------------------

corrfac=interp1(corr_fs,corr_fac,fu);
% To stop things blowing up!
corrfac(corrfac>100 | corrfac <.01 | isnan(corrfac))=1;

ap=ap.*corrfac;
am=am.*conj(corrfac);

%---------------Nodal Corrections--------------------------------------
% Generate nodal corrections and calculate phase relative to Greenwich.
% Note that this is a slightly weird way to do the nodal corrections,
% but is 'traditional'.  The "right" way would be to change the basis 
% functions used in the least-squares fit above.
% ii=1;
if ~isempty(lat) & ~isempty(stime),   % Time and latitude
    
  % Get nodal corrections at midpoint time.
  [v,u,f]=t_vuf(centraltime,[ju;jinf],lat);
  
  vu=(v+u)*360; % total phase correction (degrees)
  nodcor=['Greenwich phase computed with nodal corrections applied to amplitude \n and phase relative to center time'];  
elseif ~isempty(stime),    % Time only
  % Get nodal corrections at midpoint time
  [v,u,f]=t_vuf(centraltime,[ju;jinf]);
  vu=(v+u)*360; % total phase correction (degrees)
  nodcor=['Greenwich phase computed, no nodal corrections'];  
else   % No time, no latitude
  vu=zeros(length(ju)+length(jinf),1);
  f=ones(length(ju)+length(jinf),1);
   nodcor=['Phases at central time'];  
end
if(BolFig==1)
    fprintf(['   ',nodcor,'\n']);
end

%---------------Inference Corrections----------------------------------
% Once again, the "right" way to do this would be to change the basis
% functions.
ii=find(isfinite(jref));
if ii,
  fprintf('   Do inference corrections\n');
  snarg=nobsu*pi*(fi(ii)   -fu(jref(ii)) )*dt;
  scarg=sin(snarg)./snarg;
 
  if size(inf.amprat,2)==1,    % For real time series
    pearg=     2*pi*(vu(mu+ii)-vu(jref(ii))+inf.ph(ii))/360;
    pcfac=inf.amprat(ii).*f(mu+ii)./f(jref(ii)).*exp(i*pearg);
    pcorr=1+pcfac.*scarg;
    mcfac=conj(pcfac);
    mcorr=conj(pcorr);
  else                          % For complex time series
    pearg=     2*pi*(vu(mu+ii)-vu(jref(ii))+inf.ph(ii,1))/360;
    pcfac=inf.amprat(ii,1).*f(mu+ii)./f(jref(ii)).*exp(i*pearg);
    pcorr=1+pcfac.*scarg;
    mearg=    -2*pi*(vu(mu+ii)-vu(jref(ii))+inf.ph(ii,2))/360;
    mcfac=inf.amprat(ii,2).*f(mu+ii)./f(jref(ii)).*exp(i*mearg);
    mcorr=1+mcfac.*scarg;
  end;
   
  ap(jref(ii))=ap(jref(ii))./pcorr;   % Changes to existing constituents
  ap=[ap;ap(jref(ii)).*pcfac];        % Inferred constituents

  am(jref(ii))=am(jref(ii))./mcorr;
  am=[am;am(jref(ii)).*mcfac];

  fu=[fu;fi(ii)];
  nameu=[nameu;namei(ii,:)];
end;

% --------------Error Bar Calculations---------------------------------
%
% Error bar calcs involve two steps:
%      1) Estimate the uncertainties in the analyzed amplitude
%         for both + and - frequencies (i.e., in 'ap' and 'am').
%         A simple way of doing this is to take the variance of the
%         original time series and divide it into the amount appearing
%         in the bandwidth of the analysis (approximately 1/length).
%         A more sophisticated way is to assume "locally white"
%         noise in the vicinity of, e.g., the diurnal consistuents.
%         This takes into account slopes in the continuum spectrum.
%
%      2) Transform those uncertainties into ones suitable for ellipse
%         parameters (axis lengths, angles). This can be done 
%         analytically for large signal-to-noise ratios. However, the 
%         transformation is non-linear at lows SNR, say, less than 10
%         or so.
%

xr=fixgaps(xres); % Fill in "internal" NaNs with linearly interpolated
                  % values so we can fft things.
nreal=1;

if strmatch(errcalc(2:end),'boot'),
    if(BolFig==1)
  fprintf('   Using nonlinear bootstrapped error estimates\n');
    end
  
  % "noise" matrices are created with the right covariance structure
  % to add to the analyzed components to create 'nreal' REPLICATES. 
  % 

  nreal=300;             % Create noise matrices 
  [NP,NM]=noise_realizations(xr(isfinite(xr)),fu,dt,nreal,errcalc);
      
  % All replicates are then transformed (nonlinearly) into ellipse 
  % parameters.  The computed error bars are then based on the std
  % dev of the replicates.

  AP=ap(:,ones(1,nreal))+NP;        % Add to analysis (first column
  AM=am(:,ones(1,nreal))+NM;        % of NM,NP=0 so first column of
                                    % AP/M holds ap/m).
  epsp=angle(AP)*180/pi;            % Angle/magnitude form:
  epsm=angle(AM)*180/pi;
  ap=abs(AP);
  am=abs(AM);

elseif strmatch(errcalc,'linear'),
  fprintf('   Using linearized error estimates\n');
  %
  % Uncertainties in analyzed amplitudes are computed in different
  % spectral bands. Real and imaginary parts of the residual time series
  % are treated separately (no cross-covariance is assumed).
  %
  % Noise estimates are then determined from a linear analysis of errors,
  % assuming that everything is uncorrelated. This is OK for scalar time
  % series but can fail for vector time series if the noise is not 
  % isotropic.
  
  [ercx,eicx]=noise_stats(xr(finite(xr)),fu,dt);
  % Note - here we assume that the error in the cos and sin terms is 
  % equal, and equal to total power in the encompassing frequency bin. 
  % It seems like there should be a factor of 2 here somewhere but it 
  % only works this way! <shrug>
  [emaj,emin,einc,epha]=errell(ap+am,i*(ap-am),ercx,ercx,eicx,eicx);

  epsp=angle(ap)*180/pi;
  epsm=angle(am)*180/pi;
  ap=abs(ap);
  am=abs(am);
else
  error(['Unrecognized type of error analysis: ''' errcalc ''' specified!']);
end;

%-----Convert complex amplitudes to standard ellipse parameters--------
aap=ap./f(:,ones(1,nreal));	% Apply nodal corrections and
aam=am./f(:,ones(1,nreal));	% compute ellipse parameters.

fmaj=aap+aam;                   % major axis
fmin=aap-aam;                   % minor axis
gp=mod( vu(:,ones(1,nreal))-epsp ,360); % pos. Greenwich phase in deg.
gm=mod( vu(:,ones(1,nreal))+epsm ,360); % neg. Greenwich phase in deg.

finc= (epsp+epsm)/2;
finc(:,1)=mod( finc(:,1),180 ); % Ellipse inclination in degrees
				% (mod 180 to prevent ambiguity, i.e., 
				% we always ref. against northern 
				% semi-major axis.
	
finc=cluster(finc,180); 	% Cluster angles around the 'true' 
                                % angle to avoid 360 degree wraps.

pha=mod( gp+finc ,360); 	% Greenwich phase in degrees.

pha=cluster(pha,360);		% Cluster angles around the 'true' angle
				% to avoid 360 degree wraps.

%----------------Generate 95% CI---------------------------------------
%% For bootstrapped errors, we now compute limits of the distribution.
if strmatch(errcalc(2:end),'boot'),
     %% std dev-based estimates.
     % The 95% CI are computed from the sigmas
     % by a 1.96 fudge factor (infinite degrees of freedom).
     % emaj=1.96*std(fmaj,0,2);
     % emin=1.96*std(fmin,0,2);
     % einc=1.96*std(finc,0,2);
     % epha=1.96*std(pha ,0,2);
     %% Median-absolute-deviation (MAD) based estimates.
     % (possibly more stable?)
      emaj=median(abs(fmaj-median(fmaj,2)*ones(1,nreal)),2)/.6375*1.96;
      emin=median(abs(fmin-median(fmin,2)*ones(1,nreal)),2)/.6375*1.96;
      einc=median(abs(finc-median(finc,2)*ones(1,nreal)),2)/.6375*1.96;
      epha=median(abs( pha-median( pha,2)*ones(1,nreal)),2)/.6375*1.96;
else
   % In the linear analysis, the 95% CI are computed from the sigmas
   % by this fudge factor (infinite degrees of freedom).
   emaj=1.96*emaj;
   emin=1.96*emin;
   einc=1.96*einc;
   epha=1.96*epha;
end;
				  
if isreal(xin),
    tidecon=[fmaj(:,1),emaj,pha(:,1),epha];
else
    tidecon=[fmaj(:,1),emaj,fmin(:,1),emin, finc(:,1),einc,pha(:,1),epha];
end;

% Sort results by frequency (needed if anything has been inferred since 
% these are stuck at the end of the list by code above).
if any(isfinite(jref)),
 [fu,I]=sort(fu);
 nameu=nameu(I,:);
 tidecon=tidecon(I,:);
end;

snr=(tidecon(:,1)./tidecon(:,2)).^2;  % signal to noise ratio

%--------Generate a 'prediction' using significant constituents----------
xoutOLD=xout;
if synth>=0,
 if ~isempty(lat) & ~isempty(stime),
   if(BolFig==1)
       fprintf('   Generating prediction with nodal corrections, SNR is %f\n',synth);
   end
   xout=t_predic(centraltime+t/24,nameu,fu,tidecon,'lat',lat,'synth',synth);
 elseif ~isempty(stime), 
   if(BolFig==1)
   fprintf('   Generating prediction without nodal corrections, SNR is %f\n',synth);
   end
   xout=t_predic(stime+[0:nobs-1]*dt/24.0,nameu,fu,tidecon,'synth',synth);
 else
   if(BolFig==1)
   fprintf('   Generating prediction without nodal corrections, SNR is %f\n',synth);
   end
   xout=t_predic(t/24.0,nameu,fu,tidecon,'synth',synth);
 end;
else
   if(BolFig==1)
 fprintf('   Returning fitted prediction\n');
   end
end;

%----------------------------------------------------------------------
% Check variance explained (but now do this with the synthesized fit).
xres=xin(:)-xout(:); % and the residuals!
if(BolFig==1)
    fprintf('Erreur : %5.2f',nanmean(abs(xres)))
end

%error;

if isreal(xin),    % Real time series
  varx=cov(xin(gd));varxp=cov(xout(gd));varxr=cov(xres(gd));
  if(BolFig==1)
    fprintf('   percent of var residual after synthesis/var original: %5.2f %%\n',100*(varxr/varx));  
  end;
else               % Complex time series
  varx=cov(real(xin(gd)));varxp=cov(real(xout(gd)));varxr=cov(real(xres(gd)));
  if(BolFig==1)
    fprintf('   percent of X var residual after synthesis/var original: %5.2f %%\n',100*(varxr/varx));
  end;

  vary=cov(imag(xin(gd)));varyp=cov(imag(xout(gd)));varyr=cov(imag(xres(gd)));
  if(BolFig==1)
    fprintf('   percent of Y var residual after synthesis/var original: %5.2f %%\n',100*(varyr/vary));
  end;
end;


%-----------------Output results---------------------------------------
if fid>1,
 fprintf(fid,'\n%s\n',['file name: ',filen]);
elseif fid==1,
 if(BolFig==1)
     fprintf(fid,'-----------------------------------\n');
 end
end

if fid>0,
  if(BolFig==1)
  fprintf(fid,'date: %s\n',date);
  fprintf(fid,'nobs = %d,  ngood = %d,  record length (days) = %.2f\n',nobs,ngood,length(xin)*dt/24);
  if ~isempty(stime); fprintf(fid,'%s\n',['start time: ',datestr(stime)]); end
  fprintf(fid,'rayleigh criterion = %.1f\n',ray);
  fprintf(fid,'%s\n',nodcor);
%  fprintf(fid,'\n     coefficients from least squares fit of x\n');
%  fprintf(fid,'\n tide    freq        |a+|       err_a+      |a-|       err_a-\n');
%  for k=1:length(fu);
%    if ap(k)>eap(k) | am(k)>eam(k), fprintf('*'); else fprintf(' '); end;
%    fprintf(fid,'%s  %8.5f  %9.4f  %9.4f  %9.4f  %9.4f\n',nameu(k,:),fu(k),ap(k),eap(k),am(k),eam(k));
%  end
  fprintf(fid,'\nx0= %.3g, x trend= %.3g\n',real(z0),real(dz0));
  fprintf(fid,['\nvar(x)= ',num2str(varx),'   var(xp)= ',num2str(varxp),'   var(xres)= ',num2str(varxr) '\n']);
  fprintf(fid,'percent var predicted/var original= %.1f %%\n',100*varxp/varx);
  end
  if isreal(xin)
  if(BolFig==1)
    fprintf(fid,'\n     tidal amplitude and phase with 95%% CI estimates\n');
    fprintf(fid,'\ntide   freq       amp     amp_err    pha    pha_err     snr\n');
    for k=1:length(fu);
      if snr(k)>synth, fprintf(fid,'*'); else fprintf(fid,' '); end;
      fprintf(fid,'%s %9.7f %9.4f %8.3f %8.2f %8.2f %8.2g\n',nameu(k,:),fu(k),tidecon(k,:),snr(k));
    end
    end
    fprintf(fid2,'\n     tidal amplitude and phase with 95%% CI estimates\n');
    fprintf(fid2,'\ntide   freq       amp     amp_err    pha    pha_err     snr\n');
    fprintf(fid1, '\n \n %s \n ', fichierS);
    fprintf(fid1,'\ntide   freq       amp     amp_err    pha    pha_err     snr\n');
    fprintf(fid1,'  \n');
    [cr,ix]=sortrows(tidecon,-1);
    for l=1:length(fu);
        k=ix(l);
      fprintf(fid1,'%s %9.7f %9.4f %8.3f %8.2f %8.2f %8.2g\n',nameu(k,:),fu(k),tidecon(k,:),snr(k));
      fprintf(fid2,'%s %9.7f %9.4f %8.3f %8.2f %8.2f %8.2g\n',nameu(k,:),fu(k),tidecon(k,:),snr(k));
    end
  else
  if(BolFig==1)
    fprintf(fid,'\ny0= %.3g, x trend= %.3g\n',imag(z0),imag(dz0));
    fprintf(fid,['\nvar(y)= ',num2str(vary),'    var(yp)= ',num2str(varyp),'  var(yres)= ',num2str(varyr) '\n']);
    fprintf(fid,'percent var predicted/var original= %.1f %%\n',100*varyp/vary);
    fprintf(fid,'\n%s\n',['ellipse parameters with 95%% CI estimates']);
    fprintf(fid,'\n%s\n',['tide   freq      major  emaj    minor   emin     inc    einc     pha    epha      snr']);
    for k=1:length(fu);
      if snr(k)>synth, fprintf(fid,'*'); else fprintf(fid,' '); end;
      fprintf(fid,'%s %9.7f %6.3f %7.3f %7.3f %6.2f %8.2f %6.2f %8.2f %6.2f %6.2g\n',...
	  nameu(k,:),fu(k),tidecon(k,:),snr(k));
    end
    fprintf(fid,['\ntotal var= ',num2str(varx+vary),'   pred var= ',num2str(varxp+varyp) '\n']);
    fprintf(fid,'percent total var predicted/var original= %.1f %%\n\n',100*(varxp+varyp)/(varx+vary));
    end
    for k=1:length(fu);
      fprintf(fid1,'%s %9.7f %6.3f %7.3f %7.3f %6.2f %8.2f %6.2f %8.2f %6.2f %6.2g\n',...
	  nameu(k,:),fu(k),tidecon(k,:),snr(k));
    end
  end
  if fid~=1, st=fclose(fid); end

end;

%% Coef Lineaire
% partie lineaire = coef(1)+coef(2)*t*2/Duree
%                 = coef(1) - 2*coef(2)/Dur�e * tuk_time_mileu +
%                 2*coef(2)/Dur�e * tuk_time
CoefLin(1)=coef(1)- 2*coef(2)/Duree * tuk_time_milieu;
CoefLin(2)=2*coef(2)/Duree; 

%% Sauvegarde
xout=reshape(xout,inn,inm);
switch nargout,
  case {0,3,4}
 case {1}
   nameu = struct('name',nameu,'freq',fu,'tidecon',tidecon);
  case {2}   
   xout=reshape(xout,inn,inm);
   nameu = struct('name',nameu,'freq',fu,'tidecon',tidecon,'Lin',CoefLin,'Num',ju);
   fu=xout;
end;
%----------------------------------------------------------------------
function [nameu,fu,ju,namei,fi,jinf,jref]=constituents(minres,constit,...
                                     shallow,infname,infref,centraltime);
% [name,freq,kmpr]=constituents(minres,infname) loads tidal constituent
% table (containing 146 constituents), then picks out only the '
% resolvable' frequencies (i.e. those that are MINRES apart), base on 
% the comparisons in the third column of constituents.dat. Only 
% frequencies in the 'standard' set of 69 frequencies are actually used.
% Also return the indices of constituents to be inferred.

% If we have the mat-file, read it in, otherwise create it and read
% it in!

% R Pawlowicz 9/1/01 
% Version 1.0
%
%    19/1/02 - typo fixed (thanks to  Zhigang Xu)

% Compute frequencies from astronomical considerations.
BolFig=0;
[const,sat,cshallow]=t_getconsts(centraltime);
if isempty(constit),
  ju=find(const.df>=minres);
else
  ju=[];
  for k=1:size(constit,1),
   j1=strmatch(constit(k,:),const.name);
   if isempty(j1),
     disp(['Can''t recognize name ' constit(k,:) ' for forced search']);
   elseif j1==1,
     disp(['*************************************************************************']);
     disp(['Z0 specification ignored - for non-tidal offsets see ''secular'' property']);
     disp(['*************************************************************************']);
   else  
     ju=[ju;j1];
   end;
  end;
  [dum,II]=sort(const.freq(ju)); % sort in ascending order of frequency.
  ju=ju(II);
end;

if(BolFig==1)
    disp(['   number of standard constituents used: ',int2str(length(ju))])
end

if ~isempty(shallow),
 for k=1:size(shallow,1),
   j1=strmatch(shallow(k,:),const.name);
   if isempty(j1),
     disp(['Can''t recognize name ' shallow(k,:) ' for forced search']);
   else
     if isnan(const.ishallow(j1)),
       disp([shallow(k,:) ' Not a shallow-water constituent']);
     end;
     disp(['   Forced fit to ' shallow(k,:)]);
     ju=[ju;j1];
   end;
 end;
 
end;
      
nameu=const.name(ju,:);
fu=const.freq(ju);


% Check if neighboring chosen constituents violate Rayleigh criteria.
jck=find(diff(fu)<minres);
if (length(jck)>0)
   disp(['  Warning! Following constituent pairs violate Rayleigh criterion']);
   for ick=1:length(jck);
   disp(['     ',nameu(jck(ick),:),'  ',nameu(jck(ick)+1,:)]);
   end;
end

% For inference, add in list of components to be inferred.

fi=[];namei=[];jinf=[];jref=[];
if ~isempty(infname),
  fi=zeros(size(infname,1),1);
  namei=zeros(size(infname,1),4);
  jinf=zeros(size(infname,1),1)+NaN;
  jref=zeros(size(infname,1),1)+NaN;
  
  for k=1:size(infname,1),
   j1=strmatch(infname(k,:),const.name);
   if isempty(j1),
     disp(['Can''t recognize name' infname(k,:) ' for inference']);
   else
    jinf(k)=j1;
    fi(k)=const.freq(j1);
    namei(k,:)=const.name(j1,:);
    j1=strmatch(infref(k,:),nameu);
    if isempty(j1),
      disp(['Can''t recognize name ' infref(k,:) ' for as a reference for inference']);
    else
      jref(k)=j1;
      fprintf(['   Inference of ' namei(k,:) ' using ' nameu(j1,:) '\n']);
    end;
   end;
  end;    
  jinf(isnan(jref))=NaN;
fclose(fid1)
fclose(fid2)
'pause',pause
end;
%----------------------------------------------------------------------
function y=fixgaps(x);
% FIXGAPS: Linearly interpolates gaps in a time series
% YOUT=FIXGAPS(YIN) linearly interpolates over NaN in the input time 
% series (may be complex), but ignores trailing and leading NaNs.

% R. Pawlowicz 11/6/99
% Version 1.0

y=x;

bd=isnan(x);
gd=find(~bd);

bd([1:(min(gd)-1) (max(gd)+1):end])=0;


y(bd)=interp1(gd,x(gd),find(bd)); 


%----------------------------------------------------------------------
function ain=cluster(ain,clusang);
% CLUSTER: Clusters angles in rows around the angles in the first 
% column. CLUSANG is the allowable ambiguity (usually 360 degrees but
% sometimes 180).

ii=(ain-ain(:,ones(1,size(ain,2))))>clusang/2;
ain(ii)=ain(ii)-clusang;
ii=(ain-ain(:,ones(1,size(ain,2))))<-clusang/2;
ain(ii)=ain(ii)+clusang;


%----------------------------------------------------------------------
function [NP,NM]=noise_realizations(xres,fu,dt,nreal,errcalc);
% NOISE_REALIZATIONS: Generates matrices of noise (with correct
% cross-correlation structure) for bootstrap analysis.
%

% R. Pawlowicz 11/10/00
% Version 1.0

if strmatch(errcalc,'cboot'),
  [fband,Pxrave,Pxiave,Pxcave]=residual_spectrum(xres,fu,dt);
  
  Pxcave=zeros(size(Pxcave));  %% For comparison with other technique!
  %fprintf('**** Assuming no covariance between u and v errors!*******\n');

elseif strmatch(errcalc,'wboot'),
  fband=[0 .5];
  nx=length(xres);
  A=cov(real(xres),imag(xres))/nx;
  Pxrave=A(1,1);Pxiave=A(2,2);Pxcave=A(1,2);
else
  error(['Unrecognized type of bootstap analysis specified: ''' errcalc '''']);
end;
  
nfband=size(fband,1);

Mat=zeros(4,4,nfband);
for k=1:nfband,

  % The B matrix represents the covariance matrix for the vector
  % [Re{ap} Im{ap} Re{am} Im{am}]' where Re{} and Im{} are real and
  % imaginary parts, and ap/m represent the complex constituent 
  % amplitudes for positive and negative frequencies when the input
  % is bivariate white noise. For a flat residual spectrum this works 
  % fine.
 
  % This is adapted here for "locally white" conditions, but I'm still
  % not sure how to handle a complex sxy, so this is set to zero
  % right now.
  
  p=(Pxrave(k)+Pxiave(k))/2;
  d=(Pxrave(k)-Pxiave(k))/2;
  sxy=Pxcave(k);
  
  B=[p    0   d   sxy;
     0    p  sxy  -d;
     d   sxy  p    0
     sxy -d   0    p];

  % Compute the transformation matrix that takes uncorrelated white 
  % noise and makes noise with the same statistical structure as the 
  % Fourier transformed noise.
  [V,D]=eig(B);
  Mat(:,:,k)=V*diag(sqrt(diag(D)));
end;

% Generate realizations for the different analyzed constituents.

N=zeros(4,nreal);
NM=zeros(length(fu),nreal);
NP=NM;
for k=1:length(fu);
  l=find(fu(k)>fband(:,1) & fu(k)<fband(:,2));
  N=[zeros(4,1),Mat(:,:,l)*randn(4,nreal-1)];
  NP(k,:)=N(1,:)+i*N(2,:);
  NM(k,:)=N(3,:)+i*N(4,:);
end;

%----------------------------------------------------------------------
function [ercx,eicx]=noise_stats(xres,fu,dt);
% NOISE_STATS: Computes statistics of residual energy for all 
% constituents (ignoring any cross-correlations between real and
% imaginary parts).

% S. Lentz  10/28/99
% R. Pawlowicz 11/1/00
% Version 1.0

[fband,Pxrave,Pxiave,Pxcave]=residual_spectrum(xres,fu,dt);
nfband=size(fband,1);
mu=length(fu);

% Get the statistics for each component.
ercx=zeros(mu,1);
eicx=zeros(mu,1);
for k1=1:nfband;
   k=find(fu>=fband(k1,1) & fu<=fband(k1,2));
   ercx(k)=sqrt(Pxrave(k1));
   eicx(k)=sqrt(Pxiave(k1));
end

%----------------------------------------------------------------------
function [fband,Pxrave,Pxiave,Pxcave]=residual_spectrum(xres,fu,dt)
% RESIDUAL_SPECTRUM: Computes statistics from an input spectrum over
% a number of bands, returning the band limits and the estimates for
% power spectra for real and imaginary parts and the cross-spectrum.          
%
% Mean values of the noise spectrum are computed for the following 
% 8 frequency bands defined by their center frequency and band width:
% M0 +.1 cpd; M1 +-.2 cpd; M2 +-.2 cpd; M3 +-.2 cpd; M4 +-.2 cpd; 
% M5 +-.2 cpd; M6 +-.21 cpd; M7 (.26-.29 cpd); and M8 (.30-.50 cpd). 

% S. Lentz  10/28/99
% R. Pawlowicz 11/1/00
% Version 1.0

% Define frequency bands for spectral averaging.
fband =[.00010 .00417;
        .03192 .04859;
        .07218 .08884;
        .11243 .12910;
        .15269 .16936;
        .19295 .20961;
        .23320 .25100;
        .26000 .29000;
        .30000 .50000];

% If we have a sampling interval> 1 hour, we might have to get
% rid of some bins.
%fband(fband(:,1)>1/(2*dt),:)=[];

nfband=size(fband,1);
nx=length(xres);

% Spectral estimate (takes real time series only).

[Pxr,fx]=psd(real(xres),nx,1/dt); % Call to SIGNAL PROCESSING TOOLBOX - see note in t_readme. If you have an error here you are probably missing this toolbox
[Pxi,fx]=psd(imag(xres),nx,1/dt); % Call to SIGNAL PROCESSING TOOLBOX - see note in t_readme.
[Pxc,fx]=csd(real(xres),imag(xres),nx,1/dt); % Call to SIGNAL PROCESSING TOOLBOX - see note in t_readme.


df=fx(3)-fx(2);
Pxr(round(fu./df)+1)=NaN ; % Sets Px=NaN in bins close to analyzed frequencies
Pxi(round(fu./df)+1)=NaN ; % (to prevent leakage problems?).
Pxc(round(fu./df)+1)=NaN ; 

Pxrave=zeros(nfband,1);
Pxiave=zeros(nfband,1);
Pxcave=zeros(nfband,1);
% Loop downwards in frequency through bands (cures short time series
% problem with no data in lowest band).
%
% Divide by nx to get power per frequency bin, and multiply by 2
% to account for positive and negative frequencies.
%
for k=nfband:-1:1,
   jband=find(fx>=fband(k,1) & fx<=fband(k,2) & finite(Pxr));
   if any(jband),
     Pxrave(k)=mean(Pxr(jband))*2/nx;
     Pxiave(k)=mean(Pxi(jband))*2/nx;
     Pxcave(k)=mean(Pxc(jband))*2/nx;
   elseif k<nfband,
     Pxrave(k)=Pxrave(k+1);   % Low frequency bin might not have any points...
     Pxiave(k)=Pxiave(k+1);   
     Pxcave(k)=Pxcave(k+1);   
   end;
end



%----------------------------------------------------------------------
function [emaj,emin,einc,epha]=errell(cxi,sxi,ercx,ersx,ercy,ersy)
% [emaj,emin,einc,epha]=errell(cx,sx,cy,sy,ercx,ersx,ercy,ersy) computes
% the uncertainities in the ellipse parameters based on the 
% uncertainities in the least square fit cos,sin coefficients.
%
%  INPUT:  cx,sx=cos,sin coefficients for x 
%          cy,sy=cos,sin coefficients for y
%          ercx,ersx=errors in x cos,sin coefficients
%          ercy,ersy=errors in y cos,sin coefficients
%          
%  OUTPUT: emaj=major axis error
%          emin=minor axis error
%          einc=inclination error (deg)
%          epha=pha error (deg)

% based on linear error propagation, with errors in the coefficients 
% cx,sx,cy,sy uncorrelated. 

% B. Beardsley  1/15/99; 1/20/99
% Version 1.0

r2d=180./pi;
cx=real(cxi(:));sx=real(sxi(:));cy=imag(cxi(:));sy=imag(sxi(:));
ercx=ercx(:);ersx=ersx(:);ercy=ercy(:);ersy=ersy(:);

rp=.5.*sqrt((cx+sy).^2+(cy-sx).^2);
rm=.5.*sqrt((cx-sy).^2+(cy+sx).^2);
ercx2=ercx.^2;ersx2=ersx.^2;
ercy2=ercy.^2;ersy2=ersy.^2;

% major axis error
ex=(cx+sy)./rp;
fx=(cx-sy)./rm;
gx=(sx-cy)./rp;
hx=(sx+cy)./rm;
dcx2=(.25.*(ex+fx)).^2;
dsx2=(.25.*(gx+hx)).^2;
dcy2=(.25.*(hx-gx)).^2;
dsy2=(.25.*(ex-fx)).^2;
emaj=sqrt(dcx2.*ercx2+dsx2.*ersx2+dcy2.*ercy2+dsy2.*ersy2);

% minor axis error
dcx2=(.25.*(ex-fx)).^2;
dsx2=(.25.*(gx-hx)).^2;
dcy2=(.25.*(hx+gx)).^2;
dsy2=(.25.*(ex+fx)).^2;
emin=sqrt(dcx2.*ercx2+dsx2.*ersx2+dcy2.*ercy2+dsy2.*ersy2);

% inclination error
rn=2.*(cx.*cy+sx.*sy);
rd=cx.^2+sx.^2-(cy.^2+sy.^2);
den=rn.^2+rd.^2;
dcx2=((rd.*cy-rn.*cx)./den).^2;
dsx2=((rd.*sy-rn.*sx)./den).^2;
dcy2=((rd.*cx+rn.*cy)./den).^2;
dsy2=((rd.*sx+rn.*sy)./den).^2;
einc=r2d.*sqrt(dcx2.*ercx2+dsx2.*ersx2+dcy2.*ercy2+dsy2.*ersy2);

% phase error
rn=2.*(cx.*sx+cy.*sy);
rd=cx.^2-sx.^2+cy.^2-sy.^2;
den=rn.^2+rd.^2;
dcx2=((rd.*sx-rn.*cx)./den).^2;
dsx2=((rd.*cx+rn.*sx)./den).^2;
dcy2=((rd.*sy-rn.*cy)./den).^2;
dsy2=((rd.*cy+rn.*sy)./den).^2;
epha=r2d.*sqrt(dcx2.*ercx2+dsx2.*ersx2+dcy2.*ercy2+dsy2.*ersy2);


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
  A=freq;
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
save tim tim

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
% 

tim=tim-jdmid;

 [n,m]=size(tim);
tim=tim(:)';
yout=sum(exp( i*2*pi*freq*tim*24).*ap(:,ones(size(tim))),1)+ ...
     sum(exp(-i*2*pi*freq*tim*24).*am(:,ones(size(tim))),1);
     
  yout=reshape(yout,n,m);
  %yout=0*reshape(yout,n,m);

  
function [v,u,f]=t_vuf(ctime,ju,lat);
% T_VUF Computes nodal modulation corrections.
% [V,U,F]=T_VUF(DATE,JU,LAT) returns the astronomical phase V, the 
% nodal phase modulation U, and the nodal amplitude correction F at
% a decimal date DATE for the components specified by index JU (into
% the CONST structure returned by T_GETCONSTS) at a latitude LAT.
%
% If LAT is not specified, then the Greenwich phase V is computed with
% U=0 and F=1. 
%
% Note that V and U are in 'cycles', not degrees or radians (i.e.,
% multiply by 360 to get degrees).
%
% If LAT is set to NaN, then the nodal corrections are computed for all
% satellites that do *not* have a "latitude-dependent" correction 
% factor. This is for compatibility with the ways things are done in
% the xtide package. (The latitude-dependent corrections were zeroed
% out there partly because it was convenient, but this was rationalized
% by saying that since the forcing of tides can occur at latitudes
% other than where they are observed, the idea that observations have 
% the equilibrium latitude-dependence is possibly bogus anyway).

% R. Pawlowicz 11/8/99
%               1/5/00 - Changed to allow for no LAT setting.
%              11/8/00 - Added the LAT=NaN option.
% Version 1.0
 
% Get all the info about constituents.

[const,sat,shallow]=t_getconsts(ctime);

% Calculate astronomical arguments at mid-point of data time series.
[astro,ader]=t_astron(ctime);


% Phase relative to Greenwich (in units of cycles, presumeably).
% (This only returns values when we have doodson#s, i.e., not for the 
% shallow water components, but these will be computed later.)
v=rem( const.doodson*astro+const.semi, 1);
if nargin==3, % If we have a latitude, get nodal corrections.

  % Apparently the second-order terms in the tidal potential go to zero
  % at the equator, but the third-order terms do not. Hence when trying
  % to infer the third-order terms from the second-order terms, the 
  % nodal correction factors blow up. In order to prevent this, it is 
  % assumed that the equatorial forcing is due to second-order forcing 
  % OFF the equator, from about the 5 degree location. Latitudes are 
  % hence (somewhat arbitrarily) forced to be no closer than 5 deg to 
  % the equator.
  
  if isfinite(lat) & (abs(lat)<5); lat=sign(lat).*5; end

  slat=sin(pi.*lat./180);
  % Satellite amplitude ratio adjustment for latitude. 

  rr=sat.amprat;           % no amplitude correction

  if isfinite(lat),
    j=find(sat.ilatfac==1); % latitude correction for diurnal constituents
    rr(j)=rr(j).*0.36309.*(1.0-5.0.*slat.*slat)./slat;

    j=find(sat.ilatfac==2); % latitude correction for semi-diurnal constituents
    rr(j)=rr(j).*2.59808.*slat;
  else 
    rr(sat.ilatfac>0)=0;
  end;

  % Calculate nodal amplitude and phase corrections.

  uu=rem( sat.deldood*astro(4:6)+sat.phcorr, 1);

  %%uu=uudbl-round(uudbl);  <_ I think this was wrong. The original
  %                         FORTRAN code is:  IUU=UUDBL
  %                                           UU=UUDBL-IUU
  %                         which is truncation.        


  % Sum up all of the satellite factors for all satellites.

  nsat=length(sat.iconst);
  nfreq=length(const.isat);

  fsum=1+sum(sparse([1:nsat],sat.iconst,rr.*exp(i*2*pi*uu),nsat,nfreq)).';

  f=abs(fsum);
  u=angle(fsum)./(2.*pi);

  % Compute amplitude and phase corrections for shallow water constituents. 

  for k=find(isfinite(const.ishallow))',
    ik=const.ishallow(k)+[0:const.nshallow(k)-1];
    f(k)=prod(f(shallow.iname(ik)).^abs(shallow.coef(ik)));
    u(k)=sum( u(shallow.iname(ik)).*shallow.coef(ik) );
    v(k)=sum( v(shallow.iname(ik)).*shallow.coef(ik) );
  end;

  f=f(ju);
  u=u(ju);
  v=v(ju);

else % Astronomical arguments only.

  % Compute for shallow water constituents.
  for k=find(finite(const.ishallow))',
    ik=const.ishallow(k)+[0:const.nshallow(k)-1];
    v(k)=sum( v(shallow.iname(ik)).*shallow.coef(ik) );
  end;
  v=v(ju);
  f=ones(size(v));
  u=zeros(size(v));
end;


function [astro,ader] = t_astron(jd)
% T_ASTRON Computes astronomical Variables
% [A,ADER] = ASTRON(JD) computes the astronomical variables 
%            A=[tau,s,h,p,np,pp] (cycles) 
%  and their time derivatives 
%            ADER=[dtau,ds,dh,dp,dnp,dpp] (cycles/day) 
%  at the matlab time JD (UTC, but see code for details) where
%
%  tau = lunar time
%	s = mean longitude of the moon
%	h = mean longitude of the sun
%	p = mean longitude of the lunar perigee 
%	np = negative of the longitude of the mean ascending node
%	pp = mean longitude of the perihelion (solar perigee)   
%

%
%    The formulae for calculating these ephemerides (other than tau) 
%    were taken from pages 98 and 107 of the Explanatory Supplement to
%    the Astronomical Ephemeris and the American Ephemeris and Nautical 
%    Almanac (1961). They require EPHEMERIS TIME (ET), now TERRESTRIAL 
%    TIME (TT) and are based on observations made in the 1700/1800s.
%    In a bizarre twist, the current definition of time is derived
%    by reducing observations of planetary motions using these formulas.
%
%    The current world master clock is INTERNATIONAL ATOMIC TIME (TAI).
%    The length of the second is based on inverting the actual 
%    locations of the planets over the period 1956-65 into "time" 
%    using these formulas, and an offset added to keep the scale 
%    continuous with previous defns. Thus
%
%                     TT = TAI + 32.184 seconds.
%
%    Universal Time UT is a time scale that is 00:00 at midnight (i.e.,
%    based on the earth's rotation rather than on planetary motions).
%    Coordinated Universal Time (UTC) is kept by atomic clocks, the 
%    length of the second is the same as for TAI but leap seconds are
%    inserted at intervals so that it provides UT to within 1 second. 
%    This is necessary because the period of the earth's rotation is 
%    slowly increasing (the day was exactly 86400 seconds around 1820, 
%    it is now about 2 ms longer). 22 leap seconds have been added in 
%    the last 27 years.
%
%    As of 1/1/99,    TAI = UTC + 32 seconds.
%       
%    Thus,             TT = UTC + 62.184 seconds
%
%    GPS time was synchronized with UTC 6/1/1980 ( = TAI - 19 secs), 
%    but is NOT adjusted for leap seconds. Your receiver might do this
%    automatically...or it might not.
%
%    Does any of this matter? The moon longitude is the fastest changing
%    parameter at 13 deg/day. A time error of one minute implies a
%    position error of less than 0.01 deg. This would almost always be 
%    unimportant for tidal work.
%
%    The lunar time (tau) calculation requires UT as a base.  UTC is 
%    close enough - an error of 1 second, the biggest difference that
%    can occur between UT and UTC, implies a Greenwich phase error of 
%    0.01 deg.  In Doodson's definition (Proc R. Soc. A, vol 100, 
%    reprinted in International Hydrographic Review, Appendix to 
%    Circular Letter 4-H, 1954) mean lunar time is taken to begin at 
%    "lunar midnight". 

% B. Beardsley  12/29/98, 1/11/98
% R. Pawlowicz  9/1/01
% Version 1.0


% Compute number of days from epoch of 12:00 UT Dec 31, 1899.
% (January 0.5 1900 ET)
d=jd(:)'-datenum(1899,12,31,12,0,0);
D=d/10000;

% Compute astronomical constants at time d1.
args=[ones(size(jd));
      d;
      D.*D;
      D.^3];

% These are the coefficients of the formulas in the Explan. Suppl.

sc= [ 270.434164,13.1763965268,-0.0000850, 0.000000039];
hc= [ 279.696678, 0.9856473354, 0.00002267,0.000000000];
pc= [ 334.329556, 0.1114040803,-0.0007739,-0.00000026];
npc=[-259.183275, 0.0529539222,-0.0001557,-0.000000050];
%  first coeff was 281.220833 in Foreman but Expl. Suppl. has 44.
ppc=[ 281.220844, 0.0000470684, 0.0000339, 0.000000070];

% Compute the parameters; we only need the factional part of the cycle.
astro=rem( [sc;hc;pc;npc;ppc]*args./360.0 ,1);

% Compute lunar time tau, based on fractional part of solar day.
% We add the hour angle to the longitude of the sun and subtract the
% longitude of the moon.
tau=rem(jd(:)',1)+astro(2,:)-astro(1,:);
astro=[tau;astro];

% Compute rates of change.
dargs=[zeros(size(jd));
       ones(size(jd));
       2.0e-4.*D;
       3.0e-4.*D.*D];

ader=[sc;hc;pc;npc;ppc]*dargs./360.0;

dtau=1.0+ader(2,:)-ader(1,:);

ader=[dtau;ader];


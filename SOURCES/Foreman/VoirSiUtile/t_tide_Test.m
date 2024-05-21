%%
function [nameu,fu,tidecon,xout]=t_tide(BolFig,fichierGlobal,fichierS,xin,t,varargin);

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
secular='lin';
inf.iname=[];
inf.irefname=[];
shallownames=[];
constitnames=[];
errcalc='cboot';
synth=2;

xin=xin(:); % makes xin a column vector : xin=tuk_elev, valeur des données
nobs=length(xin);

centraltime=t(1);

% -------Get the frequencies to use in the harmonic analysis-----------
nameu=['K1','M2','S2','M4']
fu=[0.0418;0.0805;0.0833;0.1610]

%----------------------------------------------------------------------
% Now solve for the secular trend plus the analysis. Instead of solving
% for + and - frequencies using exp(i*f*t), I use sines and cosines to 
% keep tc real.  If the input series is real, than this will 
% automatically use real-only computation. However, for the analysis, 
% it's handy to get the + and - frequencies ('ap' and 'am'), and so 
% that's what we do afterwards.

tc=[ones(length(t),1) t cos((2*pi)*t*fu') sin((2*pi)*t*fu') ];

coef=tc(:,:)\xin(:);

res=xin(:)-tc(:,:)*coef;
'res',nanmean(abs(res))

%----------------------------------------------------------------------
% Check variance explained (but do this with the original fit).

xout=tc*coef;  % This is the time series synthesized from the analysis
xres=xin-xout; % and the residuals! 
plot(t,xin,'b',t,xout,'r')



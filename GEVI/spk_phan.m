%%% UPLOAD PREPROCESSED SIGNAL FROM PYTHON PREPROCESSING
%%% (jedi_preprocessing_v2.ipynb)

% calcium_full = {mls_bfilt_zscr_gaus};
% calcium =  calcium_full{1}(100000:200000); % shorten for analysis
% 
% calcium_full = {alberto_mls_bfilt_zscr_gaus};
% calcium =  calcium_full{1}(:); % shorten for analysis

calcium_full = {nikolai_mlspk_bfilt_zscr_gaus};
calcium =  calcium_full{1}(500000:510000); % shorten to 100000:200000 for analysis 
 
%% 
%%% SET PARAMETERS  

%%% Parameters from Villette paper
% a = .19 
% tau = 0.0012494 
% ton = 0.00079444 
% sigma = 0.0415
% drift = 0.20722
% dt = 0.0002 

%%% Parameters for JC data
% calcium =  calcium_full{1}(100000:200000); 
% a = 2.6 % 
% tau = 0.018 % 0.02: 66sp/20s, 0.01: 16
% ton = 0.005 % rise
% sigma = .4 % autocalibration gave huge number.  In mlspike paper, usually range .001 to .4
% drift = 0.0 % removed drift (butterworth) in python
% dt = 0.0002 % .0002 = 1 / 5000 Hz 

%%% Parameters for Alberto data
% calcium =  calcium_full{1}(100000:200000); 
% a = 4 
% tau = 0.013 
% ton = 0.005 
% sigma = .4
% drift = 0.0 
% dt = 0.0004 

%%% Parameters for Nikolas
calcium =  calcium_full{1}(100000:200000); 
a = 4 % amplitude from villette paper
tau = .9 % 0.02: 66sp/20s, 0.01: 16, % decay from villette paper
ton = .03 % rise
sigma = .00300 % autocalibration gave huge number.  In mlspike paper, usually range .001 to .4
drift = 0.0 % removed drift (butterworth) in python
dt = 0.00035 % 5000 Hz 

%% 

par = tps_mlspikes('par');
par.dt = dt; % (indicate the frame duration of the data)

% (set physiological parameters)
par.a = a; % DF/F for one spike
par.tau = tau; % decay time constant (second)
par.saturation = 0.1; % OGB dye saturation

% (set noise parameters)
par.finetune.sigma = sigma; 
par.drift.parameter = drift; 
% (do not display graph summary)
par.dographsummary = true;

% spike estimation
[spikest fit drift] = spk_est(calcium,par);

% display
figure(1)
% spk_display(dt,{spikes spikest},{calcium fit drift})
spk_display(dt,{spikest},{calcium fit drift})

set(1,'numbertitle','off','name','MLspike alone')

%% Auto-calibration

spike_iso = calcium_full{1}(500000:510000)

% parameters
% (get default parameters and set frame duration)
pax = spk_autocalibration('par');
pax.dt = dt;
% (set limits for A and tau)
pax.amin = 4;
pax.amax = 6;
pax.taumin = 0;
pax.taumax = 2;
% (set saturation parameter)
pax.saturation = 0.1;

% (when running MLspike from spk_autocalibratio, do not display graph summary)
pax.mlspikepar.dographsummary = true;

% perform auto-calibration
[tauest aest sigmaest] = spk_autocalibration(calcium,pax)

% Load hdf5 file
data = loadCampaign('./ChrisFreierPhDCampaigns/campaign4.h5');

% Remove spurious data
t_cutoff = 3.633399834260200e+09;
t_delay  = 100e-3; % This is the same as in get_acc_ind
data = get_preprocessed_data(data,t_cutoff,t_delay);

% Assign subsequence of accelerometer indicies to each value in ai_kup
inds = get_acc_inds(data);

% Construct accelerometer subsequences for each value in ai_kup
subseqs = get_acc_subsequences(data,inds);

% Correct drift in ai_kup, ai_kdown
data = getDriftCorrection(data);

% Write to file
write_all_hdf5(data,subseqs,'campaign4_proc_trunc.h5')
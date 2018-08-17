% Load hdf5 file
data = loadCampaign;

% Remove spurious data
data = get_preprocessed_data_4a(data);

% Assign subsequence of accelerometer indicies to each value in ai_kup
inds = get_acc_inds(data);

% Construct accelerometer subsequences for each value in ai_kup
subseqs = get_acc_subsequences(data,inds);

% Correct drift in ai_kup, ai_kdown
data = getDriftCorrection(data);

% Write to file
write_all_hdf5(data,subseqs,'campaign4a_proc.h5')
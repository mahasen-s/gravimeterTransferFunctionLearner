function data = getDriftCorrection(data)
% Subtract long-term drifts from accelerometer data (corresponding to tidal
% stuff

% Averaging window: 30 min
time_window = 30*60;


% Get bin edges
acc_edges   = [-Inf; mean([data.acc(2:end,1), data.acc(1:end-1,1)],2); +Inf];

% Get window forward/backward limit
acc_fwd_lim     = data.acc(:,1) + time_window/2;
acc_bwd_lim     = data.acc(:,1) - time_window/2;

% Get indices of fwd/bwd lims
inds_fwd        = discretize(acc_fwd_lim,acc_edges);
inds_bwd        = discretize(acc_bwd_lim,acc_edges);

% Get mean of each interval
n_pts           = size(data.acc,1);
moving_avg      = zeros(size(data.acc,1),1);
moving_avg(1)   = sum(data.acc(inds_bwd(1):inds_fwd(1),2));
tic
for i=2:n_pts
    moving_avg(i)   =   moving_avg(i-1)...
                        - sum(data.acc(inds_bwd(i-1):inds_bwd(i),2))...
                        + sum(data.acc((inds_fwd(i-1)+1):inds_fwd(i),2));
    if mod(i,1e5)==0
        fprintf('Progress : %4.3f%%\n',100*i/n_pts)
    end
end
moving_avg_norm     = inds_fwd-inds_bwd;
moving_avg          = moving_avg./moving_avg_norm;
moving_avg_corrected= data.acc(:,2)-moving_avg;

data.acc        = cat(2,data.acc,moving_avg,moving_avg_corrected);


end
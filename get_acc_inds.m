function inds = get_acc_inds(data)
% Assign subsequence of accelerometer indices to each value in ai_u, and
% ai_d.
% We pick some time delat t_delay corresponding to a phase offset in the
% transfer function
tic
t_delay     = 100e-3; % ~ 30 points

% Noting that accelerometer data is not evenly spaced, we pre-compute the
% center of bins that we later use with discretize
acc_edges   = [-Inf; mean([data.acc(2:end,1), data.acc(1:end-1,1)],2); +Inf];

% Compute nearest accelerometer timestamp for each ai_u, ai_d timestamp
% (i.e. at center of pi pulse)
inds_u      = discretize(data.ai_u(:,1),acc_edges);
inds_d      = discretize(data.ai_d(:,1),acc_edges);

% Compute nearest accelerometer timestamp for each ai_u, ai_d timestamp
% at end of interferometer (i.e. timestamp + T + tau)
t_offset   = data.T + data.tau;
inds_u_end = discretize(data.ai_u(:,1)+t_offset,acc_edges);
inds_d_end = discretize(data.ai_d(:,1)+t_offset,acc_edges);

% Compute nearest accelerometer timestamp for each ai_u, ai_d timestamp
% at before interferometer (i.e. timestamp - T - tau - t_delay)
t_offset   = -(data.T + data.tau + t_delay);
inds_u_ini = discretize(data.ai_u(:,1)+t_offset,acc_edges);
inds_d_ini = discretize(data.ai_d(:,1)+t_offset,acc_edges);

time_elapsed = toc;
fprintf('Time taken: %4.3f\n\n',time_elapsed)

inds       = struct('inds_u',inds_u,...
                    'inds_d',inds_d,...
                    'inds_u_end',inds_u_end,...
                    'inds_d_end',inds_d_end,...
                    'inds_u_ini',inds_u_ini,...
                    'inds_d_ini',inds_d_ini,...
                    't_delay',t_delay);
                    
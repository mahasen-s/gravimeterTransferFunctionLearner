function data = getDriftCorrection(data)
% THIS IS NOT CORRECT; there are sharp shifts at the boundaries, and a
% general positive drift.

% Subtract long-term drifts from accelerometer data (corresponding to tidal
% stuff


% Averaging window: 30 min
time_window = 30*60;

ai_u_smooth       = smoothdata(data.ai_u(:,2),'movmean',time_window,'SamplePoints',data.ai_u(:,1));
ai_d_smooth       = smoothdata(data.ai_d(:,2),'movmean',time_window,'SamplePoints',data.ai_d(:,1));

ai_u_corr         = data.ai_u(:,2)-ai_u_smooth;
ai_d_corr         = data.ai_d(:,2)-ai_d_smooth;

%acc_smooth_irreg    = smoothdata(data.acc(:,2),'movmean',time_window,'SamplePoints',data.acc(:,1));

data.ai_u         = cat(2,data.ai_u,ai_u_smooth,ai_u_corr);
data.ai_d         = cat(2,data.ai_d,ai_d_smooth,ai_d_corr);
end
function data = get_preprocessed_data_4a(data)
% We need to throwaway all points before a certain time since the data is
% corrupted by temperature changes.
t_cutoff = 3.633399834260200e+09;
t_delay  = 100e-3; % This is the same as in get_acc_inds

t_cutoff_ai     = t_cutoff+t_delay+data.T+2*data.tau;

cut_fun         = @(x,t) x(x>t,:);

data.acc        = cut_fun(data.acc,t_cutoff);
data.ai_u       = cut_fun(data.ai_u,t_cutoff_ai);
data.ai_d       = cut_fun(data.ai_d,t_cutoff_ai);

% Remove duplicates

end
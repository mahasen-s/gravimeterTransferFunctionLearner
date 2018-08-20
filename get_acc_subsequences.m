function subseqs = get_acc_subsequences(data,inds)
% Construct accelerometer subsequences given the indices given by the 
% the output of get_acc_inds(data)

% We need uniformly sized sequences, so lets fix all lengths by the maximum
% For campaign4a.h5, there are between 2-3 unique sequence lengths

% Column of data.acc,data.ai_kup/kdown we are taking subsequences from
acc_col             = 2;

first_half_length   = max(cat(1,inds.inds_u-inds.inds_u_ini,inds.inds_d-inds.inds_d_ini));
second_half_length  = max(cat(1,inds.inds_u_end-inds.inds_u,inds.inds_d_end-inds.inds_d));
subseq_length       = first_half_length + second_half_length;

% Reassign indices
inds.inds_u_init    = inds.inds_u - first_half_length;
inds.inds_d_init    = inds.inds_d - first_half_length;
inds.inds_u_end     = inds.inds_u + second_half_length;
inds.inds_d_end     = inds.inds_d + second_half_length;

% Construct subsequences
N_u                 = size(data.ai_u,1);
N_d                 = size(data.ai_d,1);
acc_subseq_u        = zeros(subseq_length,size(data.ai_u,1));
acc_subseq_d        = zeros(subseq_length,size(data.ai_d,1));

for i=1:N_u
    acc_subseq_u(:,i)   = data.acc(inds.inds_u_init(i)+1:inds.inds_u_end(i),acc_col);
    if mod(i,100)==0
        fprintf('%4.3f%%\n',100*i/N_u)
    end
end

for i=1:N_d
    acc_subseq_d(:,i)   = data.acc(inds.inds_d_init(i)+1:inds.inds_d_end(i),acc_col);
    if mod(i,100)==0
        fprintf('%4.3f%%\n',100*i/N_d)
    end
end

subseqs             = struct(   'acc_subseq_u',acc_subseq_u,...
                                'acc_subseq_d',acc_subseq_d,...
                                'inds',inds);


end
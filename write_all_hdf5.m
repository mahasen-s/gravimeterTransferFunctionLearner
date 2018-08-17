function write_all_hdf5(data,subseqs,fname)

% writes ai_kup, ai_kdown, and associated subsequences to h5 with name
% fname

% Col to use for labels in ai_kup, ai_kdown
ai_col  = 4;

% Write to hdf5
hdf5write(  fname,...
            '/ai_kup/timestamp',data.ai_u(:,1),...
            '/ai_kup/phase',data.ai_u(:,ai_col),...
            '/ai_kup/acc',subseqs.acc_subseq_u,...     %transpose for col-major->row-major
            '/ai_kdown/timestamp',data.ai_d(:,1),...
            '/ai_kdown/phase',data.ai_d(:,ai_col),...
            '/ai_kdown/acc',subseqs.acc_subseq_d,...           
            '/T',data.T,...
            '/tau',data.tau)
            




end
function data = loadTransferFunc(fname)
if ~exist('fname','var')
    fname = './campaign4a_kup_transferfun.h5';
end
fname
t           = h5read(fname,'/t');
phases      = h5read(fname,'/phases');
freqs       = h5read(fname,'/freqs');
output      = h5read(fname,'/output');


data        = struct(   't',t,...
                        'phases',phases,...
                        'freqs',freqs,...
                        'output',output);
                    

                    
end
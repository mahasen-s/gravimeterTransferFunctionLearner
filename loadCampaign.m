function data = loadCampaign(fname)
if ~exist('fname','var')
    fname = './ChrisFreierPhDCampaigns/campaign4a.h5';
end
fprintf('Loading %s\n',fname)

acc             = h5read(fname,'/accelerometer');
ai_kdown        = h5read(fname,'/ai_kdown');
ai_kup          = h5read(fname,'/ai_kup');

t_temp          = h5read(fname,'/(T,tau)');
T               = t_temp(1);
tau             = t_temp(2);


data            = struct(   'acc',acc',...
                            'ai_d',ai_kdown',...
                            'ai_u',ai_kup',...
                            'T',T,...
                            'tau',tau);
end
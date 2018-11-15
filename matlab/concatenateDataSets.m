function concatenateDataSets(fileList,fileOut)
nFiles = numel(fileList);

% Read in
for i=1:nFiles
    fname = fileList{i};
    fprintf('Reading file %s\n',fname);
   if i==1
       acc             = h5read(fname,'/accelerometer');
       ai_kup          = h5read(fname,'/ai_kup');
       ai_kdown        = h5read(fname,'/ai_kdown');
       t_temp          = h5read(fname,'/(T,tau)');
   else
       acc             = cat(2,acc,h5read(fname,'/accelerometer'));
       ai_kup          = cat(2,ai_kup,h5read(fname,'/ai_kup'));
       ai_kdown        = cat(2,ai_kdown,h5read(fname,'/ai_kdown'));
   end
    
end

% Remove duplicates
fprintf('Removing duplicate timestamps . . .\n')
acc      = removeDuplicates(acc');
ai_kup   = removeDuplicates(ai_kup');
ai_kdown = removeDuplicates(ai_kdown');

% Write out
hdf5write( fileOut,...
    '/accelerometer',acc',...
    '/ai_kup',ai_kup',...
    '/ai_kdown',ai_kdown',...
    '/(T,tau)',t_temp)

end


function data = removeDuplicates(data)
% Removes any duplicate rows based on timestamp
[~,ia,~] = unique(data(:,1));
data     = data(ia,:);

end

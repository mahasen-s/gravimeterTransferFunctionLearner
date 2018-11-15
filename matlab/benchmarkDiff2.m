function benchmarkDiff2()
n_samples   = 100;
n_max       = 1e4;

ch1 = genSortedSample(n_samples,n_max); % e.g. timestamps
ch2 = genSortedSample(2*n_samples,n_max); 
ch3 = genSortedSample(2*n_samples,n_max); 

tic

% Get ch1 edges
edges   = [-Inf; mean([ch1(2:end), ch1(1:end-1)],2); +Inf];

% Sort into bins. `dicretize(x,y)` returns the index of the histogram bin
% (with edges given by `y`) for each element of `x`.
inds_ch2= discretize(ch2,edges);
inds_ch3= discretize(ch3,edges);

% Compute differences between ch2, ch3 and nearest ch1 value
diff_ch2= ch1(inds_ch2)-ch2;
diff_ch3= ch1(inds_ch3)-ch3;
t_taken = toc;

% Suppose our window width is 50
window_width        = 50;
within_window_ch2   = abs(diff_ch2)<window_width;
within_window_ch3   = abs(diff_ch3)<window_width;

% Now we want to count the number of values in ch2, ch3 (within 
% `window_width`) assigned to each bin in ch1. It'll be easist to play a
% trick and histogram inds_ch2, inds_ch3 using bins which correspond to the
% index in ch1
ch1_inds        = (1:numel(ch1))';
edges_ch1_inds  = [-Inf; mean([ch1_inds(2:end), ch1_inds(1:end-1)],2); +Inf];

ch2_counts      = histcounts(inds_ch2(within_window_ch2),edges_ch1_inds);
ch3_counts      = histcounts(inds_ch3(within_window_ch3),edges_ch1_inds);

% ch2_counts(i) gives the number of values of ch2 which fall within
% `window_width` of ch1(i), and vice versa for ch3_counts

% So if we wanted to know which values of ch1 have at least one value of
% ch2 and ch3 within `window_width`, we could calculate:
coincidence     = ch2_counts&ch3_counts




fprintf('Time taken = %4.3f\n',t_taken)

end

function out = genSortedSample(n_samples,n_max)
% Returns a sorted list of integers between in [0,n_max], sampled without
% replacement
out = sort(datasample(1:n_max,n_samples));
out = out(:); % flatten
end


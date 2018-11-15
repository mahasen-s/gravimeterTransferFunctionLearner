function benchmarkDiscretize(acc,ai_u)

Nlist   = [10,100,1000,10000,100000,size(ai_u,1)];
Y       = acc(:,1);
edges   = [-Inf; mean([Y(2:end), Y(1:end-1)],2); +Inf];
tlist   = zeros(numel(Nlist),1);

for i=1:numel(Nlist)
    N   = Nlist(i);
    tic
    inds2   = discretize(ai_u(1:N,1),edges);
    tlist(i) = toc
end
    
    
function benchmarkDiff(acc,ai_u)


N       = 1000;
inds0   = zeros(N,1);
inds1   = zeros(N,1);
inds2   = zeros(N,1);

X   = ai_u(1:N,1);
Y   = acc(:,1);

% method1
tic
for i=1:N
    [~,I]       = min(abs(Y-X(i)));
    inds0(i)    = I;
end
t0 = toc

% method2
tic
inds1 = interp1(Y, 1:numel(Y), X, 'nearest', 'extrap');
t1 = toc

%method3
edges = [-Inf; mean([Y(2:end), Y(1:end-1)],2); +Inf];
tic
inds2   = discretize(X,edges);
t2 = toc

% % method4
% tic
% inds3 = nearestpoint(X, Y) ;
% t3 = toc

sum(abs(inds0-inds1))
sum(abs(inds0-inds2))
%sum(abs(inds0-inds3))


function I = minfunc(a)
[~,I]    = min(abs(acc(:,1)-a));
end

end


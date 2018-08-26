function plotTransferFunc(data)
figure(1)
clf

subplot(1,2,2)
[m,inds] = max(data.output,[],2);
h_max = plot(data.freqs,m,'ro');
set(gca,'xscale','log')
grid on
ylabel('\textbf{Max predicted $\phi_{vib}$}','interpreter','latex','fontsize',16)
xlabel('\textbf{Frequency (Hz)}','interpreter','latex','fontsize',16)

% Plot freq and phase
subplot(1,2,1)
h_cmap = pcolor(data.freqs,data.phases,data.output');
h_cmap.EdgeColor = 'none';
hold on
h_pts =plot(data.freqs,data.phases(inds),'ro')
set(gca,'xscale','log')
xlabel('\textbf{Frequency (Hz)}','interpreter','latex','fontsize',16)
ylabel('\textbf{Phase}','interpreter','latex','fontsize',16)

set(gcf,'color','w')

end
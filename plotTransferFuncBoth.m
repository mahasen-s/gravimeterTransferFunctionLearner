function plotTransferFuncBoth(data1,data2)
figure(1)
clf

%subplot(1,2,1)
hold on
[m,inds] = max(data1.output,[],2);
h_up = plot(data1.freqs,m,'o');
[m,inds] = max(data2.output,[],2);
h_down = plot(data1.freqs,m,'o');
set(gca,'xscale','log')
grid on
box on
ylabel('\textbf{Max predicted $\phi_{vib}$}','interpreter','latex','fontsize',16)
xlabel('\textbf{Frequency (Hz)}','interpreter','latex','fontsize',16)
title('\textbf{ai\_kup}','fontsize',18,'interpreter','latex')
h_leg = legend({'\textbf{ai\_kup}','\textbf{ai\_kdown}'},'location','NorthWest')
set(h_leg,'interpreter','latex','fontsize',14)

% subplot(1,2,2)
% [m,inds] = max(data2.output,[],2);
% h_max = plot(data2.freqs,m,'ro');
% set(gca,'xscale','log')
% grid on
% ylabel('\textbf{Max predicted $\phi_{vib}$}','interpreter','latex','fontsize',16)
% xlabel('\textbf{Frequency (Hz)}','interpreter','latex','fontsize',16)
% title('\textbf{ai\_kdown}','fontsize',18,'interpreter','latex')


set(gcf,'color','w')

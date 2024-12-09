fig1 = openfig('Time vs sample_2D.fig');
title('Computation Time vs sample size for d = 2');
xlabel('Sample Size');
savefig(fig1, 'Time vs sample_2D_new.fig');
saveas(fig1, 'Time vs sample_2D_new.png');
fig2 = openfig('Time vs sample_3D.fig');
title('Computation Time vs sample size for d = 3');
xlabel('Sample Size');
savefig(fig2, 'Time vs sample_3D_new.fig');
saveas(fig2, 'Time vs sample_3D_new.png');
fig3 = openfig('Time vs sample_4D.fig');
title('Computation Time vs sample size for d = 4');
xlabel('Sample Size');
savefig(fig3, 'Time vs sample_4D_new.fig');
saveas(fig3, 'Time vs sample_4D_new.png');


% parameters for pupillary reflex
% parameters must be corrected
clear all
close all
% define numerical coefficients
D=0.18; %[s]
K1=0.16; 
tau=0.1; % [s]
num=[1];

% define transfer function den and num
den_prod=[tau 1];
den=conv(conv(den_prod,den_prod),den_prod);
% pade for exponential factor
[expon_num_pade,expon_den_pade]  = pade(D,4);
num=conv(num,expon_num_pade);
den=conv(den,expon_den_pade);
% define system and transfer function
sys=tf(num,den);
% calc gain margin:
gainMargin=margin(sys)
disp(['Max gain is ',num2str(gainMargin,3)])
figure;
margin(sys)
% root locus
figure;
rlocusplot(sys)
xlim([-200, 200])
ylim([-300, 300])
% export graphics in pdf 
exportgraphics(figure(1),'figs/margin.pdf','BackgroundColor','none','ContentType','vector');
exportgraphics(figure(2),'figs/rlocus.pdf','BackgroundColor','none','ContentType','vector');


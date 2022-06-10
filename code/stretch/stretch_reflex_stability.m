% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Mastrofini Alessandro
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Medical Engineering - University of Rome Tor Vergata
% Physiological Systems Modeling and Simulation
% F. Caselli, MSSF A.Y. 2021/2022
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Physiological reflex control systems
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

%% stability of stretch reflex system
clear all
close all
% load parameters 
stretch_reflex_parameters % load parameters
% be sure that beta and Td wasn't varyied by simulations
beta=100;
Td=0.02;
% set numerator and denominatot
G_num=1;
G_den=[B*J/k J B];
int=[1 0];
F_num=[tau 1/eta];
F_den=[tau 1];

% set pade expansion for exponentials
[expon_num_pade,expon_den_pade]  = pade(Td,4);

%set taylor expansion for exponentials
syms s
Taylor_order=4;
T = taylor(exp(-s*Td),s);
coff=coeffs(T);
coff=fliplr(coff);
expon_num_taylor=coff(end-(Taylor_order-1):end); %select only the first 4 coefficient
expon_num_taylor=double(expon_num_taylor);
expon_den_taylor=[1];
% set transfer function
num=conv(expon_num_taylor,conv(G_num,F_num));
den=conv(expon_den_taylor,conv(int,conv(G_den, F_den)));
sys=tf(num,den);

% root locus and system gain margin
figure;
rlocusplot(sys)
[root, gain]=rlocus(sys);
Gm_taylor=margin(sys);
figure;
margin(sys)
disp(['Max gain with taylor approximation: ', num2str(Gm_taylor)])

% compare with pade 
num=conv(expon_num_pade,conv(G_num,F_num));
den=conv(expon_den_pade,conv(int,conv(G_den, F_den)));
sys=tf(num,den);
figure;
rlocusplot(sys)
[root, gain]=rlocus(sys);
ylim([-2000,2000]);
xlim([-2000,1000]);
Gm_pade=margin(sys);
figure;
margin(sys)
disp(['Max gain with pade approximation: ', num2str(Gm_pade)])

exportgraphics(figure(3),'figs/rootlocus.pdf','BackgroundColor','none','ContentType','vector');
exportgraphics(figure(4),'figs/margin.pdf','BackgroundColor','none','ContentType','vector');


% parameters for pupillary reflex
% parameters must be corrected
clear all
close all
D=0.18;
K1=0.16;
tau=0.1;
num=[K1];

den_prod=[tau 1];
den=conv(conv(den_prod,den_prod),den_prod);

[expon_num_pade,expon_den_pade]  = pade(D,4);

num=conv(num,expon_num_pade);
den=conv(den,expon_den_pade);

sys=tf(num,den);
gainMargin=margin(sys)
figure;
margin(sys)
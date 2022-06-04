%sys=G*F
stretch_reflex_parameters % load parameters

G_num=1;
G_den=[B*J/k J B];
int=[1 0];
F_num=[tau 1/eta];
F_den=[tau 1];

[expon_num_pade,expon_den_pade]  = pade(Td,4);

syms s

Taylor_order=4;
T = taylor(exp(-s*Td),s);

coff=coeffs(T);
coff=fliplr(coff);
 
expon_num_taylor=coff(end-(Taylor_order-1):end); %select only the first 4 coefficient
expon_num_taylor=double(expon_num_taylor);
expon_den_taylor=[1];

num=conv(expon_num_taylor,conv(G_num,F_num));
den=conv(expon_den_taylor,conv(int,conv(G_den, F_den)));
sys=tf(num,den);
figure;
rlocusplot(sys)
[root, gain]=rlocus(sys);
Gm_taylor=margin(sys);
figure;
margin(sys)
disp(['Max gain with taylor approximation: ', num2str(Gm_taylor)])

num=conv(expon_num_pade,conv(G_num,F_num));
den=conv(expon_den_pade,conv(int,conv(G_den, F_den)));
sys=tf(num,den);
figure;
rlocusplot(sys)
[root, gain]=rlocus(sys);
Gm_pade=margin(sys);
figure;
margin(sys)
disp(['Max gain with pade approximation: ', num2str(Gm_pade)])


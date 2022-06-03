% parameters for pupillary reflex
% parameters must be corrected
D=5;
K1=10;
tau=0.5;
num=[K1];
den_prod=[tau 1];
den=conv(conv(den_prod,den_prod),den_prod);
% tf(num,den)
% parameters for pupillary reflex
% parameters must be corrected
D=0.18;
K1=0.16;
tau=0.1;
num=[K1];
den_prod=[tau 1];
den=conv(conv(den_prod,den_prod),den_prod);

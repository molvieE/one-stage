function [apoge,perige] = orbital_char(spead,coord)
r0=modul_vector(coord);
v0=modul_vector(spead);
u=(3.986*10^5)*(1000^3);%гравитационный параметр в м^3/с^2
[C_vec]=multiplication_vector(spead,coord);
C=modul_vector(C_vec);
C5=(v0^2)-((2*u)/(r0));
p=(C^2)/u;
e0=sqrt(1+((C^2*C5)/u^2));
perige=(p/(1+e0))-6371000;
apoge=(p/(1-e0))-6371000;
end
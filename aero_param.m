function[C]=aero_param(angle_of_attack,C_nominal,C_polinom)
ang=angle_of_attack;
%коэффициент зависимости между Сx и Cx nominal при нулевом угле и реальном угле
koeff=C_polinom(1)+C_polinom(2)*ang+C_polinom(3)*ang^2+C_polinom(4)*ang^3+C_polinom(5)*ang^4;
C=koeff*C_nominal;
end
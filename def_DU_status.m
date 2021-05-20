function[du_status]=def_DU_status(mass_fuel,alt,stage,apoge,perige,hor_ang)
%функция определяющая работает ли ДУ на этом участке полёта
apoge_delta=7000;%при разнице в apoge_delta от апогея установить тангаж 
%так чтобы вектор скорости совпадал с вектором тяги

du_status=false;
if ((stage==1)&&(mass_fuel(1)>0))
du_status=true;
end
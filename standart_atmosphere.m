function [Temp_of_atmosphere,pressure_of_atmosphere,dencity_of_atmosphere] = standart_atmosphere (alt,differential_of_temp)
% функция стандартной атмосферы с учётом отклонения по температуре от 20 градусов по шкале цельсия и радиусе земли
rad_of_earth=6371000;%радиус земли в метрах
Geopotential_alt = (rad_of_earth*alt)/(rad_of_earth+alt);% определение геопотенциальной высоты
gas_const = 8.314 ; % ввод значения универсальной газовой постоянной
acceleration_of_gravity = 9.806 ;% ввод значения ускорения свободного падения
molar_mass_of_atmosphere = 0.0289644;% молятная масса атмосферы земли
specific_gas_constant = 287.052 ;% газовая постоянная для воздуха
if (Geopotential_alt>=0) && (Geopotential_alt < 11000)% база значений для вычислений
    base_alt = 0;%базовая высота
    base_pressure=101325;%базовое давление
    base_temp =288.15+differential_of_temp;% базовая температура
    vertical_gradient_of_temp = -6.5 ;% вертикальный температурный градиент
end
if (Geopotential_alt>=11000) && (Geopotential_alt < 20000)
    base_alt = 11000;
    base_pressure = 22632.06;
    base_temp = 216.65 + differential_of_temp;
    vertical_gradient_of_temp=0;
end
if (Geopotential_alt>=20000) && (Geopotential_alt < 32000)
    base_alt =20000 ;
    base_pressure = 5474.889;
    base_temp = 216.65 + differential_of_temp;
    vertical_gradient_of_temp = +1;
end
if (Geopotential_alt>=32000) && (Geopotential_alt < 47000)
    base_alt =32000;
    base_pressure = 868.0187;
    base_temp = 228.65 + differential_of_temp;
    vertical_gradient_of_temp = +2.8;
end
if (Geopotential_alt>=47000) && (Geopotential_alt <51000)
    base_alt =47000 ;
    base_pressure = 110.9063 ;
    base_temp = 270.65 + differential_of_temp;
    vertical_gradient_of_temp = 0;
end
if (Geopotential_alt>=51000) && (Geopotential_alt <71000)
    base_alt =51000 ;
    base_pressure = 66.93887 ;
    base_temp =270.65 + differential_of_temp;
    vertical_gradient_of_temp = -2.8;
end
if (Geopotential_alt>=71000) && (Geopotential_alt <85000)
    base_alt =71000;
    base_pressure = 3.956420;
    base_temp =214.65 + differential_of_temp;
    vertical_gradient_of_temp = -2;
end
if (Geopotential_alt>=85000) %эта высота не считается калькулятором выше неё принимается пустота
    vertical_gradient_of_temp= -90 ;
end
if vertical_gradient_of_temp == 0 % рассматривается случай при котором температура не зависит от высоты
    Temp_of_atmosphere = base_temp + vertical_gradient_of_temp*(Geopotential_alt-base_alt);% определение температуры 
    numerator_0 = - acceleration_of_gravity * molar_mass_of_atmosphere *(Geopotential_alt-base_alt);% числитель в длинной записи
    denumerator_0 = gas_const*base_temp;% знаменатель в длинной записи
    parameter_0 = exp(numerator_0/denumerator_0); % коэффициент домножения давления
    pressure_of_atmosphere = base_pressure * parameter_0;% определение давления атмосферы
    dencity_of_atmosphere = pressure_of_atmosphere /(specific_gas_constant*Temp_of_atmosphere);% определение плотности атмосферы
end
if vertical_gradient_of_temp == -2.8||vertical_gradient_of_temp== -2 ||vertical_gradient_of_temp== 2.8||vertical_gradient_of_temp== -6.5||vertical_gradient_of_temp== 1% рассматривается случай при котором температура зависит от высоты
    vertical_gradient_of_temp=vertical_gradient_of_temp/1000;
    Temp_of_atmosphere = base_temp + vertical_gradient_of_temp*(Geopotential_alt-base_alt);%определение температуры
    power_of_parameter_1 = (acceleration_of_gravity * molar_mass_of_atmosphere)/(gas_const* vertical_gradient_of_temp);%определение степени коэффициента давления
    parameter_1 = (base_temp/Temp_of_atmosphere)^power_of_parameter_1;% определение коэффициента давления
    pressure_of_atmosphere = base_pressure * parameter_1; %определение давления атмосферы
    dencity_of_atmosphere = pressure_of_atmosphere /(specific_gas_constant*Temp_of_atmosphere);% определение плотности атмосферы
end
if vertical_gradient_of_temp == -90 % задаёт параметры для не считаемой высоты
    Temp_of_atmosphere = 0;
    pressure_of_atmosphere=0;
    dencity_of_atmosphere=0;
end
end
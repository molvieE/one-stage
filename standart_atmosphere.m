function [Temp_of_atmosphere,pressure_of_atmosphere,dencity_of_atmosphere] = standart_atmosphere (alt,differential_of_temp)
% ������� ����������� ��������� � ������ ���������� �� ����������� �� 20 �������� �� ����� ������� � ������� �����
rad_of_earth=6371000;%������ ����� � ������
Geopotential_alt = (rad_of_earth*alt)/(rad_of_earth+alt);% ����������� ���������������� ������
gas_const = 8.314 ; % ���� �������� ������������� ������� ����������
acceleration_of_gravity = 9.806 ;% ���� �������� ��������� ���������� �������
molar_mass_of_atmosphere = 0.0289644;% �������� ����� ��������� �����
specific_gas_constant = 287.052 ;% ������� ���������� ��� �������
if (Geopotential_alt>=0) && (Geopotential_alt < 11000)% ���� �������� ��� ����������
    base_alt = 0;%������� ������
    base_pressure=101325;%������� ��������
    base_temp =288.15+differential_of_temp;% ������� �����������
    vertical_gradient_of_temp = -6.5 ;% ������������ ������������� ��������
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
if (Geopotential_alt>=85000) %��� ������ �� ��������� ������������� ���� �� ����������� �������
    vertical_gradient_of_temp= -90 ;
end
if vertical_gradient_of_temp == 0 % ��������������� ������ ��� ������� ����������� �� ������� �� ������
    Temp_of_atmosphere = base_temp + vertical_gradient_of_temp*(Geopotential_alt-base_alt);% ����������� ����������� 
    numerator_0 = - acceleration_of_gravity * molar_mass_of_atmosphere *(Geopotential_alt-base_alt);% ��������� � ������� ������
    denumerator_0 = gas_const*base_temp;% ����������� � ������� ������
    parameter_0 = exp(numerator_0/denumerator_0); % ����������� ���������� ��������
    pressure_of_atmosphere = base_pressure * parameter_0;% ����������� �������� ���������
    dencity_of_atmosphere = pressure_of_atmosphere /(specific_gas_constant*Temp_of_atmosphere);% ����������� ��������� ���������
end
if vertical_gradient_of_temp == -2.8||vertical_gradient_of_temp== -2 ||vertical_gradient_of_temp== 2.8||vertical_gradient_of_temp== -6.5||vertical_gradient_of_temp== 1% ��������������� ������ ��� ������� ����������� ������� �� ������
    vertical_gradient_of_temp=vertical_gradient_of_temp/1000;
    Temp_of_atmosphere = base_temp + vertical_gradient_of_temp*(Geopotential_alt-base_alt);%����������� �����������
    power_of_parameter_1 = (acceleration_of_gravity * molar_mass_of_atmosphere)/(gas_const* vertical_gradient_of_temp);%����������� ������� ������������ ��������
    parameter_1 = (base_temp/Temp_of_atmosphere)^power_of_parameter_1;% ����������� ������������ ��������
    pressure_of_atmosphere = base_pressure * parameter_1; %����������� �������� ���������
    dencity_of_atmosphere = pressure_of_atmosphere /(specific_gas_constant*Temp_of_atmosphere);% ����������� ��������� ���������
end
if vertical_gradient_of_temp == -90 % ����� ��������� ��� �� ��������� ������
    Temp_of_atmosphere = 0;
    pressure_of_atmosphere=0;
    dencity_of_atmosphere=0;
end
end
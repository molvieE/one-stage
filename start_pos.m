function [Earth_coord,Earth_spead] = start_pos(tangage,latitude_start,height_start,asimut,spead_start)
%%const
rad_Earth=6371000;%
pi=3.1415926;
rot_spead=465;
%векторы [x,y,z]
inter_point=[0,0,0];%координаты точки пересечения касательной плоскости c осью OZ
asimut_vector=[0,0,0];%вектор направленный на ось OZ
asimut_vector_norm=[0,0,0];%вектор нормальный к вектору азимута
%%
%векторы [x,y]
spead=[0,0];% координаты в касательной системе координат
%%
latitude_start=latitude_start*pi/180;
asimut=asimut*pi/180;
tangage=tangage*pi/180;
spead_start_hor=spead_start*cos(tangage);%скорость в горизонтальной плоскости
spead_start_vert=spead_start*sin(tangage);%скорость в вертикальной плоскости
%%координаты x y z в декартовой системме координат с центром в центре земле
Earth_coord(3)=(height_start+rad_Earth)*sin(latitude_start);
Earth_coord(2)=(height_start+rad_Earth)*cos(latitude_start);
%%
%плоскость паралельная поверхности земли в этой точке
C_tang=Earth_coord(3)/sqrt(Earth_coord(1)^2+Earth_coord(2)^2+Earth_coord(3)^2);%коэффициент C касательной плоскости в точке старта
D_tang=-sqrt(Earth_coord(1)^2+Earth_coord(2)^2+Earth_coord(3)^2);%коэффициент D касательной плоскости в точке старта
inter_point(3)=-D_tang/C_tang;%координата точки пересечения касательной плоскости с осью OZ
%
asimut_vector=inter_point-Earth_coord;%вычисление вектора азимута
[asimut_vector]=ort_vector(asimut_vector);%вычисление орта вектора азимута
[asimut_vector_norm]=multiplication_vector(Earth_coord,asimut_vector);%вычисление вектора нормального азимута
[asimut_vector_norm]=ort_vector(asimut_vector_norm);%вычисление орта вектора нормального азимута
%
spead(1)=sin(asimut)*spead_start_hor;%скорость по OX в касательной системе координат (совпадает вектором нормального азимута)
spead(2)=cos(asimut)*spead_start_hor;%скорость по OY в касательной системе координат (совпадает вектором азимута)
%
[ort_Earth_coord]=ort_vector(Earth_coord);
Earth_spead=asimut_vector_norm*(spead(1)+rot_spead*cos(latitude_start))+asimut_vector*spead(2)+ort_Earth_coord*spead_start_vert;
end
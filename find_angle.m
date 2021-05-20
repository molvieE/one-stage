function [angle] = find_angle(vector_1,vector_2)
mod_vector_1=sqrt(vector_1(1)^2+vector_1(2)^2+vector_1(3)^2);
mod_vector_2=sqrt(vector_2(1)^2+vector_2(2)^2+vector_2(3)^2);
angle_cos=abs((vector_1(1)*vector_2(1)+vector_1(2)*vector_2(2)+vector_1(3)*vector_2(3))/(mod_vector_1*mod_vector_2));
angle=acos(angle_cos);
end

function[vector_pr] = projection_vector(vector,plane)
%t- параметрв параметрическом задании прямой
%plane- проходит через центр координат
t =-(plane(1)*vector(1)+plane(2)*vector(2)+plane(3)*vector(3))/(plane(1)^2+plane(2)^2+plane(3)^2);
vector_pr(1)=vector(1)+plane(1)*t;
vector_pr(2)=vector(2)+plane(2)*t;
vector_pr(3)=vector(3)+plane(3)*t;
end
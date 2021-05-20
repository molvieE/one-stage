function [res_vector] = multiplication_vector(vector_1,vector_2)
res_vector(1)=vector_1(2)*vector_2(3)-vector_1(3)*vector_2(2);
res_vector(2)=vector_1(1)*vector_2(3)-vector_1(3)*vector_2(1);
res_vector(3)=vector_1(1)*vector_2(2)-vector_1(2)*vector_2(1);
end

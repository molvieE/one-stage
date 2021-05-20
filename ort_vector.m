function [res_vector] = ort_vector(vector)
mod_vector=sqrt(vector(1)^2+vector(2)^2+vector(3)^2);
res_vector=vector./mod_vector;
end
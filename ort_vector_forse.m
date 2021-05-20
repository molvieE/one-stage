function[ort_vect_forse] =ort_vector_forse(tangaj,Earth_rot_spead,Earth_coord)
[proj_vector]=projection_vector(Earth_rot_spead,Earth_coord);
[hor_vector]=ort_vector(proj_vector);
[vert_comp]=ort_vector(Earth_coord);
vect_forse=cos(tangaj)*hor_vector+sin(tangaj)*vert_comp;
[ort_vect_forse]=ort_vector(vect_forse);
end
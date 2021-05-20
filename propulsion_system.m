function[forse,consump_mass] = propulsion_system(throt,out_area_stage,void_specific_impulse_stage,pressure_of_atmosphere,forse_vakuum_stage);
%throt-дроселирование(в дол€х от рассчЄтной т€ги где рассчЄтное давление при throt=0)
consump_mass=forse_vakuum_stage/ void_specific_impulse_stage;
forse=forse_vakuum_stage-pressure_of_atmosphere*out_area_stage;
end

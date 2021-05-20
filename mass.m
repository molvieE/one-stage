function[mass_oxigen,mass_fuel,fuel_tank,oxigen_tank,engene_mass,mass_dual]=mass(i,mass_rocket,mass_stage_relation,pol_fuel_solid_full,pol_oxigen_solid_full,pol_mass_systems,koef_engene_mass,mass_other,mass_fairing,payload,koef_fuel_ox,forse_vakuum)
%k2 отношение массы сухого бака горючего к массе полного бака 
%k3 отношение массы сухого бака окислителя к массе полного бака
%mass_systems масса систем упрвления ракетного блока
if i~=3
mass_oxigen=0;
mass_stage_calc=1;
mass_stage= mass_rocket *(mass_stage_relation(i)/sum(mass_stage_relation));
while abs(mass_stage-mass_stage_calc)>=0.1
    mass_oxigen=mass_oxigen+0.05;
    mass_fuel=mass_oxigen*koef_fuel_ox(i);
    k2 = pol_fuel_solid_full(1)+mass_fuel*pol_fuel_solid_full(2)+(mass_fuel^2)*pol_fuel_solid_full(3)+(mass_fuel^3)*pol_fuel_solid_full(4)+(mass_fuel^4)*pol_fuel_solid_full(5);
    k3 = pol_oxigen_solid_full(1)+mass_oxigen*pol_oxigen_solid_full(2)+(mass_oxigen^2)*pol_oxigen_solid_full(3)+(mass_oxigen^3)*pol_oxigen_solid_full(4)+(mass_oxigen^4)*pol_oxigen_solid_full(5);
    mass_rocket_block =forse_vakuum(i)*koef_engene_mass(i)+((mass_fuel*k2)/(1-k2))+((mass_oxigen*k3)/(1-k3))+mass_other(1);
    mass_systems =pol_mass_systems(1)+mass_rocket_block*pol_mass_systems(2)+(mass_rocket_block^2)*pol_mass_systems(3)+(mass_rocket_block^3)*pol_mass_systems(4)+(mass_rocket_block^4)*pol_mass_systems(5);
    mass_stage_calc=mass_oxigen+mass_fuel+mass_rocket_block+mass_systems;
end
oxigen_tank=((mass_oxigen*k3)/(1-k3));
fuel_tank=((mass_fuel*k2)/(1-k2));
engene_mass=forse_vakuum(i)*koef_engene_mass(i);
mass_dual=mass_fuel+mass_oxigen;
else
mass_oxigen=0;
mass_stage_calc=1;
mass_stage= mass_rocket *(mass_stage_relation(i)/sum(mass_stage_relation));
while abs(mass_stage-mass_stage_calc)>=0.1
    mass_oxigen=mass_oxigen+0.05;
    mass_fuel=mass_oxigen*koef_fuel_ox(3);
    k2 = pol_fuel_solid_full(1)+mass_fuel*pol_fuel_solid_full(2)+(mass_fuel^2)*pol_fuel_solid_full(3)+(mass_fuel^3)*pol_fuel_solid_full(4)+(mass_fuel^4)*pol_fuel_solid_full(5);
    k3 = pol_oxigen_solid_full(1)+mass_oxigen*pol_oxigen_solid_full(2)+(mass_oxigen^2)*pol_oxigen_solid_full(3)+(mass_oxigen^3)*pol_oxigen_solid_full(4)+(mass_oxigen^4)*pol_oxigen_solid_full(5);
    mass_rocket_block =forse_vakuum(i)*koef_engene_mass(i)+((mass_fuel*k2)/(1-k2))+((mass_oxigen*k3)/(1-k3))+mass_other(1)+mass_fairing+payload;
    mass_systems =pol_mass_systems(1)+mass_rocket_block*pol_mass_systems(2)+(mass_rocket_block^2)*pol_mass_systems(3)+(mass_rocket_block^3)*pol_mass_systems(4)+(mass_rocket_block^4)*pol_mass_systems(5);
    mass_stage_calc=mass_oxigen+mass_fuel+mass_rocket_block+mass_systems;
end
fuel_tank=((mass_fuel*k2)/(1-k2));
oxigen_tank=((mass_oxigen*k3)/(1-k3));
engene_mass=forse_vakuum(i)*koef_engene_mass(i);
mass_dual=mass_fuel+mass_oxigen;
    
end

end
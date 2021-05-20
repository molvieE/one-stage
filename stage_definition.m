function[stage,mass_fuel,solid_mass]=stage_definition(mass_fuel,alt,stage,solid_mass)
if ((mass_fuel(1)<=0)&& stage<=2)
   stage =2;
   mass_fuel(1)=0;
   solid_mass(1)=0;
end
if (stage>=2 && mass_fuel(2)<=0 )||(stage ==3)
   stage =3;
   mass_fuel(2)=0;
   solid_mass(2)=0;
end

end
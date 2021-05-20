function[tangage]=tangage_def(stage,tangage,pi,hor_ang,apoge,perige,alt)
%% решение для нормальной версии
apoge_delta=7000;%при разнице в apoge_delta от апогея установить тангаж 
%так чтобы вектор скорости совпадал с вектором тяги

if (stage==1)
tangage= (pi/180) * 45; 
end
if (stage==2)&& (apoge>300000)
tangage = (pi/180)* -k*(apoge-300000); %если апогей выше высоты целевой орбиты то уменьшить угол тангажа  
else
if (stage==2)
tangage= (pi/180) * 35; 
end
end
if (stage==3)&&(apoge<300000)
tangage=(pi/180) *10;    
end
if (stage==3)&&(abs(alt-apoge)<apoge_delta)
tangage=hor_ang;    
end

end

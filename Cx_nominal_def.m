function[Cx_nominal]=Cx_nominal_def(mach,Cx_max)
%
if(mach<0.3)
  Cx_normal =0.47;
end
%
if((mach>0.3)&&(mach<0.8))
  Cx_normal =0.47+0.15*(mach-0.3)/0.5;  
end
%
if((mach>0.8)&&(mach<1))
  Cx_normal =0.62+0.3*(mach-0.8)/0.2;  
end
%
if((mach>1)&&(mach<1.07))
  Cx_normal =0.92+0.08*(mach-1)/0.07;  
end
%
if((mach>1.07)&&(mach<1.2))
  Cx_normal =1-0.04*(mach-1.07)/0.13;  
end
%
if((mach>1.2)&&(mach<2))
  Cx_normal =0.96-0.31*(mach-1.2)/0.8;  
end
%
if((mach>2)&&(mach<3))
  Cx_normal =0.65-0.15*(mach-2)/1;  
end
%
if((mach>3)&&(mach<5))
  Cx_normal =0.5-0.15*(mach-3)/2;  
end
%
if(mach>5)
  Cx_normal= 0.35;
end
%
Cx_nominal=Cx_max*Cx_normal;
end
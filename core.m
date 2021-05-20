clear;
%% ��������
rad_Earth=6371000; % ������ ����� � ������
pi=3.1415926; % ����� ��
rot_spead=465; % �������� �������� ����� ������ ��� �� ��������
acs_ff=9.8205185; % ��������� ���������� ������� ��� ����� �������� �����
%% ���������� ��������������
del_time = 0.05; % ��������� �� ������� � ��������
time = 0; % ��������� �����
Earth_coord_x_arr=[];
Earth_coord_y_arr=[];
Earth_coord_z_arr=[];
resist_arr=[];
acs_arr=[];
du_status=logical(false);
flag_fairing=logical(false);
%% ������ � �������
time_arr=[];
alt_arr=[];
spead_arr=[];
tangage_arr=[];
forse_arr=[];
specific_impulse_arr=[];
mass_arr=[];
apoge_arr=[];
perige_arr=[];
%% ������� [x,y,z]
Earth_coord=[0,0,0];%��������� ������ � ����������� ������� ���������
ort_Earth_coord=[0,0,0]; % ��� ������ ������� ��������� ������
Earth_spead=[0,0,0];%�������� ��������� � ����������� �������� ���������
Earth_rot_spead=[0,0,0];% �������� ��������� � ������������ �����
forse_vector=[0,0,0];%������ ����
resist_forse=[0,0,0];%������ ��������� ����
lift_forse=[0,0,0];%������ ��������� ����
%% ������������
separation_far_alt=70000;
%������� ������
area_mid=0.283; 
%������� ��������� ��������� ��������� ����
area_aerSurf=0;
%����� ������������� �������� �������������  ��� ���� ��������
Cx_max=0.5;
%����������� ��������� ���� ��� ������������ ������� ��� ���� ��������
Cy_nominal_up_sound=0;
%����������� ��������� ���� ��� ���������� ������� ��� ���� ��������
Cy_nominal_under_sound=0;
%������������ � ���������� ������� Cx(a)� Cy(a) ��� a-���� ����� � �������� ���������� ������ ��������
%�� 1
Cy_polinom_stage_1=[1,0,0,0,0];%������ �������
Cx_polinom_stage_1=[1,0,0,0,0];%������ �������
%% �������������� �� ������ �� ��������
out_area=0.009;%�������� ������� ����� ����� �� ������
void_specific_impulse=3000;%��������� �������� �������
forse_vakuum=5360;%���� � ������� �������
%% �������� ��������������
%����
mass_other=0;% ����� ������ ����������(������� ������������)
solid_mass=35;%����� ������ � �����������
payload=0;%�������� ��������
mass_dual=715;% ����� ��������� ���� �� ������ �������
solid_mass=solid_mass+payload;
%% ����������������
tangage=18;%���� ������� � ��������� �� ������
latitude_start=0.001;% ������ � ������ ����� � ��������
height_start=14000;% ������ � ������ �����
asimut=90;%����������� ����� � ������ � �������
spead_start=250;%�������� �� ������
%% ����������� ��������� ��������� � ��������
[Earth_coord,Earth_spead] = start_pos(tangage,latitude_start,height_start,asimut,spead_start);% ����������� ��������� ��������� � ��������
stage=1;%��������� �������
apoge=0;%������
perige=0;%�������
counter=0;%������� ������ � ����

while(time<(1800))  % ���� � ������� ����������� ������� �����  
[apoge,perige] = orbital_char(Earth_spead,Earth_coord);
alt=modul_vector(Earth_coord)-6371000;%���������� ������ �����
if (alt<=0)
break;    
end    
forse_vector=[0,0,0];
consump_mass=0; 
if alt > 80000 
cur_spead = Earth_spead;
else
cur_spead = Earth_rot_spead;   
end    
hor_ang =pi/2- find_angle(cur_spead,Earth_coord);% ����������� ���� ������� ������� �������� � ���������
%% ����������� ������� ������ � �������� ������������� 
[du_status]=def_DU_status(mass_dual,alt,1,apoge,perige,hor_ang);
Cy_polinom=Cy_polinom_stage_1;
Cx_polinom=Cx_polinom_stage_1;
%% ����������� ������� �������� ������������ �������
[Earth_rot_spead] = rot_sys_spead(Earth_coord,Earth_spead);
%% ����������� ������������� ��������� � ���������������� �������������
[Temp_of_atmosphere,pressure_of_atmosphere,dencity_of_atmosphere] = standart_atmosphere(alt,0);
speed_sound=sqrt((8.31/0.028)*Temp_of_atmosphere*1.4);%����������� �������� �����
mach = modul_vector(Earth_rot_spead)/speed_sound;%����������� ����� ����
%% ����������� ���������� ������� �� ���� ��������
tangage=(pi/180)*60;%����������� ���� ������� ������� ���� � �������� ��������� 
%% ����������� ���� ������� ���� 
[ort_vect_forse]=ort_vector_forse(tangage,Earth_rot_spead,Earth_coord);
%% ����������� ������������� ��
if (du_status==true)
throt=1;
out_area_stage=out_area;
void_specific_impulse_stage=void_specific_impulse;
%external_press_stage=external_press(stage);
forse_vakuum_stage= forse_vakuum;
[forse,consump_mass] = propulsion_system(throt,out_area_stage,void_specific_impulse_stage,pressure_of_atmosphere,forse_vakuum_stage);
forse_vector=forse.*ort_vect_forse;
mass_dual=mass_dual-consump_mass*del_time;
end   
%% ���������� ������������ ������������ ������������� � ��������� ���� 
[Cx_nominal]=Cx_nominal_def(mach,Cx_max);
if mach>1
    Cy_nominal=Cy_nominal_up_sound;
else
    Cy_nominal=Cy_nominal_under_sound; 
end    
%% ������������ �������� ���������������� ��� ������ ��� ���� ����� =����
%����� �������� ���� � �������� �������� � ���������(������ ��� �� >0)
[resist_forse,lift_forse]=aerodynamics(Earth_coord,ort_vect_forse,Earth_rot_spead,Cy_nominal,Cx_nominal,Cy_polinom,Cx_polinom,dencity_of_atmosphere,area_mid,area_aerSurf);
%% ����������� ������� ���������
[ort_Earth_coord]=ort_vector(Earth_coord); % ��� ������ ������� ��������� ������
acs_vector=(resist_forse+lift_forse+forse_vector)./(solid_mass+mass_dual);
acs_vector=acs_vector-ort_Earth_coord*acs_ff *((6371000/(alt+6371000))^2); % ������ ���������
%% ����������� ��������� � ������������ �� ����� ��������
Earth_coord=Earth_coord+Earth_spead.*del_time+(acs_vector.*del_time^2)./2;
Earth_spead = Earth_spead+acs_vector.*del_time;
%% ����������� ���������� �� �������
time=time+del_time;
counter=counter+1;
if counter>10
spead=modul_vector(Earth_spead);
acs=modul_vector(acs_vector);
forse_sc=modul_vector(forse_vector);
if consump_mass~=0
specific_impulse=forse_sc/consump_mass;
else
specific_impulse=0;    
end
all_mass=sum(mass_dual)+sum(solid_mass);
resist=modul_vector(resist_forse);
resist_arr=[resist_arr,resist];
time_arr=[time_arr,time];
alt_arr=[alt_arr,alt];
spead_arr=[spead_arr,spead];
Earth_coord_x_arr=[Earth_coord_x_arr,Earth_coord(1)];
Earth_coord_y_arr=[Earth_coord_y_arr,Earth_coord(2)];
Earth_coord_z_arr=[Earth_coord_z_arr,Earth_coord(3)];
acs_arr=[acs_arr,acs];
tangage_arr=[tangage_arr,tangage];
forse_arr=[forse_arr,forse_sc];
mass_arr=[mass_arr,all_mass];
specific_impulse_arr=[specific_impulse_arr,specific_impulse];
apoge_arr=[apoge_arr,apoge];
perige_arr=[perige_arr,perige];
counter=0;
end
end


f=fopen('balistik_table.txt','wt');
n=size(mass_arr);
n=n(2);
fprintf(f,'�����(���)    |    �����(��)    |   ��������(�/�)    |     ������(�)     |    �������� �������(�/�)    |    ����(�)    |    ������(���)      \n'); 
for j=1:n
fprintf(f,'   '); 
fprintf(f,'%6.2f',time_arr(j)) ;
fprintf(f,'           ');
fprintf(f,'%6.2f',mass_arr(j)) ;
fprintf(f,'             ');
fprintf(f,'%6.2f',spead_arr(j));
fprintf(f,'              ');
fprintf(f,'%6.2f',alt_arr(j));
fprintf(f,'               ');
fprintf(f,'%6.2f',specific_impulse_arr(j));
fprintf(f,'                 ');
fprintf(f,'%6.2f',forse_arr(j));
fprintf(f,'            ');
fprintf(f,'%6.2f',tangage_arr(j));
fprintf(f,'      \n');
end
fclose(f);

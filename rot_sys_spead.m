function [Earth_rot_spead] = rot_sys_spead(Earth_coord,Earth_spead)
%%const
rad_Earth=6371000;%
pi=3.1415926;
rot_spead=465;
%%
mod_earth_coord=sqrt(Earth_coord(1)^2+Earth_coord(2)^2+Earth_coord(3)^2);
C_tang=Earth_coord(3)/sqrt(Earth_coord(1)^2+Earth_coord(2)^2+Earth_coord(3)^2);%����������� C ����������� ��������� � ����� ������
D_tang=-sqrt(Earth_coord(1)^2+Earth_coord(2)^2+Earth_coord(3)^2);%����������� D ����������� ��������� � ����� ������
inter_point(3)=-D_tang/C_tang;%���������� ����� ����������� ����������� ��������� � ���� OZ
%
asimut_vector=inter_point-Earth_coord;%���������� ������� �������
[asimut_vector]=ort_vector(asimut_vector);%���������� ���� ������� �������
[asimut_vector_norm]=multiplication_vector(Earth_coord,asimut_vector);%���������� ������� ����������� �������
[asimut_vector_norm]=ort_vector(asimut_vector_norm);%���������� ���� ������� ����������� �������

spead_rot_vector=asimut_vector_norm*(sqrt(Earth_coord(1)^2+Earth_coord(2)^2)/mod_earth_coord)*rot_spead;%������ �������� ������� � ����� ���������� ������ � �����������
Earth_rot_spead=Earth_spead-spead_rot_vector;%������ �������� ������ ������������ �������
end
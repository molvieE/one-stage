function [Earth_coord,Earth_spead] = start_pos(tangage,latitude_start,height_start,asimut,spead_start)
%%const
rad_Earth=6371000;%
pi=3.1415926;
rot_spead=465;
%������� [x,y,z]
inter_point=[0,0,0];%���������� ����� ����������� ����������� ��������� c ���� OZ
asimut_vector=[0,0,0];%������ ������������ �� ��� OZ
asimut_vector_norm=[0,0,0];%������ ���������� � ������� �������
%%
%������� [x,y]
spead=[0,0];% ���������� � ����������� ������� ���������
%%
latitude_start=latitude_start*pi/180;
asimut=asimut*pi/180;
tangage=tangage*pi/180;
spead_start_hor=spead_start*cos(tangage);%�������� � �������������� ���������
spead_start_vert=spead_start*sin(tangage);%�������� � ������������ ���������
%%���������� x y z � ���������� �������� ��������� � ������� � ������ �����
Earth_coord(3)=(height_start+rad_Earth)*sin(latitude_start);
Earth_coord(2)=(height_start+rad_Earth)*cos(latitude_start);
%%
%��������� ����������� ����������� ����� � ���� �����
C_tang=Earth_coord(3)/sqrt(Earth_coord(1)^2+Earth_coord(2)^2+Earth_coord(3)^2);%����������� C ����������� ��������� � ����� ������
D_tang=-sqrt(Earth_coord(1)^2+Earth_coord(2)^2+Earth_coord(3)^2);%����������� D ����������� ��������� � ����� ������
inter_point(3)=-D_tang/C_tang;%���������� ����� ����������� ����������� ��������� � ���� OZ
%
asimut_vector=inter_point-Earth_coord;%���������� ������� �������
[asimut_vector]=ort_vector(asimut_vector);%���������� ���� ������� �������
[asimut_vector_norm]=multiplication_vector(Earth_coord,asimut_vector);%���������� ������� ����������� �������
[asimut_vector_norm]=ort_vector(asimut_vector_norm);%���������� ���� ������� ����������� �������
%
spead(1)=sin(asimut)*spead_start_hor;%�������� �� OX � ����������� ������� ��������� (��������� �������� ����������� �������)
spead(2)=cos(asimut)*spead_start_hor;%�������� �� OY � ����������� ������� ��������� (��������� �������� �������)
%
[ort_Earth_coord]=ort_vector(Earth_coord);
Earth_spead=asimut_vector_norm*(spead(1)+rot_spead*cos(latitude_start))+asimut_vector*spead(2)+ort_Earth_coord*spead_start_vert;
end
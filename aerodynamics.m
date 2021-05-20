function [resist_forse,lift_forse] = aerodynamics(Earth_coord,thrust,Earth_rot_spead,Cy_nominal,Cx_nominal,Cy_polinom,Cx_polinom,dencity_of_atmosphere,area_mid,area_aerSurf)
help_vector=[0,0,0];
ort_lift_forse=[0,0,0];
ort_resist_forse=[0,0,0];
[mod_spead] = modul_vector(Earth_rot_spead);
[help_vector]=multiplication_vector(Earth_rot_spead,Earth_coord);% ����������� ���������������� �������
[ort_lift_forse]=multiplication_vector(help_vector,Earth_rot_spead);% ����������� ������������� ������� ��������� ����
[ort_lift_forse]=ort_vector(ort_lift_forse);%����������� ���� ������������� ������� ��������� ����
[angle_of_attack]=find_angle(thrust,Earth_rot_spead);%����������� ���� ����� ������ 
ort_resist_forse=-Earth_rot_spead;
[ort_resist_forse]=ort_vector(ort_resist_forse);
%������� ������������ ���������������� ��������� � ����������� �� ����� ���� � ���� �����
[Cx]=aero_param(angle_of_attack,Cx_nominal,Cx_polinom);
[Cy]=aero_param(angle_of_attack,Cy_nominal,Cy_polinom);
resist_forse=(ort_resist_forse.*(mod_spead^2).*dencity_of_atmosphere.*area_mid.*Cx)./2;%����������� ������� ���� �������������
lift_forse=(ort_lift_forse*(mod_spead^2)*dencity_of_atmosphere*area_aerSurf*Cy)/2;%����������� ������� ��������� ���� 
end
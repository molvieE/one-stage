[X,Y,Z] = sphere;
r = 6371000;
X2 = X * r;
Y2 = Y * r;
Z2 = Z * r;
surf(X2+5,Y2-5,Z2)
hold on
plot3(Earth_coord_x_arr,Earth_coord_y_arr,Earth_coord_z_arr,'*')

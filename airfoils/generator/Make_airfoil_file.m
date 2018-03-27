clc
clear

% From a dat file
airfoil_name = 'NACA0012';
coord = dlmread([airfoil_name, '.dat'],'',1,0);

VAP3_airfoil_gen(airfoil_name, coord, [150000:150000:5e6], [-10:0.25:20])

function [lambda,phi]= cal_nadir_point(obj,theta_k)
% Calculate the track of substellar point
%
% Parameters：
% theta_k: (float)Phase change of satellite (deg).

% Setup omega_e and generate a timeline.
omega_e = 7.292e-5;
t = gen_timeline(obj);
% Convert parameters from deg to rad.
M_rad=deg2rad(obj.M);
theta_k_rad=deg2rad(theta_k);
i_rad=deg2rad(obj.i);
Omega_rad=deg2rad(obj.Omega);
G_0_rad=deg2rad(obj.G_0);

% Calculate M_K and Omega_k by rad.
M_k=M_rad+theta_k_rad+obj.b_M.*t;
Omega_k=Omega_rad+obj.b_Omega.*t;

% Calculate lambda and phi by rad.
lambda=Omega_k+atan(tan(M_k).*cos(i_rad))-(G_0_rad+omega_e.*t);
phi=asin(sin(M_k).*sin(i_rad));

end
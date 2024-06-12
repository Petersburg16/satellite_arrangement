function obj = update(obj, theta_k)
arguments
    obj
    theta_k(1,1) double =0;
end
obj=gen_timeline(obj);
[lambda,phi]= cal_nadir_point(obj,theta_k);

lambda_T_rad=deg2rad(obj.lambda_T);
phi_T_rad=deg2rad(obj.phi_T);
rho_bar_rad=deg2rad(obj.rho_bar);
% Calculate target Earth-Fixed Coordinate System.
x_T=cos(lambda_T_rad)*cos(phi_T_rad);
y_T=sin(lambda_T_rad)*cos(phi_T_rad);
z_T=sin(phi_T_rad);

% Calculate substellar point track in the earth-fixed coordinate system.
x_k=cos(lambda).*cos(phi);
y_k=sin(lambda).*cos(phi);
z_k=sin(phi);


% Calculate the ground coverage time window.
tempT=[x_T;y_T;z_T];
tempK=[x_k',y_k',z_k'];
rho=zeros(size(tempK,1),1);

dotProducts=tempT' *tempK';
rho=acos(dotProducts);
obj.tau=(abs(rho)<rho_bar_rad);
end
function obj= cal_nadir_point(obj,theta_k)
% Calculate the track of substellar point
%
% Parameters：
% theta_k: (float)Phase change of satellite (deg).

% Setup omega_e and generate a timeline.
omega_e = 7.292e-5;

% Convert parameters from deg to rad.
M_rad=deg2rad(obj.M);
theta_k_rad=deg2rad(theta_k);
i_rad=deg2rad(obj.i);
Omega_rad=deg2rad(obj.Omega);
G_0_rad=deg2rad(obj.G_0);
omega_rad=deg2rad(obj.omega);

% Calculate M_K and Omega_k by rad.
M_k=M_rad+theta_k_rad+obj.b_M.*obj.t;
Omega_k=Omega_rad+obj.b_Omega.*obj.t;
r_k=obj.a*(1-obj.e^2)./(1+obj.e*cos(M_k));


% 此处的操作有待向量化
X_k_orbit=zeros(3,length(obj.t));
X_k_ECI=zeros(3,length(obj.t));
X_k_ECF=zeros(3,length(obj.t));
parfor i=1:length(obj.t)
    X_k_orbit(:,i)=[r_k(i)*cos(M_k(i)),r_k(i)*sin(M_k(i)),0]';
    X_k_ECI(:,i)=Satellite.rz(-Omega_k(i))*Satellite.rx(-i_rad)*Satellite.rz(-omega_rad)*X_k_orbit(:,i);
    X_k_ECF(:,i)=Satellite.rz(-(G_0_rad+omega_e*obj.t(i)))*X_k_ECI(:,i);
end

lambda=atan2(X_k_ECF(2,:),X_k_ECF(1,:));
phi=asin(X_k_ECF(3,:)./r_k);

obj.lambda=rad2deg(lambda);
obj.phi=rad2deg(phi);

lambda_T_rad=deg2rad(obj.lambda_T);
phi_T_rad=deg2rad(obj.phi_T);
rho_bar_rad=deg2rad(obj.rho_bar);
% Calculate target Earth-Fixed Coordinate System.
x_T=cos(lambda_T_rad)*cos(phi_T_rad);
y_T=sin(lambda_T_rad)*cos(phi_T_rad);
z_T=sin(phi_T_rad);


% Calculate the ground coverage time window.
x_k=X_k_ECF(1,:);
y_k=X_k_ECF(2,:);
z_k=X_k_ECF(3,:);

tempT=[x_T;y_T;z_T];
tempK=[x_k',y_k',z_k'];
rho=zeros(size(tempK,1),1);


dotProducts=tempT' *tempK';
rho=acos(dotProducts./r_k);
obj.tau=(abs(rho)<rho_bar_rad);
end

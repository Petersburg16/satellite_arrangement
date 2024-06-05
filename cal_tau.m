% N = 19;   % total number of agents
% rho_bar = 10; % observation range of satellite, geocentric angle (deg)
% 
% 
% %orbital six elements
% a = 6939.76*10e3; % semi-major axis (m)
% e = 0; % eccentricity
% i = 98; % orbital inclination (deg)
% Omega = 284.507; % right ascension of ascending node (deg)
% omega = 0; % argument of perigee (deg)
% M = zeros(tmax,N);% row index: time (s); column index: agents
% 
% %deg to rad
% i = deg2rad(i);
% Omega = deg2rad(Omega);
% omega = deg2rad(omega);






function tau=cal_tau(theta_k,a,e,i,Omega_k0,omega,M_k0)

% 定义轨道参数
arguments
    theta_k (1,1) double  
    a (1,1) double = 100000 
    e(1,1) double=0
    i(1,1) double=0.1
    Omega_k0(1,1) double=0
    omega(1,1) double=0
    M_k0(1,1) double=0
end  


% 其他相关参数定义
b_M=1;
b_Omega=1;
G_0=0;
omega_e=0.7;


lambda_T=0;
phi_T=0;

t = gen_timeline(1,5);


% 计算星下点轨迹
M_k=M_k0+theta_k+b_M.*t;
Omega_k=Omega_k0+b_Omega.*t;

lambda=Omega_k+atan(tan(M_k).*cos(i))-(G_0+omega_e.*t);
phi=asin(sin(M_k).*sin(i));


rho = cal_rho(lambda_T, phi_T, lambda, phi);


tau=(abs(rho)<0.5);

end



function t = gen_timeline(days,h)
% Generate a timeline for simulation
%
% Parameters：
% days: (float,optional)totlal days of simulation. Defaults to 1.
% h: (float,optional)Discrete interval (s). Defaults to 60.
% 
% Returns:
% t: （row vector)timeline for simulation.

arguments
    days (1,1) double = 1
    h (1,1) double = 60 
end  
    
T = days*24*60*60; % totlal times of simulation (s)
tmax = T/h; % time index

t=linspace(0,(tmax-1)*h,tmax);
end



function rho = cal_rho(lambda_T, phi_T, lambda, phi)
% 计算rho，地心固连系下星下点与目标向量夹角
%
% 入口参数：
% lambda_T,phi_T：观测目标经纬度
% lambda,phi：当前卫星星下点轨迹
% 
% 返回值：
% rho：每一时间点下地心固连系下星下点与目标向量夹角


% 默认参数，地球半径
R_e=6000000;


% 目标地心固连系
x_T=R_e*cos(lambda_T)*cos(phi_T);
y_T=R_e*sin(lambda_T)*cos(phi_T);
z_T=R_e*sin(phi_T);

% 星下点固连系
x_k=R_e.*cos(lambda).*cos(phi);
y_k=R_e.*sin(lambda).*cos(phi);
z_k=R_e.*sin(phi);


% 计算rho
tempT=[x_T;y_T;z_T];
tempK=[x_k',y_k',z_k'];
rho=zeros(size(tempK,1),1);

dotProducts=tempT' *tempK';
norm_tempT=norm(tempT);
norms_tempK=sqrt(sum(tempK.^2,2));

rho=acos(dotProducts ./(norm_tempT .* norms_tempK'));
end
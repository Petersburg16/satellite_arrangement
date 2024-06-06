function obj=cal_auxiliary_parameters(obj)
% Calculate auxiliary parameters b_Omega and b_M.
miu=3.9860044e14;
J2=1.08263e-3;
R_e=6378.139e3;

n_M=sqrt(miu/(obj.a^3));
CJ2=1.5*n_M*J2*((R_e/obj.a)^2);

i_rad=deg2rad(obj.i);
obj.b_Omega=-CJ2*cos(i_rad);
obj.b_M=n_M-CJ2*(1.5*(sin(i_rad)^2)-1);
end
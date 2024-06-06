function obj=set_target(obj,lambda_T,phi_T,rho_bar)
% Allow setup target latitude and longitudes without defaults.
% Verify Parameters
arguments
    obj
    lambda_T (1,1) double = 121.3
    phi_T (1,1) double = 31.1
    rho_bar (1,1) double = 9.45
end
obj.lambda_T=lambda_T;
obj.phi_T=phi_T;
obj.rho_bar=rho_bar;
end
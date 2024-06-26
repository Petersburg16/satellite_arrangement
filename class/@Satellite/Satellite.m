classdef Satellite
    properties
        days,h;
        a,e,i,Omega,omega,M;
        G_0,b_M,b_Omega;
        lambda_T,phi_T,rho_bar;
        tau;
        t,lambda,phi;
    end
    methods
        function obj=Satellite(theta0)
            obj=set_orbit_parameters(obj,theta0);
            obj=set_time_parameters(obj);
            obj=gen_timeline(obj);
            obj=set_auxiliary_parameters(obj);
            obj=cal_auxiliary_parameters(obj);
            obj=set_target(obj);
            obj=update(obj);

        end
    end
end




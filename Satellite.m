classdef Satellite
    properties
        days,h;
        a,e,i,Omega,omega,M;
        G_0,b_M,b_Omega;
        lambda_T,phi_T,rho_bar;
        tau;
    end
    methods
        % Inital methods
        function obj=Satellite(theta0)
            obj=set_orbit_parameters(obj,theta0);
            obj=set_time_parameters(obj);
            obj=set_auxiliary_parameters(obj);
            obj=cal_auxiliary_parameters(obj);
            obj=set_target(obj);

            obj=cal_tau(obj);
        end
        function obj=set_orbit_parameters(obj,M,a,e,i,Omega,omega)
            % Allow setup orbital elements without defaults.
            %
            % Parameters：
            % M: (float)Initial mean anomaly(deg).
            % a: (float,optional) Semi-major axis (m). Defaults to 6939.76e3.
            % e: (float,optional) eccentricity. Defaults to 0.
            % i: (float,optional) Orbital inclination(deg). Defaults to 98.
            % Omega: (float,optional) Right ascension of ascending node(deg). Defaults to 284.507.
            % omega: (float,optional) Argument of perigee (deg). Defaults to 0.

            % Verify Parameters
            arguments
                obj
                M (1,1) double
                a (1,1) double = 6939.76e3
                e(1,1) double=0
                i(1,1) double=98
                Omega(1,1) double=284.507
                omega(1,1) double=0
            end
            obj.M=M;
            obj.a=a;
            obj.e=e;
            obj.i=i;
            obj.Omega=Omega;
            obj.omega=omega;
        end
        function obj=set_time_parameters(obj,days,h)
            % Allow setup time parameters without defaults.
            %
            % Parameters：
            % days: (float,optional)total days of simulation. Defaults to 1.
            % h: (float,optional)Discrete interval (s). Defaults to 5.
            %
            % Verify Parameters
            arguments
                obj
                days (1,1) double = 1
                h (1,1) double = 5
            end
            obj.days=days;
            obj.h=h;
        end
        function obj=set_auxiliary_parameters(obj,G_0)
            % Allow setup auxiliary parameters without defaults.
            % 
            % Parameters：
            % G_0: (float,optional)total days of simulation. Defaults to 1. 
            % 
            % Verify Parameters
            arguments
                obj
                G_0 (1,1) double = 0
            end
            obj.G_0=G_0;
        end
        function obj=cal_auxiliary_parameters(obj)
            % Calculate auxiliary parameters b_Omega and b_M.
            miu=3.9860044e14;
            J2=1.08263e-3;
            R_e=6371.393e3;
            n_M=sqrt(miu/obj.a^3);
            CJ2=1.5*n_M*J2*(R_e/obj.a)^2;
            i_temp=deg2rad(obj.i);
            obj.b_Omega=-CJ2*cos(i_temp);
            obj.b_M=n_M-CJ2*(1.5*sin(i_temp)-1);
        end
        function obj=set_target(obj,lambda_T,phi_T,rho_bar)
            % Allow setup target latitude and longitudes without defaults.
            % Verify Parameters
            arguments
                obj
                lambda_T (1,1) double = 121.3
                phi_T (1,1) double = 31.1
                rho_bar (1,1) double = 10
            end
            obj.lambda_T=lambda_T;
            obj.phi_T=phi_T;
            obj.rho_bar=rho_bar;
        end
    end

    methods
        % Claculate methos
        function t = gen_timeline(obj)
            % Generate a timeline for simulation
            %
            % Returns:
            % t: （row vector)timeline for simulation.

            T = obj.days*24*60*60; % totlal times of simulation (s)
            tmax = T/obj.h; % time index

            t=linspace(0,(tmax-1)*obj.h,tmax);
        end
        function [lambda,phi]= cal_nadir_point(obj,theta_k)
            % Calculate the track of substellar point
            omega_e = 7.292e-5;
            t = gen_timeline(obj);
            % Convert parameters from deg to rad 
            M_rad=deg2rad(obj.M);
            theta_k_rad=deg2rad(theta_k);
            i_rad=deg2rad(obj.i);
            Omega_rad=deg2rad(obj.Omega);
            G_0_rad=deg2rad(obj.G_0);

            % Calculate M_K and Omega_k by rad.
            delta_M_temp=deg2rad(obj.b_M.*t);
            delta_Omega_temp=deg2rad(obj.b_Omega.*t);
            M_k=M_rad+theta_k_rad+delta_M_temp;
            Omega_k=Omega_rad+delta_Omega_temp;

            % Calculate lambda and phi by rad.
            lambda=Omega_k+atan(tan(M_k).*cos(i_rad))-(G_0_rad+omega_e.*t);
            phi=asin(sin(M_k).*sin(i_rad));
        end
        function obj = cal_tau(obj, theta_k)
            arguments
                obj 
                theta_k(1,1) double =0;
            end
            R_e=6371.393e3;
            [lambda,phi]= cal_nadir_point(obj,theta_k);
            lambda_T_rad=deg2rad(obj.lambda_T);
            phi_T_rad=deg2rad(obj.phi_T);
            rho_bar_rad=deg2rad(obj.rho_bar);
            % Calculate target Earth-Fixed Coordinate System.
            x_T=R_e*cos(lambda_T_rad)*cos(phi_T_rad);
            y_T=R_e*sin(lambda_T_rad)*cos(phi_T_rad);
            z_T=R_e*sin(phi_T_rad);

            % Calculate substellar point track in the earth-fixed coordinate system.
            x_k=R_e.*cos(lambda).*cos(phi);
            y_k=R_e.*sin(lambda).*cos(phi);
            z_k=R_e.*sin(phi);


            % Calculate the ground coverage time window.
            tempT=[x_T;y_T;z_T];
            tempK=[x_k',y_k',z_k'];
            rho=zeros(size(tempK,1),1);

            dotProducts=tempT' *tempK';
            norm_tempT=norm(tempT);
            norms_tempK=sqrt(sum(tempK.^2,2));

            rho=acos(dotProducts ./(norm_tempT .* norms_tempK'));
            obj.tau=(abs(rho)<rho_bar_rad);
        end
    end
end




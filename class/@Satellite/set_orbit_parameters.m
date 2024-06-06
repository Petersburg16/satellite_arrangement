function obj=set_orbit_parameters(obj,M,a,e,i,Omega,omega)
            % Allow setup orbital elements without defaults.
            %
            % Parameters：
            % M: (float)Initial mean anomaly(deg).
            % a: (float,optional) Semi-major axis (m). Defaults to 6896.27e3.
            % e: (float,optional) eccentricity. Defaults to 0.
            % i: (float,optional) Orbital inclination(deg). Defaults to 98.
            % Omega: (float,optional) Right ascension of ascending node(deg). Defaults to 284.507.
            % omega: (float,optional) Argument of perigee (deg). Defaults to 0.

            % Verify Parameters
            arguments
                obj
                M (1,1) double
                a (1,1) double = 6896.27e3
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
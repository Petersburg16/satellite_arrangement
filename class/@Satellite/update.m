function obj = update(obj, theta_k)
arguments
    obj
    theta_k(1,1) double =0;
end
obj=gen_timeline(obj);
obj= cal_nadir_point(obj,theta_k);


end
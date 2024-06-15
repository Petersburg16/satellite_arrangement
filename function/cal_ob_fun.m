function ob_fun=cal_ob_fun(x,sat_array,sat_num,k)
% x:theta_k
% sat_array:一组邻近的卫星
% sat_num:对该组卫星中的哪科进行优化
% k：目标函数中的gama

A=cal_matrix_A(sat_array);

% 累加邻近卫星的时间窗口 
tau=zeros(1,length(sat_array{1}.tau));
flag=sat_num;

flag=length(sat_array);
for i=1:flag
        continue
    else
    tau=tau+A(sat_num,i)*sat_array{i}.tau;
    end
end

sat=sat_array{sat_num};
sat=sat.update(x);
tau=(abs(tau)==0);
J1=(sum(sat.tau.*tau)*sat.h)/sat.days;
J2=k*x^2;
ob_fun=J2-J1;
end

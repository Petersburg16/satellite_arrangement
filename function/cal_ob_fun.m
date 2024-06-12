function ob_fun=cal_ob_fun(x,sat_array,sat_num,k)
% x:theta_k
% sat_array:一组邻近的卫星
% sat_num:对该组卫星中的哪科进行优化
% k：目标函数中的gama

A=cal_matrix_A(sat_array);


% 累加邻近卫星的时间窗口
tau=zeros(1,length(sat_array{1}.tau));

flag=length(sat_array);
if sat_num==1
    tau=A(sat_num,flag).*sat_array{flag}.tau+A(sat_num,sat_num+1).*sat_array{sat_num+1}.tau;
elseif sat_num==flag
    tau=A(sat_num,sat_num-1).*sat_array{sat_num-1}.tau+A(sat_num,1).*sat_array{1}.tau;
else
    tau=A(sat_num,sat_num-1).*sat_array{sat_num-1}.tau+A(sat_num,sat_num+1).*sat_array{sat_num+1}.tau;
end
sat=sat_array{sat_num};
sat=sat.update(x);
tau=(abs(tau)==0);
J1=(sum(sat.tau.*tau)*sat.h)/sat.days;
J2=k*x^2;
ob_fun=J2-J1;
end

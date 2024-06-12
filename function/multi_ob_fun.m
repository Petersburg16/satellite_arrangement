function multi_ob_fun = multi_ob_fun(x,sat_array,k)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

if length(x)~=length(sat_array)
    error '优化变量个数和卫星个数不匹配'
end
tau=zeros(1,length(sat_array{1}.tau));
sat_num=length(sat_array);
J2=0;
for i=1:sat_num
    sat_array{i}=sat_array{i}.update(x(i));
    tau=tau+sat_array{i}.tau;
    J2=J2+k*x(i)^2;
end
tau=(abs(tau)~=0);
sat=sat_array{1};
J1=(sum(tau)*sat.h)/sat.days;
multi_ob_fun=J2-J1;
end
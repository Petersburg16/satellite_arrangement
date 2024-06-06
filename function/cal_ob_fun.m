function ob_fun=cal_ob_fun(x,tau,sat,k)
sat=sat.update(x);
tau=(abs(tau)==0);
J1=sum(sat.tau.*tau)*sat.h/sat.days;
J2=k*x^2;
ob_fun=J2-J1;
end

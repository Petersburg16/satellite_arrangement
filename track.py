import math
import numpy as np
from scipy.optimize import fsolve

class RoundTrack:
    """
    卫星轨道父类，用于生成近地回顾圆轨道参数

    D:星下点轨迹重复需要的圈数，整数
    N:星下点轨迹重复需要的天数，整数
    a:轨道半长轴，米
    i:轨道倾角，弧度每秒

    omegae:常数，地球自转速度，7.3e-5 弧度每秒
    aE:常数，地球参考椭球赤道半径，6378160 米
    j2:无量纲常数，摄动系数，1.0826e-3
    miu:常数，地球引力常数，3.986005e14 立方米每平方秒
    



    n=计算中间项，航天器平均角速度
    DotOmega:计算中间项，升交点赤经变化率
    T0:计算中间项，密切轨道周期（存疑，暂时以无摄动轨道周期代替）

    a与i之一必须给定其一，另一个参数通过计算得到
    """
    def __init__(self,D=1,N=1,a=0,i=0):
        # 检查N和D是否是整数
        if not (isinstance(D,int) and isinstance(N,int)):
            raise ValueError("N and D must be an integer")

        # 检查a和i是否正确赋值
        if a and i:
            raise ValueError("a and i can't input in same time")
        elif not (a or i):
            raise ValueError("a or i must have a value")
        
        self.omegae=7.3e-5
        self.aE=6378160
        self.j2=1.0826e-3
        self.miu=3.986005e14

        self.D=D
        self.N=N
        self.a=a
        self.i=i

        pi=math.pi

        if a:
            def equation(x):  
                return self.N*(2*pi/np.sqrt(self.miu/(self.a**3)))*(1-(3*self.j2*(12-10*(np.sin(x)**2)))/(8*self.a**2))-self.D*2*pi/(self.omegae-((-(3*self.j2*self.aE**2)/(2*self.a**2))*np.sqrt(self.miu/(self.a**3))*np.cos(x)))
            x0 = np.deg2rad(15)

            sol = fsolve(equation, x0)  
            print(np.rad2deg(sol))
        else:
            def equation(x):  
                return self.N*(2*pi/np.sqrt(self.miu/(x**3)))*(1-(3*self.j2*(12-10*(np.sin(self.i)**2)))/(8*x**2))-self.D*2*pi/(self.omegae-((-(3*self.j2*self.aE**2)/(2*x**2))*np.sqrt(self.miu/(x**3))*np.cos(self.i)))
            x0 = 7000000
            sol = fsolve(equation, x0)  
            print(sol)
        

  



# obj=RoundTrack(1,15,0,np.deg2rad(60))





            


































class satellite:
    """
    卫星类，默认以 STARLINK-31328 - 轨道参数
    a:半长轴
    b:偏心率
    i:轨道倾角
    w:近地点幅角
    Omega0:初始时刻升交点赤经
    M0:初始时刻平近点角
    bOmega:升交点赤经变化率
    bM:平近点角变化率
    G0:起始时刻格林威治恒星时角
    we:地球自转速度

    theta:卫星相位
    t:卫星现在运行时刻

    Omega:升交点赤经
    M:平近点角

    """
    def __init__(
        self,
        a=481.5,
        e=0.0001325,
        i=53.1557,
        w=81.8308,
        Omega0=182.3353,
        M0=325.1008,
        bOmega=0.001,
        bM=1,
        G0=150,
        omegae=np.degrees(7.23e-5)
        ):
        self.M0=M0
        self.Omega0=Omega0
        self.bM=bM
        self.bOmega=bOmega
        self.i=i
        self.G0=G0
        self.omegae=omegae
        # 初始时刻赤经和赤纬
        self.delta=math.asin(math.sin(math.radians(self.M0))*math.sin(math.radians(i)))
        self.alpha=Omega0+math.atan(math.tan(math.radians(self.M0))*math.cos(math.radians(i)))
        # 初始时刻星下点地心经纬度
        self.lamda=self.alpha-(G0+omegae*0)
        self.phi=self.delta



    def update(self,theta,t):
        """
        更新卫星在特定相位和特定时间下的星下点
        """
        self.M=self.M0+theta+self.bM*t
        self.Omega=self.Omega0+self.bOmega*t

        # self.delta=math.asin((math.sin(self.M))*math.sin(self.i))
        # self.alpha=self.Omega+math.atan(math.tan(self.M)*math.cos(self.i))
        self.delta=math.asin((math.sin(math.radians(self.M)))*math.sin(math.radians(self.i)))
        self.alpha=self.Omega+math.atan(math.tan(math.radians(self.M))*math.cos(math.radians(self.i)))

        self.lamda=self.alpha-(self.G0+self.omegae*t)
        self.phi=self.delta
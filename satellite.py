import math

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
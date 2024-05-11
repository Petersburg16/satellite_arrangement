# 卫星定轨问题

import numpy as np
from .satellite import satellite



st1=satellite()
st1.update(180,2)

import numpy as np  
import matplotlib.pyplot as plt  
from mpl_toolkits.basemap import Basemap  
  
# 假设你的satellite类已经定义好了，这里不再重复  
# ...  
  
# 创建一个空的列表来存储经纬度信息  
spot_st1 = []  
spot_st1_t5000 = None  # 用于存储在t=5000时st1的位置  
spot_st2 = []  
spot_st2_t5000 = None  # 用于存储在t=5000时st2的位置  
# 初始化卫星对象  
st1 = satellite()  
st2  = satellite()  
# 遍历时间t从0到1000  
for t in range(100000):  # 假设你仍然需要这个范围内的数据点  
    st1.update(0, t)  
    st2.update(40, t)  
      
    # 将经纬度转换为度数，并添加到spot列表中  
    spot_st1.append((np.degrees(st1.lamda), np.degrees(st1.phi)))  
    spot_st2.append((np.degrees(st2.lamda), np.degrees(st2.phi)))  
      
    # 检测t=5000时的位置并存储  
    if t == 6000:  
        spot_st1_t5000 = (np.degrees(st1.lamda), np.degrees(st1.phi))  
        spot_st2_t5000 = (np.degrees(st2.lamda), np.degrees(st2.phi))  
# 绘制地图和点  
fig = plt.figure(figsize=(10, 5))  
ax = fig.add_subplot(111)  
  
# 创建一个Basemap实例，这里以全球地图为例  
map = Basemap(projection='robin', lon_0=0, lat_0=0, resolution='l')  
  
# 填充大陆并绘制海岸线、国界等  
map.fillcontinents(color='coral', lake_color='aqua')  
map.drawmapboundary(fill_color='aqua')  
map.drawcoastlines()  
map.drawcountries()  
  
# 绘制卫星轨迹点  
lons_st1, lats_st1 = zip(*spot_st1)  
lons_st2, lats_st2 = zip(*spot_st2)  
map.scatter(lons_st1, lats_st1, latlon=True, color='red', marker='o', s=10, label='Satellite 1')  
map.scatter(lons_st2, lats_st2, latlon=True, color='blue', marker='x', s=10, label='Satellite 2')  
if spot_st1_t5000:  
    map.scatter(spot_st1_t5000[0], spot_st1_t5000[1], latlon=True, color='yellow', marker='*', s=50, label='Satellite 1 @ t=5000')  
if spot_st2_t5000:  
    map.scatter(spot_st2_t5000[0], spot_st2_t5000[1], latlon=True, color='green', marker='^', s=50, label='Satellite 2 @ t=5000')    
# 添加图例  
plt.legend()  
  
# 显示地图  
plt.show()

  

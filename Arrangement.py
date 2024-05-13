# 卫星定轨问题
import math  
import numpy as np  
import matplotlib.pyplot as plt  
import cartopy.crs as ccrs  
import cartopy.feature as cfeature  
import satellite




# 创建两个卫星对象  
sat1 = satellite.satellite()  # 使用默认参数，代表STARLINK-31328  
sat2 = satellite.satellite()  # 另一个示例卫星  
  

# 设置 theta值  
theta1 = 15  
theta2 = 30  

# 设置模拟的时间值  
time_values = np.linspace(0, 10000, 480000)  # 一天的时间，每小时一个点  

# 存储两个卫星的轨迹  
tracks = {  
    'sat1': [],  
    'sat2': []  
}  
  
# 模拟并存储卫星轨迹  
for t in time_values:  
    sat1.update(theta1, t)  
    sat2.update(theta2, t)  
    tracks['sat1'].append((np.rad2deg(sat1.lamda) % 360, np.rad2deg(sat1.phi)))  
    tracks['sat2'].append((np.rad2deg(sat2.lamda) % 360, np.rad2deg(sat2.phi)))
  
  
# 绘制卫星轨迹  
def plot_satellite_tracks(tracks):  
    fig = plt.figure(figsize=(20, 5))  
    ax = fig.add_subplot(1, 1, 1, projection=ccrs.PlateCarree())  
    ax.add_feature(cfeature.LAND)  
    ax.add_feature(cfeature.OCEAN)  
    ax.add_feature(cfeature.COASTLINE)  
    ax.add_feature(cfeature.BORDERS, linestyle=':')  
  
    for sat, track in tracks.items():  
        lons, lats = zip(*track)  
        ax.plot(lons, lats, label=f'Satellite {sat[-1]}')  
  
    ax.legend()  
    plt.show()  
  
# 调用绘图函数  
plot_satellite_tracks(tracks)



  

  

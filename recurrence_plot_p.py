import numpy as np
import matplotlib.pyplot as plt
from scipy.spatial import distance

def recurrence_plot(s, eps=None, steps=None):
    if eps==None: eps=0.1
    if steps==None: steps=10
    d = distance.cdist(s,s,metric='euclidean')
    d = np.floor(d / eps)
    d[d > steps] = steps
    return d

sin_m = np.sin(np.linspace(0, 6 * np.pi, 1000))
dist_m = recurrence_plot(sin_m[:,None])

plt.title("sine wave")
plt.imshow(dist_m)
plt.savefig("recurrence_plot_py.png")

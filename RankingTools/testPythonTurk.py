import numpy as np
import scipy.io as sio
from Hodge import *

R = sio.loadmat("TurkRankings.mat")["R"]
N = R.shape[0]
(s, I, H) = doHodge(R[:, 0:2], np.ones(N), R[:, 2].flatten())
print s

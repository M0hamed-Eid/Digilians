# -*- coding: utf-8 -*-
"""
Created on Thu Jan 29 17:05:41 2026

@author: DR_SAYED
"""

import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import solve_ivp

# ---------------- Parameters ----------------
V1, V2, V3 = 20.0, 15.0, 4.0
r = 60.0
x0 = np.array([28.0, 11.0, 0.0])   # [x1(0), x2(0), x3(0)]

a1, a2, a3 = r/V1, r/V2, r/V3      # 3, 4, 15

# ---------------- ODE model -----------------
def tank3_ode(t, x):
    x1, x2, x3 = x
    dx1 = -a1*x1 + a3*x3
    dx2 =  a1*x1 - a2*x2
    dx3 =  a2*x2 - a3*x3
    return [dx1, dx2, dx3]

# ---------------- Analytical solution ----------------
def x_analytic(t):
    t = np.asarray(t)
    x1 = 20.0 + 3.0*np.exp(-13.0*t) + 5.0*np.exp(-9.0*t)
    x2 = 15.0 - 1.0*np.exp(-13.0*t) - 3.0*np.exp(-9.0*t)
    x3 =  4.0 - 2.0*np.exp(-13.0*t) - 2.0*np.exp(-9.0*t)
    return x1, x2, x3

# ---------------- Time grid ----------------
t0, tf = 0.0, 1.0   # minutes (increase tf if you want longer)
t_eval = np.linspace(t0, tf, 1000)

# ---------------- Numerical solution ----------------
sol = solve_ivp(tank3_ode, (t0, tf), x0, t_eval=t_eval, rtol=1e-10, atol=1e-12)
t = sol.t
x_num = sol.y  # rows: x1,x2,x3

# Analytical on same grid
x1a, x2a, x3a = x_analytic(t)

# ---------------- Verification ----------------
err1 = np.max(np.abs(x_num[0] - x1a))
err2 = np.max(np.abs(x_num[1] - x2a))
err3 = np.max(np.abs(x_num[2] - x3a))

print("Max |numerical - analytical| errors:")
print(f"x1: {err1:.3e}, x2: {err2:.3e}, x3: {err3:.3e}")

# Check conservation numerically:
total = x_num[0] + x_num[1] + x_num[2]
print(f"Total salt (should be 39): min={total.min():.6f}, max={total.max():.6f}")

# Steady-state values:
print("Steady-state (t->inf): x1*=20, x2*=15, x3*=4")

# ---------------- Plot ----------------
plt.figure()
plt.plot(t, x_num[0], linewidth=2, label="x1(t) numerical")
plt.plot(t, x_num[1], linewidth=2, label="x2(t) numerical")
plt.plot(t, x_num[2], linewidth=2, label="x3(t) numerical")

plt.plot(t, x1a, linestyle="--", linewidth=2, label="x1(t) analytic")
plt.plot(t, x2a, linestyle="--", linewidth=2, label="x2(t) analytic")
plt.plot(t, x3a, linestyle="--", linewidth=2, label="x3(t) analytic")

plt.grid(True)
plt.xlabel("Time (min)")
plt.ylabel("Salt amount")
plt.title("3-Tank Closed Brine System: numerical vs analytical")
plt.legend()
plt.show()

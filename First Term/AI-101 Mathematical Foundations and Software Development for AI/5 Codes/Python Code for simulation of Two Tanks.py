# Closed 2-tank brine system: plot x1(t), x2(t)
# V1=25 L, V2=40 L, r=10 L/min
# x1'(t) = -(r/V1) x1 + (r/V2) x2
# x2'(t) =  (r/V1) x1 - (r/V2) x2
# IC: x1(0)=13, x2(0)=0

import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import solve_ivp

# -------------------- Parameters --------------------
V1, V2 = 25.0, 40.0
r = 10.0
x0 = np.array([13.0, 0.0])  # [x1(0), x2(0)]

# Steady-state (limiting) amounts (closed system -> equal concentration)
# c* = total_salt / (V1+V2), so x1* = V1*c*, x2* = V2*c*
total_salt = x0.sum()
c_star = total_salt / (V1 + V2)
x1_star, x2_star = V1 * c_star, V2 * c_star

# -------------------- ODE model --------------------
def tank_ode(t, x):
    x1, x2 = x
    dx1 = -(r / V1) * x1 + (r / V2) * x2
    dx2 =  (r / V1) * x1 - (r / V2) * x2
    return [dx1, dx2]

# -------------------- Time span --------------------
t0, tf = 0.0, 50.0              # minutes (increase/decrease as you like)
t_eval = np.linspace(t0, tf, 1000)

# -------------------- Solve numerically --------------------
sol = solve_ivp(tank_ode, (t0, tf), x0, t_eval=t_eval, rtol=1e-10, atol=1e-12)

t = sol.t
x1 = sol.y[0, :]
x2 = sol.y[1, :]

# -------------------- Plot --------------------
plt.figure()
plt.plot(t, x1, linewidth=2, label=r"$x_1(t)$")
plt.plot(t, x2, linewidth=2, label=r"$x_2(t)$")

# steady-state lines
plt.axhline(x1_star, linestyle="--", linewidth=1.5, label=r"$x_1(\infty)$")
plt.axhline(x2_star, linestyle="--", linewidth=1.5, label=r"$x_2(\infty)$")

plt.grid(True)
plt.xlabel("Time (min)")
plt.ylabel("Salt amount")
plt.title("Closed 2-Tank Brine System: $x_1(t), x_2(t)$")
plt.legend()
plt.show()

print(f"Steady-state: x1(∞) = {x1_star:.6f}, x2(∞) = {x2_star:.6f}")
print(f"Total salt check (should be constant 13): min={np.min(x1+x2):.6f}, max={np.max(x1+x2):.6f}")



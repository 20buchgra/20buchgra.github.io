The Boost Converter is one of the three basic pwm-based smps.
Understanding this design is paramount for power electronics
![469](Figures/boost.png)

### Steady-State
$$<I_C>=D(-\frac{V}{R})+D'(I_L-\frac{V}{R})$$
$$<V_L> = D(V_{in}-I_LR_L-I_LR_1-0)+D'(V_{in}-I_LR_L-I_LR_2-V)$$
$$\frac{V}{V_{in}}=\frac{1}{D'}\frac{D'^2R}{D'^2R+DR_1+D'R_2+R_L}$$
$$\eta =\frac{D'^2R}{D'^2R+DR_1+D'R_2+R_L} $$
$$D = 1-\frac{\eta V_{in}}{V}=1-\frac{V_{in}R+V(R_1-R_2)+\sqrt{(V_{in}R+V(R_1-R_2))^2-4V^2R(R_1+R_L)}}{2VR}$$
### Ripple
$$\Delta i_L=\frac{D(V_{in}-I_LR_L-I_LR_1-0)}{2Lf}$$
$$\Delta v_C=\frac{\Delta i_L}{8Cf}$$
### RMS Currents
$$I_{L_{RMS}} = I_L^2+\frac{D^2(V_{in}-I_LR_L-I_LR_1-0)^2}{12L^2f^2}$$
### Losses
$$P_R = I_{L_{RMS}}(DR_1+D'R_2+R_L)$$
$$P_{sw} = f(V_{gs}(Q_1+Q_2)+0.5V_{in}^2(C_1+C_2)+0.5t_{ov}V_{in}I_L)$$

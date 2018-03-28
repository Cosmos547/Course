# Sinple bar finite element method

Consider a bar of length $l$ and using $2$ nodes at each end. So we will have
$$x_1 = 0, x_2 = l$$

At each node the displacement ond force function are $q_i(t), Q_i(t)$ respectfully.

Now, assume a simple shape function for the bar
$$u(x,t) = a_0 + a_1x$$

We want to convert the differential equation

$$\ddot{u}(x, t) = c^2 u''(x,t)$$

where $\ddot{u},u''$ are second derivatives relative to time and displacement respectfully.

To a system of ordinary differential equations

$$[m]\ddot{u}(t) + [k]u(t) = \vec{F}(t)$$

that can be easily solved by a computer.

With the previously shape function, we can combine the boundry conditions

$x=0, u(0,t) = q_1(t)$

to get  

$$a_0 = q_1(t)$$

and

$$ x = l, u(l,t) = q_2(t)$$

to get

$$a_1 = \frac{q_2(t) - q_1(t)}{l}$$

Now replug the value back to the orginal shape function we can get

$$ \begin{align} u(x,t) & = q_1 + \frac{q_2 - q_1}{l} x \\ & = \begin{bmatrix} 1- \frac{x}{l} & \frac{x}{l} \end{bmatrix} \begin{bmatrix} q_1 \\ q_2 \end{bmatrix} \end{align}$$

We will rewrite the two parts as

$$u(x,t) = \vec{\Phi^T}(x) \cdot \vec{q}(t) $$
Where $\vec{\Phi^T}​$ is the shape function and $\vec{q}​$ is the nodal coordinates.

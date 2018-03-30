# Simple bar finite element method

Consider a bar of length $l$ and using $2$ nodes at each end. So we will have
$$x_1 = 0, x_2 = l$$

At each node the displacement and force function are $q_i(t), Q_i(t)$ respectfully.

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

$$u(x,t) = \vec{\phi^T}(x) \cdot \vec{q}(t) $$
Where $\vec{\phi^T}$ is the shape function and $\vec{q}$ is the nodal coordinates.

From the previous equation we can derive the following:

$$\begin{align} \dot{u} &= \phi^T \vec{\dot{q}} \\ \ddot{u} &= \vec{\dot{q}^T} \vec{\phi}\vec{\phi^T} \vec{\dot{q}} \\ u' & = \vec{\phi'} \vec{q} \\u'' &= \vec{q^T} \vec{\phi^\prime} {\vec{\phi^{\prime T}}}  \vec{q} \end{align}  $$

Now we can use the conservation of energy in kinetic energy and strain energy to determine the mass matrix and stiffness matrix separately.

For the mass matrix, if we assume the bar has constant density $\rho$, constant elasticity $E$  and area $A$ we have

$$\begin{align}T &= \frac{1}{2} \rho A \int_{0}^{L} \dot{u}^2 (x,t)dx  \\ u &= \frac{1}{2} \int_v EA {u'}^2(x,t)\end{align}$$

By expanding the equation we can derive the mass and stiffness matrix

$$[m] = \frac{\rho A l}{6} \begin{bmatrix} 2 & 1 \\ 1 & 2\end{bmatrix}$$

$$[k] = \frac{EA}{l} \begin{bmatrix} 1 & -1 \\ -1 & 1 \end{bmatrix}$$

Now we can use to calculate the fundamental frequencies $\omega$ (which is the square root of the eigenvalue of the system) of a given bar element by the following equation.

$$\det[[k] - \omega^2[m]] = 0 $$

The previously discussed system is flexible enough to calculate the result for a arbitrary number of nodes for the finite element method.

Now we arrive with all the calculated frequencies. We can derive the final wave file of the sum of them. To calculate the excitement for each frequency by using the delta function. We have the following

$$a_n = \frac{\psi_n}{c \alpha_n \omega_n}$$

where $\psi_n$ is the eigenvector corresponding to the fundamental frequencies and $\alpha_n$ is it's norm.

So now we can add up each element and create the final sound.
<!-- $theme: gaia
	  page_number:true -->


Physically based sound
===
#### Simple Bar element case
###### By Wenhan Zhu (Cosmos)

---
Overview of Physically base sound rendering
===
Synthesize realistic sounds from physical models of the geometry and material properties of objects.
- ==**Factors**==
	1. Shape
	2. Location of impact
	3. Force of impact
	4. Material of object

---
##### Model Vibrating object using FEM (Finite Element Method)

Assue a simple bar model with shape function

$$\ddot{u}(x,t) = c^2u''(x,t)$$

We want to transform it in to a system of ODE so the computer can solve it efficiently.
$$ M \ddot{u}(t) + C\dot{u}(t) + Ku(t) = \vec{F}(t) $$

<!-- *footer: Kees van den Doel, Dinesh K. Pai -- The sound of Physical Shapes. Presence. Vol. 7 No. 4 Augest 1998 382-395 -->

---
From the simple shape function we can calculate the mass and stiffness matrices by boundry conditions. 

Then we can solve the system of ODE to get the foundamental frequencies of different vibration modes.

Then by adding up each vibration modes we can get the final wave function.

---

![](result.gif)

---
##### Limitations
- Can't model nonlinear sound such as acceleration noise (Chadwick2012) and thin shell sounds 
- Require knowledge of material properties
- Needs precomputing of sound model

<!-- *footer: Jeffery N. Chadwick, Changxi Zheng, Doug L. James. Precomputed acceleration noise for improved rigid-body sound. SIGGRAPH. August 2012. -->

---
##### Other things in the rendering pipeline
- Acoustics Transfer (James 2006)
- Physics simulation engine (PhysX, Havok. etc)


<!-- *footer: Dinesh K. Pai, Doug L. James, Jernej Barbic. Precomputed acoustic transfer: Output-sensitive, accurate sound generation for geometrically complex vibration sources. SIGGRAPH. 2006 -->



# <img src="https://user-images.githubusercontent.com/4486578/57202054-3d1c4400-6fe4-11e9-97d7-9a1ffbfcb2fc.png" width=20% align=right>
#
# # The F-1 algorithm
#
# > The F-1 algorithm for efficient computation of the Hessian matrix of an objective function defined implicitly by the solution of a steady-state problem
#
# <font color='gray'>Benoît Pasquier and François Primeau</font>
#
# <font size='small'>submitted to the SIAM Journal of Scientific Computing<br>
# (but accessible at [www.bpasquier.com](www.bpasquier.com))</font>




# # Optimizing under a steady-state constraint

#
#



# <img src="https://user-images.githubusercontent.com/4486578/61168832-54a11b80-a597-11e9-956e-affcd4e8a148.png" width=50%>
# 

# # Toy Example

# Start by loading the packages

using F1Method
using Optim
using NLsolve



# State function $\boldsymbol{F}(\boldsymbol{x},\boldsymbol{p})$ based on the Rosenrbock "banana" function.

F(x,p) = [
    -2 * (p[1] - x[1]) - 4 * p[2] * (x[2] - x[1]^2) * x[1]
    p[2] * (x[2] - x[1]^2)
]

# Autodiff the Jacobian of $\boldsymbol{F}$ w.r.t. $\boldsymbol{x}$

∇ₓF(x,p) = ForwardDiff.jacobian(x -> F(x,p), x)

# Define the objective function 

f(x,p) = 0.5(x .- 1)'(x .- 1) + 0.5log.(p)'log.(p)

# And its derivative

∇ₓf(x,p) = ForwardDiff.jacobian(x -> [f(x,p)], x)

# Define a Newton solver? TODO use NLsolve instead


# Starting point

x, p = [1.0, 2.0], [3.0, 4.0]

# Initialize the cache for storing reusable objects

mem = F1Method.initialize_mem(x₀, p₀)

# Define the functions via the F1 method

obj(p) = F1Method.objective(f, F, ∇ₓF, mem, p, MyAlg())
grad(p) = F1Method.gradient(f, F, ∇ₓf, ∇ₓF, mem, p, MyAlg())
hess(p) = F1Method.hessian(f, F, ∇ₓf, ∇ₓF, mem, p, MyAlg())

# Test them

obj(p)
grad(p)
hess(p)




# optimize it TODO



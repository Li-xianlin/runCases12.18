 function [X, varargout] = ode4m(odefun,t,x0,varargin)
%ODE4M  Solves differential equations with a fixed-step method of order 4.
%   X = ODE4M(ODEFUN,T,X0) integrates the system of differential equations
%   xDot = f(t,x)
%   	ODEFUN(T,X) Function that returns f(t,x) in a column vector.
%       T	Column vector of sample times.
%       X0 	Initial conditions at T0.
%
%   X = ODE4M(ODEFUN,T,X0,P1,P2...) passes the additional parameters 
%       P1,P2 to ODEFUN(T,X,P1,P2...). 
%
%   [X,Y] = ODE4M(ODEFUN,T,X0,...) computes additional output variables
%       [XDOT,Y]=ODEFUN(T,X,...)
%
%   This is a fixed-step solver, where the step sequence is determined by
%   the time vector T. 
%   The solver implements the classical Runge-Kutta method of order 4,
%   where ODEFUN is evaluated multiple times per step.
%
%   Example 
%       t = [0:0.01:10];
%       x = ode4m(@vdp1,t,[2 0]);
%       plot(t,x), legend('x_1','x_2')
%

%   Glenn-Ole Kaasa
%   Hydro Oil & Energy Research Centre, Porsgrunn
%   $Revision: 1.1 $  $Date: 2008/07/25 08:48:03 $
%   $Description of change: Created.
%   $History: 
%       1.0 - 2007/07/25, modified version of MathWork's ode4.m.

%% VERIFIES INPUTS
if ~isnumeric(t)
  error('T should be a vector of integration steps.');
end

if ~isnumeric(x0)
  error('X0 should be a vector of initial conditions.');
end

h = diff(t);
if any(sign(h(1))*h <= 0)
  error('Entries of T are not in order.') 
end  

try
    if nargout==2 % If additional outputs
        [f0,y0] = feval(odefun,t(1),x0,varargin{:});
    else
        f0 = feval(odefun,t(1),x0,varargin{:});
    end
catch
  msg = ['Unable to evaluate the ODEFUN at t0,x0. ',lasterr];
  error(msg);  
end  
x0 = x0(:);   % Make a column vector.
if ~isequal(size(x0),size(f0))
  error('Inconsistent sizes of X0 and f(t0,x0).');
end  

%% 
neq = length(x0);   % Number of equations
N = length(t);      % Number of samples
X = zeros(neq,N);   % Allocates state vector
F = zeros(neq,4);

X(:,1) = x0;

%% SIMULATION FOR-LOOP:
for i=2:N
  ti = t(i-1);
  hi = h(i-1);
  xi = X(:,i-1);
  if nargout==2 % Computes additional outputs
  	[F(:,1),Y(:,i)] = feval(odefun,ti,xi,varargin{:});
  else          % ...or no additional  outputs.
  	F(:,1) = feval(odefun,ti,xi,varargin{:});
  end
  F(:,2) = feval(odefun,ti+0.5*hi,xi+0.5*hi*F(:,1),varargin{:});
  F(:,3) = feval(odefun,ti+0.5*hi,xi+0.5*hi*F(:,2),varargin{:});  
  F(:,4) = feval(odefun,t(i),xi+hi*F(:,3),varargin{:});
  X(:,i) = xi + (hi/6)*(F(:,1) + 2*F(:,2) + 2*F(:,3) + F(:,4));
end
X = X.';
if nargout==2
    varargout(1) = {Y.'};
end
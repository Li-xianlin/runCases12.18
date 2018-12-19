%%%%
% Some nice constants
%%%%
function tuningPar = getTuningPar()

tuningPar.simLength = 1600;     %Simulation length (sec)
tuningPar.stepSize  = 0.1;      %Stepsize for ode45
tuningPar.qres      = 0.0;      %Flow to/from reservoir
tuningPar.Zc        = 1;      %Choke opening

tuningPar.l1        = 1e-7; %Observergain

tuningPar.Gamma     = diag([5e4,5e-9]); %Adaption gain


tuningPar.tf        = 1;

tuningPar.Kp        = 1;%%´ø¿ØÖÆ£¿£¿
tuningPar.Ki        = 1;
tuningPar.PcRef     = 6;

% Poly/kalman
tuningPar.H = diag([2,1/10,1]);

tuningPar.B = 1;%diag([1 1e-5 1e-5]);
tuningPar.b = tuningPar.H\diag([1,1e-3,5e2]);

tuningPar.R = tuningPar.B*tuningPar.B';

%GRIP
tuningPar.gamma0 = 10;
%tuningPar.GammaG = 1e5;

tuningPar.GammaGBig = diag([5e3, 8e-9]);
%tuningPar.GammaGBig = diag([7e4, 2e-9]);
end
function tuningPar = getTuningPar()

tuningPar.simLength = 1600;     %Simulation length (sec)
tuningPar.stepSize  = 0.1;      %Stepsize for ode45
tuningPar.qres      = 0.0;      %Flow to/from reservoir
% tuningPar.Zc        = 1;      %Choke opening
tuningPar.tf        = 1;

% tuningPar.Kp        = 1;%%´ø¿ØÖÆ£¿£¿
% tuningPar.Ki        = 1;
% tuningPar.PcRef     = 6;

end
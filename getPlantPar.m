%%%%
% Some nice constants
%%%%
function plantPar = getPlantPar()

plantPar.Vd     = 28.2743;  %Volume drillstring [m^3]
plantPar.betad  = 14000;    %Bulk modulus mud [Bar] =  e-5[Pa] = [N/m^2] = [kg/m*s^2]
plantPar.Va     = 96.1327;  %Volume annulus [m^3]
plantPar.betaa  = 14000;    %Bulk modulus annulus [Bar] 
plantPar.Ma     = 1.6009e3; %"Mass" in annulus [kg/m^4]
plantPar.Md     = 5.7296e3; %"Mass" in drillsting [kg/m^4]
plantPar.Fd     = 0.16500e6;%Friction factor drill string [kg/m^7]
plantPar.Fa     = 0.02080e6;%Friction factor annulus [kg/m^7]
plantPar.rhod   = 0.0125;   %Density in drillstring [kg/m^3]
plantPar.rhoa   = 0.0125;   %Density in annulus [kg/m^3]
plantPar.Kc     = 0.0046;   %Choke valve constant [m^2]
plantPar.p0     = 1;        %Pressure outside plant [Bar]
plantPar.g      = 9.81;     %Gravity :) [m/s^2]
    
end
%% Function to run simulation and make plots
clear all;
close all;
clc;

%Get constants
plantPar    = getPlantPar();
tuningPar   = getTuningPar();
initPar     = getInitPar(plantPar, tuningPar);
[qpump qback hbit VaDot] = makeCase11();

%Run simulation
[Pp, Pc, qbit, qchoke, Pbit, Zc]...
    = simulateStamnes(plantPar, tuningPar, initPar, qpump, qback, hbit, VaDot);

qpumpL = [qpump qpump];
qbackL = [qback qback];
hbitL  = [hbit hbit];
VaDotL  = [VaDot VaDot];


%PLOTS
time = 0:tuningPar.simLength;
M = plantPar.Ma + plantPar.Md;
g = plantPar.g;
rhod = plantPar.rhod;
rhoa = plantPar.rhoa;
Fd = plantPar.Fd;
Fa = plantPar.Fa;
F = Fd + Fa;

%% Pressures
figure();
subplot(311),plot(time, Pp,time, 10*Pc);
ylabel('Pressure [Bar]');
xlabel('Time [s]');
legend('Pp', '10*Pc');
grid on;


subplot(312),plot(time, Pbit);
xlabel('Time [s]');
ylabel('Pressure [Bar]');
legend('p_{bit}');
grid on;

subplot(313),plot(time, hbit, time, VaDot);
xlabel('Time [s]');
ylabel('Pressure [Bar]');
legend('h_{bit}', 'V_a');
grid on;
%%
% Flows
figure();
subplot(311), plot(time, qpumpL(1:time(end)+1)*6e4, time, qbackL(1:time(end)+1)*6e4);
xlabel('Time [s]');
ylabel('Flow [l/min]');
legend('q_{pump}', 'q_{back}');
grid on;

subplot(312), plot(time, qbit*60e3);
xlabel('Time [s]');
ylabel('Flow [l/min]');
legend('q_{bit}');
grid on;

subplot(313), plot(time, qchoke*60e3, time, Zc*1000);
xlabel('Time [s]');
ylabel('Flow [l/min]');
legend('q_{choke}', 'Zc');
grid on;



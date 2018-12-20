function [Pp, Pc, qbit, qchoke, Pbit] =...
    simulateStamnes(plantPar, tuningPar, initPar, qpump, qback, hbit, VaDot,Zc )


y0 = [initPar.Pp0 initPar.Pc0 initPar.qbit0]';%%σsigma  ξ xi

simLength = tuningPar.simLength;
stepSize    = tuningPar.stepSize;

Pp      = zeros(1, simLength+1);%%一行1601列 时间为0:1600 为1601
Pc      = zeros(1, simLength+1);
Pbit    = zeros(1, simLength+1);
qbit    = zeros(1, simLength+1);
qchoke  = zeros(1, simLength+1);
% Zc      = zeros(1, simLength+1);

Pp(1)       = initPar.Pp0;%%赋予初值
Pc(1)       = initPar.Pc0;
qbit(1)     = initPar.qbit0;
Pbit(1)     = 240;

%%%for循环，ode4m迭代求解
for time = 2:simLength+1
  %  clc
   % time-1
    timeSpan = time:stepSize:time+1;
    
    [yOut xtraOut] = ode4m(@(t, y) totalSystem(t, y, plantPar, tuningPar, qpump(mod(time,1601)+1), qback(mod(time,1601)+1), hbit(mod(time,1601)+1),VaDot(mod(time,1601)+1),Zc(mod(time,1601)+1)), timeSpan, y0);
    Pp(time)        = max(1,yOut(end, 1));
    Pc(time)        = max(0,yOut(end, 2));
    qbit(time)      = max(0,yOut(end, 3));
    qchoke(time)    = xtraOut(end).var1;
    Pbit(time)      = xtraOut(end).var2;
%     Zc(time)        = xtraOut(end).var3;
   
    y0 = [max(1,yOut(end, 1))
          max(0,yOut(end, 2))
          max(0,yOut(end, 3))];
   
end   
end

function [dydt xtra] = totalSystem(t,y,plantPar, tuningPar, qpump, qback, hbit, VaDot, Zc)

% persistent eSum;%%persistent 持久变量 一般与if（isempty())搭配
% if(isempty(eSum))%%esum为空变量
%     eSum = 0;
% end

%Plant parameters
Vd      = plantPar.Vd;
betad   = plantPar.betad;
Va      = plantPar.Va;
betaa   = plantPar.betaa;
Ma      = plantPar.Ma;
Md      = plantPar.Md;
M       = Ma+Md;
Fd      = plantPar.Fd;
Fa      = plantPar.Fa;
rhod    = plantPar.rhod;
rhoa    = plantPar.rhoa;
Kc      = plantPar.Kc;
P0      = plantPar.p0;
g       = plantPar.g;

%%%开环响应
% Tuning parameters
% Zc      = tuningPar.Zc;

qres    = tuningPar.qres;


%Some defined constants
a1 = betad/Vd;
a2 = 1/M;

%States
Pp      = max(1,y(1));
Pc      = max(0,y(2));
qbit    = max(0,y(3));

% % Choke
% PcRef   = tuningPar.PcRef;
% e       = Pc - PcRef;
% eSum    = eSum + e;
% Kp      = tuningPar.Kp;
% Ki      = tuningPar.Ki;
% Zc      = Kp*e + Ki*eSum;%%累加
% Zc      = max(0,Zc);
% Zc      = min(Zc, 1);

qchoke  = Kc*Zc*sqrt(2/rhoa*(Pc-P0));

% Plant
PpDot   = a1*(qpump - qbit);
PcDot   = betaa/Va*(qbit + qback -qchoke + qres - VaDot);
qbitDot = a2*(Pp - Pc -Fd*abs(qbit)*qbit -...
            Fa*abs(qbit + qres)*(qbit+qres) + (rhod - rhoa)*g*hbit);

Pbit    = Pc + Ma*qbitDot + Fa*abs(qbit+qres)*(qbit+qres) + rhoa*g*hbit;

% Additional output variables
xtra.var1 = qchoke;
xtra.var2 = Pbit;
% xtra.var3 = Zc;
%Collect the dynamtics
if (Pp <=1 && PpDot < 0)
    PpDot = 0;
end
if (Pc <= 0 && PcDot < 0)
    PcDot = 0;
end
if( qbit <= 0 && qbitDot < 0)
    qbitDot = 0;
end
dydt = [PpDot; PcDot; qbitDot];

end
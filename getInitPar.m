function initPar = getInitPar(plantPar, tuningPar)

initPar.Pp0     = 80;
initPar.Pc0     = 8;
initPar.PcHat0  = initPar.Pc0;
initPar.qbit0   = 200/6e4;
initPar.qbitHat0= 700/6e4;
initPar.xf0     = 0.15;       
        l1      = tuningPar.l1;%observer gain可调
initPar.xiHat0  = initPar.qbitHat0+l1*initPar.Pp0;%%推导出来直接写

        theta10  = (plantPar.Fd+2*plantPar.Fa)/(plantPar.Ma+plantPar.Md);
initPar.thetaHat0 = [theta10;-8.3640e-006];

%-8.3640e-006
a1      = plantPar.betad/plantPar.Vd;
hbit    = 1820;
Gamma   = tuningPar.Gamma;%%Γ

initPar.sigmaHat0= initPar.thetaHat0...
    + Gamma*[abs(initPar.qbitHat0)^3/(3*l1*a1); -hbit*initPar.qbitHat0/(l1*a1)];%%推导出来直接写

initPar.theta3Hat0 = 14000;

%POLY/KALMAN
initPar.x0 = [initPar.Pp0, initPar.qbit0, plantPar.Fd + plantPar.Fa];
initPar.xHat0 = [initPar.Pp0, initPar.qbitHat0, plantPar.Fd+2*plantPar.Fa];
initPar.P0 = 1e-3*eye(3);%[1 1 1;1 1 1; 1 1 1];

end
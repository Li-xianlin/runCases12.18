function [qpump qback hbit VaDot] = makeCase11()
%%%²»¿¼ÂÇ»ØÑ¹£¬qback=0;

simLength = 1600;

qpump = zeros(1, simLength+1);
qback = zeros(1, simLength+1);
hbit  = zeros(1, simLength+1);
VaDot = zeros(1, simLength+1);

    for i = 1:400
        qpump(i)    = 1500/6e4;
%         hbit(i)     = 1826;%+0.1*i;
%          hbit(i)     = 1826+0.1*i;
          hbit(i)     = 1826;    
        VaDot(i)    = 0;
    end 
    
    for i = 401:520
%         qpump(i)    = (1500-((i-400)*1500/120))/6e4;
        qpump(i)    = 1500/6e4;
%         hbit(i)     = hbit(i-1);
        hbit(i)     = 1826;  
        VaDot(i)    = 0;
    end

    for i = 521:1120
        qpump(i)    = 1500/6e4;
%         hbit(i)     = 1826;%+(i-520)*0.1;
%         hbit(i)     = hbit(i-1);
        hbit(i)     = 1826;  
        VaDot(i)    = 0;
    end

    for i = 1121:1240
%         qpump(i)    = (i-1120)*(1500/120)/6e4;
        qpump(i)    = 1500/6e4;
%         hbit(i)     = hbit(i-1);
        hbit(i)     = 1826;  
        VaDot(i)    = 0;
    end
    
    for i = 1241:1601
        qpump(i)    = 1500/6e4;
%         hbit(i)     = 1826;% + (i-1240)*0.1
%         hbit(i)     =  1866+ (i-1240)*0.1;
          hbit(i)     = 1826;  
        VaDot(i)    = 0;
    end
    
% %     for i = 540:570
% %         qpump(i)    = -50/6e4;
% %     end
    
qback(:)    = 0;
% qback(qpump>400/6e4)    = 200/6e4;
% qback(qpump<=400/6e4)   = 400/6e4;

%  figure;
% subplot(311),plot(0:simLength,qpump*6e4, 0:simLength,qback*6e4);
% grid on;
% 
% subplot(312),plot(0:simLength,hbit);
% grid on;
% 
% subplot(313),plot(0:simLength,VaDot);
% grid on;
% 

end


Data = readmatrix('calibration.xlsx','NumHeaderLines',1);
Data(:,2) = flip(Data(:,2));
t=Data(:,1);
V= Data(:,2);
figure;
plot(t,V);
xlabel('Time(s)');
ylabel('Voltage (V)');

as_disp=[0,2,4,6,8,10];
des_disp=[10,8,6,4,2,0];
as_voltage=[1.9730,1.9375,1.8947,1.8518,1.8140,1.7740];
des_voltage=[1.7740,1.8198,1.8535,1.8970,1.9298,1.9681];
L=100;

as_S=[];
for i=1:length(as_disp)
    as_S(i)=100*as_disp(i)/100;
end
des_S=[];
for r=1:length(des_disp)
    des_S(r)=100*des_disp(r)/100;
end
as_p=[];
for s=1:length(as_voltage)
    as_p(s)=(as_voltage(s)-0.5)/2.3206;
end
des_p=[];
for m=1:length(des_voltage)
    des_p(m)=(des_voltage(m)-0.5)/2.3206;
end

figure;
plot(as_S,as_p,'b',des_S,des_p,'r');
xlabel('Strain (%)'); 
ylabel('Pressure (MPa)');            
title('Soft sensor');
legend('Extension','Contraction','Location', 'best');

as_linear=polyfit(as_S,as_p,1);
as_slope=as_linear(1);
as_int=as_linear(2);
as_linearyax=[];
for d=1:length(as_S)
    as_linearyax(d)=as_slope*as_S(d)+as_int;
end

des_linear=polyfit(des_S,des_p,1);
des_slope=des_linear(1);
des_int=des_linear(2);
des_linearyax=[];
for z=1:length(des_S)
    des_linearyax(z)=des_slope*des_S(z)+des_int;
end

figure;
plot(as_S,as_linearyax,'k--',as_S,as_p,'b');
xlabel('Strain (%)'); 
ylabel('Pressure (MPa)');            
title('Soft sensor');
legend('Linear relationship (extension)','Extension','Location', 'best');

figure;
plot(des_S,des_linearyax,'k--',des_S,des_p,'r');
xlabel('Strain (%)'); 
ylabel('Pressure (MPa)');            
title('Soft sensor');
legend('Linear relationship (contraction)','Contraction','Location', 'best');

n1=length(as_p);
for i=1:n1
    as_sum=(as_p(i)-as_linearyax(i))^2;
end
n2=length(des_p);
for l=1:n2
    des_sum=(des_p(l)-des_linearyax(l))^2;
end
as_RMSE=sqrt((1/n1)*as_sum);
des_RMSE=sqrt((1/n2)*des_sum);

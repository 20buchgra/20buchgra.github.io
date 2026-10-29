close all
clear all

Vin = 7.4;
Vout = 12;
Iout = 10;
Rout = Vout/Iout;

f = 5e+06;
T = 1/f;
tov = 1e-09;

% EPC2367
R1 = 0.0015;
Q1 = 20e-09;
C1 = 1.75e-09;
R2=R1;
Q2=Q1;
C2=C1;

% KTA3030-620MEC
L = 62e-09;
DCR = 0.001;

D = 1-(Vin*Rout+Vout*(R1-R2)+sqrt((Vin*Rout+Vout*(R1-R2))^2-4*Vout^2*Rout*(R1+DCR)))/2/Vout/Rout;

IL = Iout/(1-D);
ILrms = sqrt(IL^2+D^2*(Vin-IL*DCR-IL*R1)^2/12/L^2/f^2);

Pr = ILrms^2*(D*R1+(1-D)*R2+DCR);
Psw = f*(5*(Q1+Q2)+0.5*Vin^2*(C1+C2)+0.5*tov*Vin*IL);
Loss = Pr+Psw;
eta = 1-Loss/Vin/IL;

% num = 1000;
% Ds = linspace(0.01,0.99,num);
% xs = zeros(1,num);
% ys = zeros(1,num);
% zs = zeros(1,num);
% es = zeros(1,num);

% for ii=1:num
%     D = Ds(ii);
%     ys(ii) = Vin/(1-D)*(1-D)^2*Rout/((1-D)^2*Rout+D*R1+(1-D)*R2+DCR);
%     IL = Iout/(1-D);
%     ILrms = sqrt(IL^2+D^2*(Vin-IL*DCR-IL*R1)^2/12/L^2/f^2);
%     Pr = ILrms^2*(D*R1+(1-D)*R2+DCR);
%     Psw = f*(5*(Q1+Q2)+0.5*Vin^2*(C1+C2)+0.5*tov*Vin*IL);
%     xs(ii) = Vin*IL;
%     zs(ii) = Pr+Psw;
%     es(ii) = 1-zs(ii)/xs(ii);
% end
% figure(1)
% yyaxis left
% plot(Ds,es);
% yyaxis right
% plot(Ds,ys);
% legend('Eff', 'Vout')

% Ideal frequency
f = (D^2*(Vin-IL*R1-IL*DCR)^2/6/L^2/(5*(Q1+Q2)+0.5*Vin^2*(C1+C2)+0.5*tov*Vin*IL))^(1/3);
Inductors = IndFilter(ILrms);
Inductors.idealf = (D^2*(Vin-IL*R1-IL.*Inductors.DCR).^2/6./Inductors.L.^2/ ...
    (5*(Q1+Q2)+0.5*Vin^2*(C1+C2)+0.5*tov*Vin*IL)).^(1/3);
Inductors.loss = (D*R1+(1-D)*R2+Inductors.DCR).* ...
    (IL^2+D^2.*(Vin-IL.*Inductors.DCR-IL*R1).^2./12./Inductors.L.^2./Inductors.idealf.^2) + ...
    Inductors.idealf.*(5*(Q1+Q2)+0.5*Vin^2*(C1+C2)+0.5*tov*Vin*IL);
Inductors.density = IL./Inductors.l./Inductors.w;
Inductors.FOM = Inductors.density./Inductors.loss;
Inductors = sortrows(Inductors, 11, 'descend')
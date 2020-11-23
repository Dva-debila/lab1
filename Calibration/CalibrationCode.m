Adc40 = importdata("calibration_1.txt");
Adc60 = importdata("calibration_2.txt");
Adc80 = importdata("calibration_3.txt");
Adc100 = importdata("calibration_4.txt");
Adc120 = importdata("calibration_5.txt");
Adc140 = importdata("calibration_6.txt");

Torr40 = ones(length(Adc40),1)*40;
Torr60 = ones(length(Adc60),1)*60;
Torr80 = ones(length(Adc80),1)*80;
Torr100 = ones(length(Adc100),1)*100;
Torr120 = ones(length(Adc120),1)*120;
Torr140 = ones(length(Adc140),1)*140;

Adc = [Adc40; Adc60; Adc80; Adc100; Adc120; Adc140];
Torr = [Torr40; Torr60; Torr80; Torr100; Torr120; Torr140];

c = polyfit(Adc, Torr, 1);
cFigure = figure('Name','Calibration','NumberTitle','off');
hold all;

plot(Adc40,Torr40,'.','MarkerSize', 20,'Color',[0,0,1]);
plot(Adc60,Torr60,'.','MarkerSize', 20,'Color',[0.2,0.2,0.8]);
plot(Adc80,Torr80,'.','MarkerSize', 20,'Color',[0.4,0.4,0.6]);
plot(Adc100,Torr100,'.','MarkerSize', 20,'Color',[0.6,0.6,0.4]);
plot(Adc120,Torr120,'.','MarkerSize', 20,'Color',[0.8,0.8,0.2]);
plot(Adc140,Torr140,'.','MarkerSize', 20,'Color',[1,1,0]);
plot(Adc,polyval(c,Adc));

legend('40 торр','60 торр','80 торр','100 торр','120 торр','140 торр','Аппроксимация','Location','NorthWest');
grid on;
xlabel('Отсчёты АЦП');
ylabel('торр');
title('Калибровка измерительной системы');
text(mean(Adc)*0.98,mean(Torr)*0.95,['P(adc) = ', num2str(c(1)),' * adc + ',num2str(c(2)),' [торр]']);

saveas(cFigure, 'CalibrationGraph.png');
%%Всякие данные входные с настройками. Лучше перед этим калибровку
%%запустить
Settings = importdata("Calibration\settings.txt");
DataBefore = importdata("data_before.txt");
DataAfter = importdata("data_after.txt");
Before = DataBefore*Settings(1)+Settings(2);
After = DataAfter*Settings(1)+Settings(2);

%%шкала времени
dT = 0.01;
Tbefore = (1:length(Before))*dT;
Tafter = (1:length(After))*dT;

%%визуализация данных
hold all;
plot(Tbefore,Before,'Color',[1,0,0]);
plot(Tafter,After,'Color',[0,0,1]);
legend('До физ. нагрузки','После физ. нагрузки');
grid on;
xlabel("Время, с");
ylabel("Давление, торр");
title("График изменения артериального давления");
saveas(gca,"Давление.png");


%%обработка данных
hold off;
cBefore = polyfit(Tbefore,Before,7);
cAfter = polyfit(Tafter,After,5);
pulseBefore = Before - polyval(cBefore,Tbefore)';
pulseAfter = After - polyval(cAfter,Tafter)';
%%авторасчёт ударов в минуту
flagB = false;
flagA = false;
countA = 0;
countB = 0;
for i = 1000:2000
    NFB = flagB;
    if pulseBefore(i) > 0.8
        NFB = true;
    end
    if pulseBefore(i) < -0.8
        NFB = false;
    end
    if ~(NFB == flagB)
        countB = countB + 1;
        flagB = NFB;
    end    
end
for i = 1000:2000
    NFA = flagA;
    if pulseAfter(i) > 0.8
        NFA = true;
    end
    if pulseAfter(i) < -0.8
        NFA = false;
    end
    if ~(NFA == flagA)
        countA = countA + 1;
        flagA = NFA;
    end    
end
%%графики
subplot(2,1,1);
plot(Tbefore,pulseBefore);
xlim([10,20]);
legend(num2str(countB*3)+" ударов в минуту");
title("Пульс до физической нагрузки");

subplot(2,1,2);
plot(Tafter,pulseAfter);
xlim([10,20]);
legend(num2str(countA*3)+" ударов в минуту");
title("Пульс после физической нагрузки");

saveas(gca,"пульс.png");
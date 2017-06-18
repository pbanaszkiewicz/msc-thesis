% plot responses from the real object

%% non-tuned
figure(1);

subplot(121);
plot(time1, ang1);
legend('Położenie belki', 'Location', 'northeast');
ylabel('Położenie kątowe [rad]');
xlabel('Czas [s]');
grid on;

subplot(122);
plot(time1, angvel1, time1, control1);
legend('Prędkość kątowa belki [rad/s]', 'Napięcie sterowania [V]', ...
       'Location', 'southwest');
ylabel('Wartość');
xlabel('Czas [s]');
grid on;

set(gcf, 'NextPlot', 'add');
axes;
h = title('Stabilizacja położenia belki (oryginalne nastawy)');
set(gca, 'Visible', 'off');
set(h, 'Visible', 'on');
set(gcf, 'pos', [457   544   841   420]);

%% tuned
figure(2);

subplot(121);
plot(time2, ang2);
legend('Położenie belki', 'Location', 'northeast');
ylabel('Położenie kątowe [rad]');
xlabel('Czas [s]');
grid on;

subplot(122);
plot(time2, angvel2, time2, control2);
legend('Prędkość kątowa belki [rad/s]', 'Napięcie sterowania [V]', ...
       'Location', 'southwest');
ylabel('Wartość');
xlabel('Czas [s]');
grid on;

set(gcf, 'NextPlot', 'add');
axes;
h = title('Stabilizacja położenia belki (samostrojenie)');
set(gca, 'Visible', 'off');
set(h, 'Visible', 'on');
set(gcf, 'pos', [457   544   841   420]);

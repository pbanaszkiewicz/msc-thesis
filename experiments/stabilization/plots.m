% plot responses from the real object

%% ball 1 stabilization
figure(1);

subplot(121);
plot(time1, pos1);
legend('Położenie kulki', 'Location', 'southeast');
ylabel('Położenie liniowe [m]');
xlabel('Czas [s]');
grid on;

subplot(122);
plot(time1, vel1, time1, ang1, time1, angvel1);
legend('Prędkość kulki [m/s]', 'Kąt belki [rad]', ...
       'Prędkość kątowa belki [rad/s]', 'Location', 'southeast');
ylabel('Wartość');
xlabel('Czas [s]');
grid on;

set(gcf, 'NextPlot', 'add');
axes;
h = title('Stabilizacja położenia pierwszej kulki');
set(gca, 'Visible', 'off');
set(h, 'Visible', 'on');
set(gcf, 'pos', [457   544   841   420]);

%% ball 2 stabilization
figure(2);

subplot(121);
plot(time2, pos2);
legend('Położenie kulki', 'Location', 'southeast');
ylabel('Położenie liniowe [m]');
xlabel('Czas [s]');
grid on;

subplot(122);
plot(time2, vel2, time2, ang2, time2, angvel2);
legend('Prędkość kulki [m/s]', 'Kąt belki [rad]', ...
       'Prędkość kątowa belki [rad/s]', 'Location', 'southeast');
ylabel('Wartość');
xlabel('Czas [s]');
grid on;

set(gcf, 'NextPlot', 'add');
axes;
h = title('Stabilizacja położenia drugiej kulki');
set(gca, 'Visible', 'off');
set(h, 'Visible', 'on');
set(gcf, 'pos', [457   544   841   420]);

%% ball 1 tuned stabilization
figure(3);

subplot(121);
plot(time1, pos1);
legend('Położenie kulki', 'Location', 'southeast');
ylabel('Położenie liniowe [m]');
xlabel('Czas [s]');
grid on;

subplot(122);
plot(time1, vel1, time1, ang1, time1, angvel1);
legend('Prędkość kulki [m/s]', 'Kąt belki [rad]', ...
       'Prędkość kątowa belki [rad/s]', 'Location', 'southeast');
ylabel('Wartość');
xlabel('Czas [s]');
grid on;

set(gcf, 'NextPlot', 'add');
axes;
h = title('Stabilizacja położenia pierwszej kulki');
set(gca, 'Visible', 'off');
set(h, 'Visible', 'on');
set(gcf, 'pos', [457   544   841   420]);

%% ball 2 tuned stabilization
figure(4);

subplot(121);
plot(time2, pos2);
legend('Położenie kulki', 'Location', 'southeast');
ylabel('Położenie liniowe [m]');
xlabel('Czas [s]');
grid on;

subplot(122);
plot(time2, vel2, time2, ang2, time2, angvel2);
legend('Prędkość kulki [m/s]', 'Kąt belki [rad]', ...
       'Prędkość kątowa belki [rad/s]', 'Location', 'southeast');
ylabel('Wartość');
xlabel('Czas [s]');
grid on;

set(gcf, 'NextPlot', 'add');
axes;
h = title('Stabilizacja położenia drugiej kulki');
set(gca, 'Visible', 'off');
set(h, 'Visible', 'on');
set(gcf, 'pos', [457   544   841   420]);

%% ball 1 untuned-tuned stabilization
figure(5);

dt = ball1_post_time(1)-ball1_pre_time(1)+0.145;
plot(ball1_pre_time, ball1_pre_pos, ball1_post_time-dt, ball1_post_pos);
legend('Przed samostrojeniem', 'Po samostrojeniu');
ylabel('Położenie liniowe [m]');
xlabel('Czas [s]');
title('Pozycja liniowa kulki nr 1');
grid on;
set(gcf, 'pos', [571   530   678   420]);

%% ball 2 untuned-tuned stabilization
figure(6);

dt = ball2_post_time(1)-ball2_pre_time(1);
plot(ball2_pre_time, ball2_pre_pos, ball2_post_time-dt, ball2_post_pos);
legend('Przed samostrojeniem', 'Po samostrojeniu');
ylabel('Położenie liniowe [m]');
xlabel('Czas [s]');
title('Pozycja liniowa kulki nr 2');
grid on;
set(gcf, 'pos', [571   530   678   420]);
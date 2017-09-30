% plot non-linear and linear model responses nicely in Matlab figures

%% non-linear model response (no control)
figure(1);

subplot(221);
plot(nonlinear_model_response.time, nonlinear_model_response.signals(1).values);
legend('Położenie kulki', 'Location', 'northwest');
ylabel('Położenie liniowe [m]');
xlabel('Czas [s]');
grid on;

subplot(223);
plot(nonlinear_model_response.time, nonlinear_model_response.signals(2).values);
legend('Prędkość kulki', 'Location', 'northwest');
ylabel('Prędkość liniowa [m/s]');
xlabel('Czas [s]');
grid on;

subplot(222);
plot(nonlinear_model_response.time, nonlinear_model_response.signals(3).values);
legend('Kąt belki', 'Location', 'southeast');
ylabel('Położenie kątowe [rad]');
xlabel('Czas [s]');
grid on;

subplot(224);
plot(nonlinear_model_response.time, nonlinear_model_response.signals(4).values);
legend('Prędkość kątowa belki', 'Location', 'northeast');
ylabel('Prędkość kątowa [m/s]');
xlabel('Czas [s]');
grid on;

set(gcf, 'NextPlot', 'add');
axes;
h = title('Odpowiedź modelu nieliniowego');
set(gca, 'Visible', 'off');
set(h, 'Visible', 'on');
set(gcf, 'pos', [680   311   771   639]);

%% linear model response (no control)
figure(2);

subplot(221);
plot(linear_model_response.time, linear_model_response.signals(1).values);
legend('Położenie kulki', 'Location', 'northwest');
ylabel('Położenie liniowe [m]');
xlabel('Czas [s]');
grid on;

subplot(223);
plot(linear_model_response.time, linear_model_response.signals(2).values);
legend('Prędkość kulki', 'Location', 'northwest');
ylabel('Prędkość liniowa [m/s]');
xlabel('Czas [s]');
grid on;

subplot(222);
plot(linear_model_response.time, linear_model_response.signals(3).values);
legend('Kąt belki', 'Location', 'northwest');
ylabel('Położenie kątowe [rad]');
xlabel('Czas [s]');
grid on;

subplot(224);
plot(linear_model_response.time, linear_model_response.signals(4).values);
legend('Prędkość kątowa belki', 'Location', 'southeast');
ylabel('Prędkość kątowa [m/s]');
xlabel('Czas [s]');
grid on;

set(gcf, 'NextPlot', 'add');
axes;
h = title('Odpowiedź modelu liniowego');
set(gca, 'Visible', 'off');
set(h, 'Visible', 'on');
set(gcf, 'pos', [680   311   771   639]);

%% both non-linear and linear model responses (no control)
figure(1);

subplot(221);
plot(nonlinear_model_response.time, nonlinear_model_response.signals(1).values,...
     linear_model_response.time, linear_model_response.signals(1).values);
legend('Model nieliniowy', 'Model zlinearyzowany', 'Location', 'northwest');
ylabel('Położenie liniowe [m]');
xlabel('Czas [s]');
title('Położenie kulki');
grid on;

subplot(223);
plot(nonlinear_model_response.time, nonlinear_model_response.signals(2).values,...
     linear_model_response.time, linear_model_response.signals(2).values);
legend('Model nieliniowy', 'Model zlinearyzowany', 'Location', 'northwest');
ylabel('Prędkość liniowa [m/s]');
xlabel('Czas [s]');
title('Prędkość kulki');
grid on;

subplot(222);
plot(nonlinear_model_response.time, nonlinear_model_response.signals(3).values,...
     linear_model_response.time, linear_model_response.signals(3).values);
legend('Model nieliniowy', 'Model zlinearyzowany', 'Location', 'southeast');
ylabel('Położenie kątowe [rad]');
xlabel('Czas [s]');
title('Kąt belki');
grid on;

subplot(224);
plot(nonlinear_model_response.time, nonlinear_model_response.signals(4).values,...
     linear_model_response.time, linear_model_response.signals(4).values);
legend('Model nieliniowy', 'Model zlinearyzowany', 'Location', 'northeast');
ylabel('Prędkość kątowa [m/s]');
xlabel('Czas [s]');
title('Prędkość kątowa belki');
grid on;

set(gcf, 'NextPlot', 'add');
axes;
h = title('Odpowiedź modeli nieliniowego i zlinearyzowanego');
set(gca, 'Visible', 'off');
set(h, 'Visible', 'on');
set(gcf, 'pos', [680   311   771   639]);

%% non-linear model response (stabilization)
figure(3);

subplot(131);
plot(nonlinear_control_data.time, nonlinear_control_data.signals(1).values(:,1));
% ax1 = gca;
% ax1.OuterPosition;
% ax1.TightInset;
% ax1.Position = [ax1.OuterPosition(1)+ax1.TightInset(1) ...
%                 ax1.OuterPosition(2)+ax1.TightInset(2) ...
%                 
legend('Położenie kulki');
ylabel('Położenie liniowe [m]');
xlabel('Czas [s]');
grid on;

subplot(132);
plot(nonlinear_control_data.time, nonlinear_control_data.signals(1).values(:,2:4));
% ax2 = gca;
% ax2.OuterPosition
% ax2.TightInset
legend('Prędkość kulki [m/s]', 'Kąt belki [rad]', ...
       'Prędkość kątowa belki [rad/s]');
ylabel('Wartość');
xlabel('Czas [s]');
grid on;

subplot(133);
plot(nonlinear_control_data.time, nonlinear_control_data.signals(2).values(:,1), ...
     nonlinear_control_data.time, nonlinear_control_data.signals(2).values(:,2), ...
     nonlinear_control_data.time, nonlinear_control_data.signals(3).values(:,1));
% ax3 = gca;
% ax3.OuterPosition
% ax3.TightInset
legend('Zadany kąt belki [rad]', 'Zadana prędkość belki [rad/s]', ...
       'Napięcie sterowania [V]');
ylabel('Wartość');
xlabel('Czas [s]');
grid on;

set(gcf, 'NextPlot', 'add');
axes;
h = title('Stabilizacja modelu nieliniowego');
set(gca, 'Visible', 'off');
set(h, 'Visible', 'on');
set(gcf, 'pos', [105         507        1135         359]);

%% linear model response (stabilization)
figure(4);

subplot(131);
plot(linear_control_data.time, linear_control_data.signals(1).values(:,1));                
legend('Położenie kulki');
ylabel('Położenie liniowe [m]');
xlabel('Czas [s]');
grid on;

subplot(132);
plot(linear_control_data.time, linear_control_data.signals(1).values(:,2:4));
legend('Prędkość kulki [m/s]', 'Kąt belki [rad]', ...
       'Prędkość kątowa belki [rad/s]');
ylabel('Wartość');
xlabel('Czas [s]');
grid on;

subplot(133);
plot(linear_control_data.time, linear_control_data.signals(2).values(:,1), ...
     linear_control_data.time, linear_control_data.signals(2).values(:,2), ...
     linear_control_data.time, linear_control_data.signals(3).values(:,1));
legend('Zadany kąt belki [rad]', 'Zadana prędkość belki [rad/s]', ...
       'Napięcie sterowania [V]');
ylabel('Wartość');
xlabel('Czas [s]');
grid on;

set(gcf, 'NextPlot', 'add');
axes;
h = title('Stabilizacja modelu liniowego');
set(gca, 'Visible', 'off');
set(h, 'Visible', 'on');
set(gcf, 'pos', [105         507        1135         359]);
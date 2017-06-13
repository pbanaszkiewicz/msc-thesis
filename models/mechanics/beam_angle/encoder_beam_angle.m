load 'encoder_beam_angle_characteristics'

% extract data from measurments
%encoder_angle = simout.signals.values(:,2);  % in radians
%beam_angle = simout.signals.values(:,1);     % in radians

% data is periodical, so sort along X axis to achieve bigger density of
% points
% data = [encoder_angle beam_angle];
% data = sortrows(data, 1);
% encoder_angle = data(:, 1);
% beam_angle = data(:, 2);

% close to optimum amplitude and angular frequency
min_angle = min(beam_angle);
max_angle = max(beam_angle);
amplitude = (max_angle - min_angle) / 2;
ang_freq = 0.995;
omega = -1.70;
offset = (abs(max_angle) - abs(min_angle)) / 2;
% offset = -0.0198 / 2;

fun = @(x) sseval(x, amplitude, offset, encoder_angle, beam_angle);
options = optimset('Display', 'iter', 'MaxFunEvals', 400, 'MaxIter', 400, 'TolFun', 1e-6, 'TolX', 1e-6);
bestx = fminsearch(fun, [ang_freq, omega], options);

X = encoder_angle;
omega = bestx(1);
phi = bestx(2);
approx_sin = characteristics(amplitude, offset, omega, phi+0.25, X);
% approx_sin = characteristics(amplitude, ang_freq, omega, X);

figure
plot(encoder_angle, beam_angle, X, approx_sin);

function Y = characteristics(A, offset, omega, phi, X)
    Y = A * sin(omega * X + phi) + offset;
end

function sse = sseval(x, amplitude, offset, xdata, ydata)
    A = amplitude;
    omega = x(1);
    phi = x(2);
    sse = sum((ydata - characteristics(A, offset, omega, phi, xdata)).^2);
end

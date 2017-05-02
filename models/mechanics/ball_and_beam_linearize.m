function ball_and_beam_linearize
%BALL_AND_BEAM_LINEARIZE - Sets the Ball and Beam model to open-loop and
%                          generates the linearized model.

% Based on `sm_cart_dpen_linearize.m` function by MathWorks
% (Copyright 2011-2014 The MathWorks, Inc.)

mdl = 'ball_and_beam';
swtch = [mdl, '/Control Switch'];
ctrlr = [mdl, '/Controller'];
plant = [mdl, '/Ball and Beam'];

% Operating point : 

% Save initial conditions
init.ball_position = get_param(plant, 'ball_position');
init.ball_velocity = get_param(plant, 'ball_velocity');
init.beam_angle = get_param(plant, 'beam_angle');
init.beam_angular_velocity = get_param(plant, 'beam_angular_velocity');

% Save visualization setting
vizSetting = get_param(gcs, 'SimMechanicsOpenEditorOnUpdate');

% Set up model to be reset after linearization at operating point
clnup = onCleanup(@() cleanUp(mdl, swtch, ctrlr, vizSetting, plant, init));

% Turn off viz for linearization
set_param(mdl, 'SimMechanicsOpenEditorOnUpdate', 'off');

% Set targets to linearization operating point
% Operating Point - beam at 0 angle, ball in the middle and not moving
set_param(plant, 'ball_position', '0.0');
set_param(plant, 'ball_velocity', '0.0');
set_param(plant, 'beam_angle', '0.0');
set_param(plant, 'beam_angular_velocity', '0.0');

% Make the system open loop
set_param(swtch, 'sw', '0');
set_param(ctrlr, 'sys', '[]');

% Get full state corresponding to operating point
[~, X, ~] = sim(mdl, 0); 
display(X);
% Linearizing about inverted upright position
[A,B,C,D] = linmod(mdl, X, 0);

% Removing the discrete states from the state space model
% A = A(1:6,1:6);
% B = B(1:6);
% C = C(:,1:6);
sys_ball_and_beam.A = A;
sys_ball_and_beam.B = B;
sys_ball_and_beam.C = C;
sys_ball_and_beam.D = D;
assignin('base', 'sys_ball_and_beam', sys_ball_and_beam);

end

function cleanUp(mdl, swtch, ctrlr, vizSetting, plant, init)

% Make the system closed loop
set_param(swtch, 'sw', '1');
set_param(ctrlr, 'sys', 'sys_ball_and_beam');

% Set viz setting to what it was
set_param(mdl, 'SimMechanicsOpenEditorOnUpdate', vizSetting);

set_param(mdl, 'Dirty', 'off');

% Setting initial conditions back
set_param(plant, 'ball_position', init.ball_position);
set_param(plant, 'ball_velocity', init.ball_velocity);
set_param(plant, 'beam_angle', init.beam_angle);
set_param(plant, 'beam_angular_velocity', init.beam_angular_velocity);

end


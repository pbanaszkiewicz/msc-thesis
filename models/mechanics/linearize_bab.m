%% Exact linearization of the Simulink model ball_and_beam_for_lin2
%
% This MATLAB script is the command line equivalent of the exact
% linearization tab in linear analysis tool with current settings.
% It produces the exact same linearization results as hitting the Linearize button.

% MATLAB(R) file generated by MATLAB(R) 9.1 and Simulink Control Design (TM) 4.4.
%
% Generated on: 12-May-2017 23:27:19

%% Specify the model name
model = 'ball_and_beam_for_lin2';

%% Specify the analysis I/Os
% Get the analysis I/Os from the model
io = getlinio(model);

%% Specify the operating point
% Create the operating point variable op_trim1 using model initial condition as a starting point
op = operpoint('ball_and_beam_for_lin2');
% Set the states in the model with different values than model initial condition
% State (3) - ball_and_beam_for_lin2/Ball and Beam/Ball/RJ
op.States(3).x = -6.93889390390723e-18;
% State (4) - ball_and_beam_for_lin2/Ball and Beam/Ball/RJ
op.States(4).x = 3.211933797594649e-25;
% State (5) - ball_and_beam_for_lin2/Ball and Beam/RJ1
op.States(5).x = -0.1563408860878554;
% State (6) - ball_and_beam_for_lin2/Ball and Beam/RJ1
op.States(6).x = 8.772255783023902e-19;
% State (7) - ball_and_beam_for_lin2/Ball and Beam/RJ2
op.States(7).x = -1.670851590426844;
% State (8) - ball_and_beam_for_lin2/Ball and Beam/RJ2
op.States(8).x = 1.318515821297253e-18;
% State (9) - ball_and_beam_for_lin2/Ball and Beam/RJ3
op.States(9).x = 1.640122208683201;
% State (10) - ball_and_beam_for_lin2/Ball and Beam/RJ3
op.States(10).x = 2.637005685502461e-20;
% State (11) - ball_and_beam_for_lin2/Ball and Beam/Shaft/BallBearing1
op.States(11).x = -1.551193003007891e-14;
% State (15) - ball_and_beam_for_lin2/Ball and Beam/Solver Configuration/EVAL_KEY/INPUT_1_1_1
op.States(15).x = [0.125611886087857;0.0105782333819884];
% Set the inputs in the model with different values than model initial condition
% Input (1) - ball_and_beam_for_lin2/In1
op.Inputs(1).u = -0.5629613928280666;


%% Linearize the model
linsys = linearize(model,io,op);

%% Plot the resulting linearization
%step(sys)

%% cleanup
clear op io model
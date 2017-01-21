% Load dataset 
load 'face_data.mat';
m = length(label);
data = [data ones(m, 1)]; % Add a constant term to dataset

% **************************************************************
% Run optimization solver to find the theta with minimal cost
%
% TO-DO: Use fminsearch in Matlab, or any other optimization 
% methods you like, to find theta that minimizes your
% cost function for logistic regression. Store the value you
% found in best_theta in order to plot the decision boundary.
% Choose [0, 0, 0] to be your initial value for optimizatoin.
% ***************************************************************


best_theta = fminsearch(@(theta)cost(data, label, theta), [0, 0, 0]); % Replace it!

% Plot decision boundry
hold on;
scatter(data(1:(m/2), 1), data(1:(m/2), 2));
scatter(data((m/2+1):m, 1), data((m/2+1):m, 2), 'x');
line_eq = @(x) -best_theta(3) - best_theta(2)*x/best_theta(1);
plot([-4, 4], [line_eq(-4), line_eq(4)]);

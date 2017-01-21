function J = cost(X, y, theta)
    % **************************************************************
    % Cost function for logistic regression
    %
    % TO-DO: Implement the cost function for logistic regression.
    % Input: 
    %   X: A 200x2 matrix containing all data points
    %   Y: A 200x1 matrix containing labels of data points
    %   theta: the current parameter theta
    % Output:
    %   J: The cost of logistic regression with the current theta
    % ***************************************************************
    h = 1./(1+exp(-theta*X'));
    J = (1/max(size(X))) * (-log(h)*y - log(1-h)*(1-y)); 
end

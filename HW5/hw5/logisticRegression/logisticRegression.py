import numpy as np
import scipy.io as sio
import scipy.optimize
import matplotlib.pyplot as plt

def cost(X, y, theta):    
    """
    Cost function for logistic regression
   
    TO-DO: Implement the cost function for logistic regression.
    Input: 
      X: A 200x2 matrix containing all data points
      Y: A 200x1 matrix containing labels of data points
      theta: the current parameter theta
    Output:
      J: The cost of logistic regression with the current theta
    """

    return 0 # Replace it!

def optimize_theta(X, y):
    """
    Run optimization solver to find the theta with minimal cost

    TO-DO: Use scipy.optimize.fmin, or any other optimization 
      methods you like, to find theta that minimizes your
      cost function for logistic regression.
      Choose [0, 0, 0] to be your initial value for optimizatoin.
    """

    return [3, 2, 1] # Replace it!

def plot_boundary(data, best_theta):
    m = len(data)
    plt.scatter(data[0:m/2, 0], data[0:m/2, 1])
    plt.scatter(data[m/2:, 0], data[0:m/2, 1], marker =  '+')
    line_eq = lambda x: -best_theta[2] - best_theta[1] * x / best_theta[0];
    plt.plot([-4, 4], [line_eq(-4), line_eq(4)])
    plt.show()

def main():
    #********************* Read data into matrices  ***********************************#
    mat_data = sio.loadmat('face_data.mat')
    data = np.matrix(mat_data['data'])
    data = np.insert(data, 2, values=1, axis=1) # Append a constant column to data matrix
    label = np.matrix(mat_data['label'])

    #********************* Find and plot dicision boundary ****************************#
    best_theta = optimize_theta(data, label) 
    plot_boundary(data, best_theta)

if __name__ == "__main__":
    main()

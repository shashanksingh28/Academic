# Thanks to http://iamtrask.github.io/2015/07/12/basic-python-network/
import numpy as np

class NeuralNet:
    # sigmoid function
    def sigmoid(self, x, deriv=False):
        if (deriv == True):
            return x * (1 - x)
        return 1 / (1 + np.exp(-x) )

    def __init__(self, layers):
        np.random.seed()
        self.layers = layers
        # list of weight arrays
        self.weights = []
        # populate weights with random values
        for i in range(len(layers) - 1):
            self.weights.append(2*np.random.random((layers[i], layers[i + 1]))-1)

    # get output as well as activations matrix
    def forwardFeed(self, inp):
        out = inp
        activations = [inp]
        for weight in self.weights:
            activation = self.sigmoid(np.dot(out,weight))
            activations.append(activation)
            out = activation
        return out, activations

    def train(self, input, exp_out, reg_lambda, epochs):
        # epochs is how many iterations should it train for
        e_layers_count = len(self.layers)
        errors = [None] * e_layers_count
        deltas = [None] * e_layers_count

        for i in range(epochs):
            out, acts = self.forwardFeed(input)

            # for the last layer, error
            errors[e_layers_count - 1] = exp_out - out

            # print prediction error periodically but not always
            if (i % 10) == 0:
                print "Error:",str(np.mean(np.abs(errors[e_layers_count - 1])))

            # back propogation step
            for j in range(e_layers_count - 1, 0, -1):
                deltas[j] = errors[j]*self.sigmoid(acts[j], deriv=True)
                errors[j-1] = deltas[j].dot(self.weights[j-1].T)

            # update weights step
            for i in range(len(self.weights)):
                self.weights[i] += reg_lambda*acts[i].T.dot(deltas[i+1])


def test():
    net = NeuralNet([3,4,1])
    # make sure output is also a 2D array
    inp = np.array(([1,2,3],[4,5,6],[7,8,9]))
    out = np.array([[0.5],[0.7],[0.9]])
    net.train(inp,out,0.5,1000)

if __name__=="__main__":
    test()

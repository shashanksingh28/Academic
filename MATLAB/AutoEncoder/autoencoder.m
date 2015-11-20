clear;
% -------------- Config start ------------------- %
HiddenNodes = 256;
HiddenLayers = 1;
% -------------- Config end --------------------- %


% -------------- Initialize start --------------- %
x = flatImage('../TrainImages/Adrien_Brody_0003.pgm');
x = [1; x];
x = im2double(x);

% now our input vector column to network is ready %
[iRows, ~ ] = size(x);

% Creating a cell array of weight matrices
% Each cell contains the weight matrix of going from layer x to x+1
weights = cell(HiddenLayers + 1,1);

% first weight matrix will have dimensions: no.of.nodes x no.of.pixels
weights{1} = rand(HiddenNodes,iRows);

% last weight matrix will have dimensions: no.of.pixels x no.of.nodes
% note that output still has the first element as bias
weights{HiddenLayers+1} = rand(iRows,HiddenNodes);

% all other weight matrices in between will be square matrices of
% no.of.nodes x no.of.nodes
if HiddenLayers > 1
    for j=2:HiddenLayers
        weights(j) = rand(HiddenNodes,HiddenNodes);
    end
end
% -------------- Initialize end --------------- %

% output - the output image data
% activations - the activations that occured at each layer of the network
[output, activations] = feedForward(x,weights,HiddenNodes);

avgActivation = mean(activations,2);

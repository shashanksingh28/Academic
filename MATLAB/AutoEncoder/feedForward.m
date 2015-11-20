function [output, activations] = feedForward(inputX, weights, noOfHiddenNodes)
    
    % forward propogate each layer per iteration
    [iterations,~] = size(weights);
    
    % activations will contain what came out of each layer, last layer being
    % output of the network
    activations = zeros(noOfHiddenNodes, iterations - 1);
    
    % initial activation vector the same as the input with bias
    a = inputX;

    for i = 1 : iterations
        z = weights{i} * a;
        a = 1 ./(1 + exp(-1 * z));
        if i < iterations
           activations(:,i) = a; 
        end
    end
    
    output = a;
    
end
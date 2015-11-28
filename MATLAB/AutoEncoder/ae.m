classdef ae
    %   AutoEncoder based on http://ufldl.stanford.edu/tutorial/supervised/MultiLayerNeuralNetworks
    properties
        % two dimensional weight arrays of each layer. Wij = Connection
        % weight of unit j in layer L to unit i in L+1
        Weights
        % bias of each layer
        Bias
        
        % internal properties
        % first column represents the image pixels and last column the
        % output image
        Activations
    end
    
    methods
       function obj=ae(hiddenLayerCount, hiddenNodeCount, inputDim)
            
            % TODO : basic validations
 
            obj.Weights = cell(hiddenLayerCount + 1,1);
            obj.Activations = cell(hiddenLayerCount + 2);
            
            obj.Bias = 1;
            for i = 1 : hiddenLayerCount
                obj.Bias = [1 obj.Bias];
            end
            
            obj.Weights{1} = rand(hiddenNodeCount,inputDim);
            obj.Activations{1} = rand(inputDim,1);
            
            if hiddenLayerCount > 1
                for j = 2 : HiddenLayers
                    obj.Weights{j} = rand(hiddenNodeCount,hiddenNodeCount);
                    obj.Activations{j+1} = rand(hiddenNodeCount,1);
                end
            end
            
            obj.Weights{hiddenLayerCount + 1} = rand(inputDim,hiddenNodeCount);
            obj.Activations{hiddenLayerCount + 2} = rand(inputDim,1);
       end
       
       % get a forward feed for a certain image
       function this = forwardFeed(this, input)
           
           [iterations,~] = size(this.Weights);
           
           this.Activations{1} = input;
           
           for i = 1 : iterations
                z = this.Weights{i} * this.Activations{i} + this.Bias(1,i);
                this.Activations{i+1} = 1 ./(1 + exp(-1 * z));
           end
       end
       
    end
    
end


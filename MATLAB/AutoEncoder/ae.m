classdef ae
    %   AutoEncoder based on http://ufldl.stanford.edu/tutorial/supervised/MultiLayerNeuralNetworks
    properties
        % two dimensional weight arrays of each layer. Wij = Connection weight of unit j in layer L to unit i in L+1
        Weights
        % bias of each layer
        Bias
        % first column represents the input image pixels and last column the output image
        HiddenLayers
        HiddenNodes
        
    end
    
    methods
       % constructor
       function obj=ae(hiddenLayerCount, hiddenNodeCount, inputDim)
            
            % TODO : basic validations
 
            obj.Weights = cell(1,hiddenLayerCount + 1);            
            obj.Bias = cell(1,hiddenLayerCount + 1);
            
            % Initial Initialization
            obj.Weights{1,1} = randn(hiddenNodeCount,inputDim);
            obj.Bias{1,1} = randn(hiddenNodeCount,1);
            
            if hiddenLayerCount > 1
                for j = 2 : hiddenLayerCount
                    obj.Weights{1,j} = randn(hiddenNodeCount,hiddenNodeCount);
                    obj.Bias{1,j} = randn(hiddenNodeCount,1);
                end
            end
            
            obj.Weights{1,hiddenLayerCount + 1} = randn(inputDim,hiddenNodeCount);
            obj.Bias{1,hiddenLayerCount + 1} = randn(inputDim,1);
            %
            
            obj.HiddenLayers = hiddenLayerCount;
            obj.HiddenNodes = hiddenNodeCount;
            
       end
       
       % get a forward feed for all images
       function activations = forwardFeed(this, inputImages)
           
           [~,iterations] = size(this.Weights);
           
           [~, imageCount] = size(inputImages);
           
           activations = cell(imageCount, iterations + 1);                      
           
           for i = 1 : imageCount
               % each column is the first activation
               activations {i,1} = inputImages(:,i);
               for j = 1 : iterations
                    z = ((this.Weights{1,j}) * (activations{i,j})) + this.Bias{1,j};
                    activations{i,j+1} = 1./(1 + exp(-z));
               end
           end
           
       end
       
       % Perform BackPropogation on one of the images (activations is of
       % just one image)
       function [dwJ, dbJ] = backPropogate(this, activations, avgActivations, beta, row)
           
            [~, layers] = size(activations);
            
            % f'(act)
            der = cell(1, layers);
            for i = 1:layers
                der{1,i} = activations{1,i}.*(1 - activations{1,i});
            end
            
            % divergence for keeping low average activations
            divergence = beta*(-row./avgActivations + (1 - row)./(1-avgActivations));

            % \dow
            delta = cell(1, layers);
            delta{1,layers} = -(activations{1,1} - activations{1,layers}).*der{1,layers};            
            
            for j = layers - 1: -1 : 2                 
                delta{1,j} = (((this.Weights{1,j})'*delta{1,j + 1}) + divergence(:,j-1)).*der{1,j};
            end

            % dowWeightJ
            dwJ = cell(1, layers - 1);
            dbJ = cell(1, layers - 1);

            for i = 1: layers - 1
               dwJ{1,i} = delta{1,i+1}*((activations{1,i})');
               dbJ{1,i} = delta{1,i+1};
            end
            
       end
       
       % train from an array of images
       function activations = backGradientDescent(this, inputImages, alpha, lambda, beta, row)
          
          
          [~, imageCount] = size(inputImages);
          
          
          
          deltaW = this.Weights;
          deltaB = this.Bias;
          
          for it = 1 : 50              
              % First calculate forward feed of all images
              activations = this.forwardFeed(inputImages);
              
              avgActivations = zeros(this.HiddenNodes, this.HiddenLayers);
          
              for i = 1 : imageCount
                  for j = 1 : this.HiddenLayers
                      avgActivations(:,j) = avgActivations(:,j) + activations{i,j+1};
                  end
              end
          
              avgActivations = 1 / imageCount .* avgActivations;
              
              % print error
              
              
              % initialize deltas to 0
              for i = 1: this.HiddenLayers + 1
                  deltaW{1,i} = zeros(size(this.Weights{1,i}));
                  deltaB{1,i} = zeros(size(this.Bias{1,i}));
              end  
              
              % for each image
              for i = 1:imageCount
                  [dwJ, dbJ] = this.backPropogate(activations(i,:), avgActivations, beta, row);
                  evaluate(activations{i,1},activations{i,3});
                  for j = 1 : this.HiddenLayers + 1
                      deltaW{1,j} = deltaW{1,j} + dwJ{1,j};
                      deltaB{1,j} = deltaB{1,j} + dbJ{1,j};
                  end
              end

              % update the weight matrices an bias matrices
              for j = 1 : this.HiddenLayers + 1
                  this.Weights{1,j} = this.Weights{1,j} - alpha.*(1/imageCount.*deltaW{1,j} + lambda.*this.Weights{1,j});
                  this.Bias{1,j} = this.Bias{1,j} - alpha / imageCount .* deltaB{1,j};
              end
          end
       end
       
    end
    
end


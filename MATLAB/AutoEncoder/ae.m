classdef ae
    %   AutoEncoder based on http://ufldl.stanford.edu/tutorial/supervised/MultiLayerNeuralNetworks
    properties
        % two dimensional weight arrays of each layer. Wij = Connection weight of unit j in layer L to unit i in L+1
        Weights
        % bias of each layer
        Bias
        % first column represents the input image pixels and last column the output image
        Activations
        
    end
    
    methods
       % constructor
       function obj=ae(hiddenLayerCount, hiddenNodeCount, inputDim)
            
            % TODO : basic validations
 
            obj.Weights = cell(1,hiddenLayerCount + 1);
            obj.Activations = cell(1,hiddenLayerCount + 2);            
            obj.Bias = cell(1,hiddenLayerCount + 1);
            
            % Initial Initialization
            obj.Weights{1,1} = randn(hiddenNodeCount,inputDim);
            obj.Activations{1,1} = zeros(inputDim,1);
            obj.Activations{1,2} = zeros(hiddenNodeCount,1);
            obj.Bias{1,1} = randn(hiddenNodeCount,1);
            
            if hiddenLayerCount > 1
                for j = 2 : hiddenLayerCount
                    obj.Weights{1,j} = randn(hiddenNodeCount,hiddenNodeCount);
                    obj.Activations{1,j+1} = zeros(hiddenNodeCount,1);
                    obj.Bias{1,j} = randn(hiddenNodeCount,1);
                end
            end
            
            obj.Weights{1,hiddenLayerCount + 1} = randn(inputDim,hiddenNodeCount);
            obj.Activations{1,hiddenLayerCount + 2} = zeros(inputDim,1);
            obj.Bias{1,hiddenLayerCount + 1} = randn(inputDim,1);
            %
       end
       
       % get a forward feed for a certain image
       function this = forwardFeed(this, input)
           
           [~,iterations] = size(this.Weights);
           
           this.Activations{1,1} = input;
           
           for i = 1 : iterations
                z = ((this.Weights{1,i}) * (this.Activations{1,i})) + this.Bias{1,i};
                this.Activations{1,i+1} = 1./(1 + exp(-z));
           end
           
%            imshow(reshape(this.Activations{1,3},[32,32]));
%            waitforbuttonpress;
       end
       
       % Perform BackPropogation on one of the images (input is [pixels x 1])
       function [encoder, dwJ, dbJ] = backPropogate(encoder, input)
           
            encoder = forwardFeed(encoder, input);
           
            [~, layers] = size(encoder.Activations);
            der = cell(1, layers);
            for i = 1:layers
                der{1,i} = encoder.Activations{1,i}.*(1 - encoder.Activations{1,i});
            end

            delta = cell(1, layers);
            delta{1,layers} = -(encoder.Activations{1,1} - encoder.Activations{1,layers}).*der{1,layers};

            for j = layers - 1: -1 : 2
               delta{1,j} = ((encoder.Weights{1,j})'*delta{1,j + 1}).*der{1,j};
            end

            % dowWeightJ
            dwJ = cell(1, layers - 1);
            dbJ = cell(1, layers - 1);

            for i = 1: layers - 1
               dwJ{1,i} = delta{1,i+1}*((encoder.Activations{1,i})');
               dbJ{1,i} = delta{1,i+1};
            end
            
       end
       
       % train from an array of images
       function this = backGradientDescent(this, inputImages, alpha)
          % use deltaW and deltaB and the applying grad descent on each
 
          deltaW = this.Weights;
          deltaB = this.Bias;
          [~, layers] = size(this.Activations);
          [~, imageCount] = size(inputImages);
          
          for it = 1 : 25
              % initialize deltas to 0
              for i = 1: layers - 1
                  deltaW{1,i} = zeros(size(this.Weights{1,i}));
                  deltaB{1,i} = zeros(size(this.Bias{1,i}));
              end  
              
              % for each image
              for i = 1:imageCount
                  [this, dwJ, dbJ] = backPropogate(this,inputImages(:,i));
                  evaluate(this.Activations{1,3}, this.Activations{1,1});
                  for j = 1 : layers - 1
                      deltaW{1,j} = deltaW{1,j} + dwJ{1,j};
                      deltaB{1,j} = deltaB{1,j} + dbJ{1,j};
                  end
              end

              % update the weight matrices an bias matrices
              for j = 1 : layers - 1
                  this.Weights{1,j} = this.Weights{1,j} - alpha / imageCount .* deltaW{1,j};
                  this.Bias{1,j} = this.Bias{1,j} - alpha / imageCount .* deltaB{1,j};
              end
          end
       end
       
    end
    
end


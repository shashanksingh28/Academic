clear;

% Modify parameters here %
hiddenLayers = 1;
hiddenNodes = 350;
imageSingleDim = 32;
trainFolderPath = 'TrainImages';    % folder with images to train the encoder
valFolderPath = 'ValImages';    % folder with images you actually want to try encoding
alpha = 1.6;
lambda = 0.6;
beta = 2;
row = 0.06;
outFolder = 'test_rec';
iterations = 50;
% end of configuration. Be careful to change anything below this %

range = 150 : 10 : 350;
trainImages = getFlatImages(trainFolderPath);
totalErrors = zeros(1, numel(range));
for ctr = 1 : numel(range)
    clearvars aencoder;
    aencoder = ae(hiddenLayers,range(ctr),imageSingleDim*imageSingleDim);
    [aencoder, activations, errors] = aencoder.backGradientDescent(trainImages,alpha, lambda, beta, row, iterations);
    totalErrors(ctr) = sum(sum(errors));
end

plot(range, totalErrors);
xlabel('No of hidden nodes');
ylabel('Sum of errors for all iterations');
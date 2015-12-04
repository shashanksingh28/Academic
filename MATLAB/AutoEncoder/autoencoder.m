clear;

% Modify parameters here %
hiddenLayers = 1;
hiddenNodes = 256;
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

trainImages = getFlatImages(trainFolderPath);
aencoder = ae(hiddenLayers,hiddenNodes,imageSingleDim*imageSingleDim);
[aencoder, activations, errors] = aencoder.backGradientDescent(trainImages,alpha, lambda, beta, row, iterations);

[valImages, fileNames] = getFlatImages(valFolderPath);
[~, imgCount] = size(valImages);

if ~exist(outFolder, 'dir')
    % Folder does not exist so create it.
    mkdir(outFolder);
end

for i = 1 : numel(fileNames)
    fileNames(i).name = strcat(outFolder,'//',fileNames(i).name);
end

[~, layers] = size(activations);
for i = 1 : imgCount
    outActivations = aencoder.forwardFeed(valImages(:,i));
    imwrite(reshape(outActivations{1,layers},[imageSingleDim,imageSingleDim]),fileNames(i).name);
end

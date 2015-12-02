clear;
aencoder = ae(1,256,32*32);
trainImages = getFlatImages('TrainImages');
[activations, errors] = aencoder.backGradientDescent(trainImages, 5, 0.6, 1, 0.05, 50);

[valImages, fileNames] = getFlatImages('ValImages');
[~, imgCount] = size(valImages);

outFolder = ('test_rec');

if ~exist(outFolder, 'dir')
    % Folder does not exist so create it.
    mkdir(outFolder);
end

for i = 1 : numel(fileNames)
    fileNames(i).name = strcat(outFolder,'//',fileNames(i).name);
end

for i = 1 : imgCount
    outActivations = aencoder.forwardFeed(valImages(:,i));
    figure, imshow(reshape(outActivations{1,1},[32,32]));
    figure, imshow(reshape(outActivations{1,3},[32,32]));
    waitforbuttonpress;
    imwrite(reshape(outActivations{1,3},[32,32]),fileNames(i).name);
end
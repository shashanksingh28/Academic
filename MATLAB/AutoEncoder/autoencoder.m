clear;
aencoder = ae(1,265,32*32);
images = getFlatImages('TrainImages');
[activations, errors] = aencoder.backGradientDescent(images, 1, 0.6, 1, 0.05,50);
%aencoder = aencoder.backGradientDescent(images,1,0.6);
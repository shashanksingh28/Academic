clear;
aencoder = ae(1,265,32*32);
images = getFlatImages('TrainImages');
activations = aencoder.backGradientDescent(images, 1, 0.6, 1, 0.05);
%aencoder = aencoder.backGradientDescent(images,1,0.6);
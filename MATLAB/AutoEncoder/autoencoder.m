clear;
aencoder = ae(1,256,32*32);
images = getFlatImages('TrainImages');
aencoder = aencoder.backGradientDescent(images,50);
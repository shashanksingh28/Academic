clear;
aencoder = ae(1,512,32*32);
images = getFlatImages('TrainImages');
aencoder = aencoder.backGradientDescent(images,1,0.6);
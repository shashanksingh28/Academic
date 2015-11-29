clear;
aencoder = ae(1,256,32*32);

% -------------- Initialize start --------------- %
x = flatImage('TrainImages\\Adrien_Brody_0003.pgm');
x = im2double(x);
aencoder = aencoder.backGradientDescent(x);
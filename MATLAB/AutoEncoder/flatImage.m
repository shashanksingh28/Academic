function X = flatImage(imgFilepath)

X = imread(imgFilepath);

[rows, cols] = size(X);

X = reshape(X, rows * cols, 1);

end
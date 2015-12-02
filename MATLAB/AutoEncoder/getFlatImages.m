function [images, filenames] = getFlatImages(folderPath)
    prePath = cd(folderPath);
    filenames = dir('*.pgm');
    images = zeros(32 * 32, numel(filenames));
    for i = 1:numel(filenames)
        X = imread(filenames(i).name);
        images(:,i) = reshape(im2double(X), 32 * 32, 1);
    end
    cd(prePath);
end
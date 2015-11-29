function images = getFlatImages(folderPath)
    prePath = cd(folderPath);
    contents = dir('*.pgm');
    images = zeros(32 * 32, numel(contents));
    for i = 1:numel(contents)
        X = imread(contents(i).name);
        images(:,i) = reshape(X, 32 * 32, 1);
    end
    cd(prePath);
end
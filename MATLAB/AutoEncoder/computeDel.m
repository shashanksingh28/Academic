function del = computeDel( activationSet )
    %  Calculates error Deltas for a certain Activation sets
    [~, layers] = size(activationSet);
    del = cell(1, layers);
    for i = 1:layers
        del{i} = activationSet{i}.*(activationSet{i} - 1);
    end
end


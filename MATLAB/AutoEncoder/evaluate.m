%  This file will evaluate the backpropagation algorithm %
function [error] = evaluate(output,input)
  [rows cols] = size(output);
  diffe = (output - input).^2;
  error = sqrt((1/(rows*cols))*sum(sum(diffe)));
  error
  end
  


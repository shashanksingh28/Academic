for i = 1 : 1000
   figure, imshow(reshape(activations{i,1},[32,32]));
   figure, imshow(reshape(activations{i,3},[32,32]));
   waitforbuttonpress
end
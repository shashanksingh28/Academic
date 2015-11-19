function imgMatrix = rollAndSaveImg(col, new_rows, new_cols, imgFileName)
    
    imgMatrix = reshape(col, new_rows, new_cols);
    imwrite(imgMatrix, imgFileName);
    
end
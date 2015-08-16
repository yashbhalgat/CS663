%% Adaptive Histogram Equalization
    %Input Parameters: Input Image
    %                  Window Size, N
    %Output Parameters: Output Image
%%

function [] = myAHE()

inputImage=imread('../data/barbara.png');
[row, col, d] = size(inputImage);

outputImage = zeros(row, col, d);
window_x = 32;
window_y = 32;

hand = @(x) calcAHEVal(x)
outputImage = nlfilter(inputImage,[61 61],hand);

% for i=1:row
%     for j=1:col
%         for k=1:d
%             % // min_x = max(1,i-window_x);
%             % // min_y = max(1,j-window_y);
%             % // max_x = min(row,i+window_x);
%             % // max_y = min(col,j+window_y);
%             % // window_matrix = inputImage(min_x:max_x,min_y:max_y,k);

%             if inputImage(i,j,k) == 0 
%                 outputImage(i,j,k) =0;
%             else
%             [histogramEquMatrix, transformationFunction ] = myHE(window_matrix);
%             % disp(transformationFunction);
%             outputImage(i,j,k) = transformationFunction(inputImage(i,j,k));
%             end
%         end
%     end
imshow(outputImage);
end

function AHEVal = calcAHEVal(inpMat)
    H=imhist(inpMat);
    [N, M] = size(inpMat);
    H=H/(N*M);
    C = double(zeros(1,255));
    C(1) = H(1)*255;

    for (k=2:256)
        C(k)= C(k-1) + (H(k)*255);
    end
    AHEVal = uint8(C(inpMat(floor((1+N)/2)+1,floor((1+M)/2))+1));
end


    
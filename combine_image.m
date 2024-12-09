img1 = imread('Time vs sample_2D_new.png'); % Replace with the actual filename for Simple SAW
img2 = imread('Time vs sample_3D_new.png'); % Replace with the actual filename for Dimerization
img3 = imread('Time vs sample_4D_new.png'); % Replace with the actual filename for Pivot

trim_fixed = @(img, top, left, right) imcrop(img, [left+1, top+1, size(img, 2) - left - right - 1, size(img, 1) - top - 1]);

% Trim 20 pixels from the left and 50 pixels from the right
img1 = trim_fixed(img1, 15, 30, 55);
img2 = trim_fixed(img2, 15, 30, 55);
img3 = trim_fixed(img3, 15, 30, 55);

width_top = size(img1, 2) + size(img2, 2); % Combined width of the top row
height_top = max(size(img1, 1), size(img2, 1)); % Maximum height of the top row
width_bottom = size(img3, 2); % Width of the bottom row
height_bottom = size(img3, 1); % Height of the bottom row
total_width = max(width_top, width_bottom); % Total width for the final image
total_height = height_top + height_bottom; % Total height for the final image

% Create a blank canvas for the combined image
combined_img = uint8(255 * ones(total_height, total_width, 3)); % White background

% Place the first two images side by side at the top
combined_img(1:height_top, 1:size(img1, 2), :) = img1;
combined_img(1:height_top, size(img1, 2)+1:width_top, :) = img2;

% Place the third image in the middle of the bottom row
start_x = floor((total_width - width_bottom) / 2); % Center the bottom image horizontally
combined_img(height_top+1:end, start_x+1:start_x+width_bottom, :) = img3;

% Save the combined image
imwrite(combined_img, 'Time_vs_sample_Layout.png');
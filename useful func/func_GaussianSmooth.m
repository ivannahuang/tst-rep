function y = func_GaussianSmooth(x, kernel_width)

% Gaussian smooth data with certain kernel width
% smoothes the data in each column of x

% 68 95 99.7
smoothwidth = 6*kernel_width;
y = smoothdata(x,'gaussian',smoothwidth);

end
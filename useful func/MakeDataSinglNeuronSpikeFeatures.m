function  [y_spike, y_smspike] ...
    =  MakeDataSinglNeuronSpikeFeatures(spike,t1,t2,kernelwidth)
% smoothes the data in each column of x
% spike sequence from t1 to t2, and gaussian smooth
y_spike = spike(t1:t2,1);


% smoothversion
y_smspike = func_GaussianSmooth(y_spike,kernelwidth);
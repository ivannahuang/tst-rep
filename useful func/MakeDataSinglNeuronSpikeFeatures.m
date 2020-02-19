function  [y_spike, y_smspike] ...
    =  MakeDataSinglNeuronSpikeFeatures(spike,t1,t2,smoothwidth)

% spike sequence from t1 to t2, and gaussian smooth
y_spike = spike(t1:t2,1);


% smoothversion
y_smspike = smoothdata(y_spike,'gaussian',smoothwidth);
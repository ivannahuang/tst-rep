function [y_t,y_evts] = func_Time2Sequence(x_t,x_a,t1,t2)


% modify the function when x_a is absent
% input: spike timing, spike amplitude, the range
% output: spike sequence (binary), spike sequence (amplitude);

y_evts = zeros(numel(t1:t2),1);
y_t = zeros(numel(t1:t2),1);

t = x_t(x_t>=t1 & x_t<=t2)-t1+1;
a = x_a(x_t>=t1 & x_t<=t2);
y_t(t) = 1;
y_evts(t)=abs(a);


end

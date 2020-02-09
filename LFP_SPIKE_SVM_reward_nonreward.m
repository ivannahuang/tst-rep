clc;clear;
%% load data
addpath(genpath(pwd));
load('rat009_0625_mpfc_spike.mat')
load('D:\OneDrive - HKUST Connect\DATA\rat090625\mPFC\FilteredFP_mPFC_0625_rat09.mat', 'bdLFP19')
% load rat_009_0625;
SpikeSet={WB17a,WB18a,WB19a,WB20a,WB21a,WB22a,WB23a,WB24a,WB25a,WB26a,WB27a,WB28a,WB28b,WB29a,WB30a,WB30b,WB31a,WB32a};

% WB_file2={WB17a,WB18a,WB19a,W,WB20a,WB21a,WB22a,WB23a,WB24a,WB25a,WB26a,WB27a,WB28a,WB28b,WB29a,WB30a,WB30b,WB31a,WB32a};

% WB_file={WB01a,WB01b,WB02a,WB02b,WB03a,WB03b,WB04a,WB04b,WB05a,WB05b,WB06a,WB07a,WB07b,WB08a,WB08b,WB09a,WB09b,WB10a,WB10b,WB11a,WB11b,WB12a,WB12b,WB13a,WB13b,WB13c,WB14a,WB14b,WB15a,WB16a};

%% preprocessing
[Hs,ls,hf,lf,hs_cue,ls_cue]=find_index_009(EVT01,EVT02,EVT03,EVT04,EVT05,EVT06,EVT07,EVT08);
%  Hs  high success start, high success press
% ls 
% hf  cue high press low
%%
tap=3;
num_history=7;
size_bin = 0.05;
input_high_reward=generate_reward_input(tap,size_bin,Hs(:,2),SpikeSet,num_history);
input_low_reward=generate_reward_input(tap,size_bin,ls(:,2),SpikeSet,num_history);
input_high_nonreward=generate_reward_input(tap,size_bin,hf(:,2),SpikeSet,num_history);
input_low_nonreward=generate_reward_input(tap,size_bin,lf(:,2),SpikeSet,num_history);


%%
in_h_reward_lfp = generate_reward_input_LFP(tap,floor(size_bin*1000),floor(Hs(:,2).*1000),LFPset,num_history);
%%

%%
% classify reward vs nonreward
reward=[input_high_reward input_low_reward];
nonreward=[input_high_nonreward input_low_nonreward];
m=min(size(reward,2),size(nonreward,2));
h=max(size(reward,2),size(nonreward,2));



%% classify reward vs nonreward under high cue
ACC2=zeros(4,1)
for k=1:4
    n=min(size(input_high_reward,2),size(input_high_nonreward,2));
    temp=[input_high_reward(:,1:n) input_high_nonreward(:,1:n)]';
    % cut=floor(0.7*size(temp,1)/10)*10;
    % ind = randperm(size(temp, 1));
    labels=[ones(n,1);-1*ones(n,1)];
    % train_in = temp(ind(1:cut),:);
    % train_out = labels(ind(1:cut),:);
    % test_in = temp(ind(cut+1:end),:);
    % test_out = labels(ind(cut+1:end),:);
    [bestacc3,bestc3,bestg3] = SVMcg(labels,temp,-8,3,-8,3,4,1,1,0.9);
    ACC2(k,1)=bestacc3;
    % cmd3 = ['-c ',num2str(bestc3),' -g ',num2str(bestg3)];
    % svmmodel3=svmtrain(train_out,train_in,cmd3);
    % [model5,acc5,dec5]=svmpredict(test_out,test_in,svmmodel3);
    % [model6,acc6,dec6]=svmpredict(train_out,train_in,svmmodel3);
end
% figure;
% [x,y]=confusionmat(test_out,model5);
% temp=x./sum(x')';
% xvalues = {'reward','nonreward'};
% yvalues = {'reward','nonreward'};
% h=heatmap(xvalues,yvalues,temp);
%
% xlabektick()
%
% temp=[input_high_reward input_high_nonreward]';
% [coeff,score]=pca(temp);
% figure;
% plot(score(1:size(input_high_reward,2),1),score(1:size(input_high_reward,2),2),'o');
% hold on;
% plot(score(size(input_high_reward,2)+1:end,1),score(size(input_high_reward,2)+1:end,2),'xg');
%

%% classify reward vs nonreward under low cue
ACC3=zeros(4,1)
for k=1:4
    l=min(size(input_low_reward,2),size(input_low_nonreward,2));
    temp=[input_low_reward(:,1:l) input_low_nonreward(:,1:l)]';
    % cut=floor(0.7*size(temp,1)/10)*10;
    % ind = randperm(size(temp, 1));
    %labels=[ones(size(input_low_reward,2),1);-1*ones(size(input_low_nonreward,2),1)];
    labels=[ones(l,1);-1*ones(l,1)];
    % train_in = temp(ind(1:cut),:);
    % train_out = labels(ind(1:cut),:);
    % test_in2 = temp(ind(cut+1:end),:);
    % test_out2 = labels(ind(cut+1:end),:);
    [bestacc4,bestc4,bestg4] = SVMcg(labels,temp,-8,3,-8,3,4,1,1,0.9);
    ACC3(k,1)=bestacc4;
    % cmd4 = ['-c ',num2str(bestc4),' -g ',num2str(bestg4)];
    % svmmodel4=svmtrain(train_out,train_in,cmd4);
    % [model7,acc7,dec7]=svmpredict(test_out2,test_in2,svmmodel4);
    % [model8,acc8,dec8]=svmpredict(train_out,train_in,svmmodel4);
end
% figure;
% [x,y]=confusionmat(test_out2,model7);
% temp=x./sum(x')';
% heatmap(temp);
%
% temp=[input_low_reward input_low_nonreward]';
% [coeff,score]=pca(temp);
% figure;
% plot(score(1:size(input_low_reward,2),1),score(1:size(input_low_reward,2),2),'o');
% hold on;
% plot(score(size(input_low_reward,2)+1:end,1),score(size(input_low_reward,2)+1:end,2),'xg');
%

%% switch models
[model9,acc9,dec9]=svmpredict(test_out2,test_in2,svmmodel3);
[model10,acc10,dec10]=svmpredict(test_out,test_in,svmmodel4);
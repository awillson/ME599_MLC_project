% Featurization of RAW EMG data

clear; close all; clc;
tic

%% Section 1: read in data, slice into 150 ms cube
dt = 1/1200;
time = 0:dt:3;
n = int16(.150/dt); % row length of 150 ms sample
cut = int16(.512/dt);
activity = 'stairs_';
participant = 2;

%data_out = zeros(n,16,16*9);
ind2 = 1;
for k = 1:9
    
    num = strcat('00',num2str(k));
%     trialname = strcat(activity,num);
    trialname = strcat('BP_C_002_',activity,num);

%     data_in = dlmread(strcat('../BP_C_001/',trialname,'.csv'),',',6,14);
    data_in = dlmread(strcat('../BP_C_002/',trialname,'.csv'),',',6,14);
    data_in(:,9) = [];

    %remove vicon sensor delay
    data_cut = data_in(cut:end,:);
    
    %chop into slices
    ind = 1;
    iter = 1;
    for j = ind2:ind2+15
        ind = n*(iter-1)+1;
        data_out(:,:,j) = data_cut(ind:(ind+n-1),:);
        ind2 = ind2+1;
        iter = iter+1;
    end
    
end

for k = 10:99
    num = strcat('0',num2str(k));
%     trialname = strcat(activity,num);
    trialname = strcat('BP_C_002_',activity,num);

%     data_in = dlmread(strcat('../BP_C_001/',trialname,'.csv'),',',6,14);
    data_in = dlmread(strcat('../BP_C_002/',trialname,'.csv'),',',6,14);
    data_in(:,9) = [];

    %remove vicon sensor delay
    data_cut = data_in(cut:end,:);

    %chop into slices
    ind = 1;
    iter = 1;
    for j = ind2:ind2+15
        ind = n*(iter-1)+1;
        data_out(:,:,j) = data_cut(ind:(ind+n-1),:);
        ind2 = ind2+1;
        iter = iter+1;
    end
end
for k = 100:300
    num = num2str(k);
%     trialname = strcat(activity,num);
    trialname = strcat('BP_C_002_',activity,num);

%     data_in = dlmread(strcat('../BP_C_001/',trialname,'.csv'),',',6,14);
    data_in = dlmread(strcat('../BP_C_002/',trialname,'.csv'),',',6,14);
    data_in(:,9) = [];

    %remove vicon sensor delay
    data_cut = data_in(cut:end,:);

    %chop into slices
    ind = 1;
    iter = 1;
    for j = ind2:ind2+15
        ind = n*(iter-1)+1;
        data_out(:,:,j) = data_cut(ind:(ind+n-1),:);
        ind2 = ind2+1;
        iter = iter+1;
    end
end

[signal, sensor, trial] = size(data_out);
    
%% Section 2: calculate MAV, Variance, Nzero, etc

zcd = dsp.ZeroCrossingDetector;

%each column is a "trial", 16 sensors long
for i = 1:trial
    
    for n = 1:sensor
    % Mean Average Value
    data_feat(1,n,i) = mean(data_out(:,n,i));

    % Number of zero crosssings
    data_feat(2,n,i) = zcd(data_out(:,n,i));

    % Variance
    data_feat(3,n,i) = var(data_out(:,n,i));

    % Number of slope sign changes
%     slope = diff(sign(diff(data_out(:,n,i))))~=0;
%     slope = slope(slope~=0);
%     slope = length(slope);
%     Nslope(n,i) = slope;
    [a,b] = findpeaks(data_out(:,n,i));
    [c,d] = findpeaks(-data_out(:,n,i));
    data_feat(4,n,i) = length(a)+length(b);
    
    % Waveform length
    wavl = 0;
    current = 0;
    for p = 1:signal-1
        current = abs(data_out(p+1,n,i) - data_out(p,n,i));
        wavl = wavl+current;
    end
    data_feat(5,n,i) = wavl;
    
    end
end

%% Normalize data

for i = 1:5
    for j = 1:16
        data_feat(i,j,:) = normalize_data(data_feat(i,j,:),-1,1);
    end
end

%% section 3: save data as .mat
count = 1;
count_descend = 0;
count_ascend = 0;
for i = 0:16:464
    i
%     keyboard
    if mod(count,2) == 0
        % even
        for sheet = 1:16
            stair_descend(:,:,count_descend+sheet) = data_feat(:,:,i+sheet);
        end
        count_descend = count_descend+16;
    else
        for sheet = 1:16
            stair_ascend(:,:,count_ascend+sheet) = data_feat(:,:,i+sheet);
        end
        count_ascend = count_ascend+16;
    end
    
    count = count + 1;
end

for i = 480:16:4784
    i
%     keyboard
    if mod(count,2) == 1
        % odd
        for sheet = 1:16
            stair_descend(:,:,count_descend+sheet) = data_feat(:,:,i+sheet);
        end
        count_descend = count_descend+16;
    else
        for sheet = 1:16
            stair_ascend(:,:,count_ascend+sheet) = data_feat(:,:,i+sheet);
        end
        count_ascend = count_ascend+16;
    end
    
    count = count + 1;
end

%%
    
if participant == 1
    descent_feat_norm1 = stair_descend;
    ascent_feat_norm1 = stair_ascend;
    save('stairDescent_featurized_norm1.mat','descent_feat_norm1')
    save('stairAscent_featurized_norm1.mat','ascent_feat_norm1')
elseif participant == 2
    descent_feat_norm2 = stair_descend;
    ascent_feat_norm2 = stair_ascend;
    save('stairDescent_featurized_norm2.mat','descent_feat_norm2')
    save('stairAscent_featurized_norm2.mat','ascent_feat_norm2')
end
toc
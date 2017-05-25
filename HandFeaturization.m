%%  Featurization of RAW EMG data
%   This script reads in csv files and formats emg data in an easy to
%   access .mat file.
%
%   .csv files should be located in folders one level above the folder this
%   script is in. Outputs will have 5 rows corresponding to features, 16
%   columns corresponding to sensors, and 2400 sheets corresponding to
%   150ms time periods of a given activity.
%
%   This script should be run for each participant for each activity,
%   changing the participant and activity at the top of the script.

clear; close all; clc;

%% Section 1: Read in .csv Data

% Sampling frequency
dt = 1/1200;
% Number of data points in a 150 ms sample
n = int16(.150/dt);
% We need to cut out the first 512 ms due to sensor delay in ever .csv file
cut = int16(.512/dt);

% Participant Switch. Change this depending on which participant you want
% to process data for.
participant = 2;

% Activity Names. Uncomment one of these at a time and run the script.
activity = 'fastWalk_';
% activity = 'slowWalk_';
% activity = 'crouch_';
% activity = 'sitting_';
% activity = 'standing_';

% This loop reads in all of the .csv files for the selected activity and
% formats them in a cube where the first dimension is 150 ms of EMG signal,
% the second dimension is sensors, and the third dimension is a new 150 ms
% signal.
ind2 = 1;
for k = 1:9
    num = strcat('00',num2str(k));
    
    if participant == 1
        trialname = strcat(activity,num);
        data_in = dlmread(strcat('../BP_C_001/',trialname,'.csv'),',',6,14);
    else
        trialname = strcat('BP_C_002_',activity,num);
        data_in = dlmread(strcat('../BP_C_002/',trialname,'.csv'),',',6,14);
    end
    
    % There was a single column that read a load cell instead of EMG.
    % Remove it here.
    data_in(:,9) = [];
    
    % Remove Vicon sensor delay.
    data_cut = data_in(cut:end,:);

    % Put data into 'sheets' in the third dimension
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
    
    if participant == 1
        trialname = strcat(activity,num);
        data_in = dlmread(strcat('../BP_C_001/',trialname,'.csv'),',',6,14);
    else
        trialname = strcat('BP_C_002_',activity,num);
        data_in = dlmread(strcat('../BP_C_002/',trialname,'.csv'),',',6,14);
    end
    
    % There was a single column that read a load cell instead of EMG.
    % Remove it here.
    data_in(:,9) = [];
    
    % Remove vicon sensor delay
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
for k = 100:150
    num = num2str(k);
    
    if participant == 1
        trialname = strcat(activity,num);
        data_in = dlmread(strcat('../BP_C_001/',trialname,'.csv'),',',6,14);
    else
        trialname = strcat('BP_C_002_',activity,num);
        data_in = dlmread(strcat('../BP_C_002/',trialname,'.csv'),',',6,14);
    end
    
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

% Confirm size is what we expect.
[signal, sensor, trial] = size(data_out);
    
%%  Section 2: Featurize the data
%   In this section of the code, we extract features from the data. The
%   features in descending order are 1. Mean 2. Number of Zero Crossings 3.
%   Variance 4. Number of slope sign changes 5. Waveform length
%   After this section, the data will be stored in a 3D matrix, where each
%   'sheet' is a labeled example, rows are features, and columns are
%   sensors.

% Access the zero crossing detector from the digital signal processing
% toolbox.
zcd = dsp.ZeroCrossingDetector;

% Run a loop that featurizes the data.
for i = 1:trial
    
    for n = 1:sensor
    % Mean Average Value
    data_feat(1,n,i) = mean(data_out(:,n,i));

    % Number of zero crosssings
    data_feat(2,n,i) = zcd(data_out(:,n,i));

    % Variance
    data_feat(3,n,i) = var(data_out(:,n,i));

    % Number of slope sign changes
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

%% Section 3: Save data in .mat format

% Logically name the files to save.
if participant == 1
    if strcmp(activity,'crouch_')
        crouch_feat1 = data_feat;
        save('crouch_featurized1.mat','crouch_feat1');
    elseif strcmp(activity,'slowWalk_')  
        slowWalk_feat1 = data_feat;
        save('slowWalk_featurized1.mat','slowWalk_feat1');
    elseif strcmp(activity,'sitting_')
        sitting_feat1 = data_feat;
        save('sitting_featurized1.mat','sitting_feat1');
    elseif strcmp(activity,'fastWalk_')
        fastWalk_feat1 = data_feat;
        save('fastWalk_featurized1.mat','fastWalk_feat1');
    elseif strcmp(activity,'standing_')
        standing_feat1 = data_feat;
        save('standing_featurized1.mat','standing_feat1');
    end
elseif participant == 2
    if strcmp(activity,'crouch_')
        crouch_feat2 = data_feat;
        save('crouch_featurized2.mat','crouch_feat2');
    elseif strcmp(activity,'slowWalk_')  
        slowWalk_feat2 = data_feat;
        save('slowWalk_featurized2.mat','slowWalk_feat2');
    elseif strcmp(activity,'sitting_')
        sitting_feat2 = data_feat;
        save('sitting_featurized2.mat','sitting_feat2');
    elseif strcmp(activity,'fastWalk_')
        fastWalk_feat2 = data_feat;
        save('fastWalk_featurized2.mat','fastWalk_feat2');
    elseif strcmp(activity,'standing_')
        standing_feat2 = data_feat;
        save('standing_featurized2.mat','standing_feat2');
    end
end
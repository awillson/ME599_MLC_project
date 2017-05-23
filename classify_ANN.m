%% Try Out ANN on our Data Set!

clear; close all; clc;

%% Import
load crouch_featurized1.mat
load fastWalk_featurized1.mat
load slowWalk_featurized1.mat
load sitting_featurized1.mat
load standing_featurized1.mat

%% Reshape the training data into the same format as in the example code

for i = 1:1200
    trainingData(i,:) = reshape(crouch_feat1(:,:,i)', 1, 80);
    trainingLabels{i} = 'crouch';
end

for i = 1:1200
    trainingData(i+1200,:) = reshape(fastWalk_feat1(:,:,i)', 1, 80);
    trainingLabels{i+1200} = 'fastWalk';
end

for i = 1:1200
    trainingData(i+2400,:) = reshape(sitting_feat1(:,:,i)', 1, 80);
    trainingLabels{i+2400} = 'sitting';
end

for i = 1:1200
    trainingData(i+3600,:) = reshape(slowWalk_feat1(:,:,i)', 1, 80);
    trainingLabels{i+3600} = 'slowWalk';
end

for i = 1:1200
    trainingData(i+4800,:) = reshape(standing_feat1(:,:,i)', 1, 80);
    trainingLabels{i+4800} = 'standing';
end

trainingLabels = trainingLabels';

%% Reshape the testing data 

for i = 1:1200
    testingData(i,:) = reshape(crouch_feat1(:,:,i+1200)', 1, 80);
    testingLabels{i} = 'crouch';
end

for i = 1:1200
    testingData(i+1200,:) = reshape(fastWalk_feat1(:,:,i+1200)', 1, 80);
    testingLabels{i+1200} = 'fastWalk';
end

for i = 1:1200
    testingData(i+2400,:) = reshape(sitting_feat1(:,:,i+1200)', 1, 80);
    testingLabels{i+2400} = 'sitting';
end

for i = 1:1200
    testingData(i+3600,:) = reshape(slowWalk_feat1(:,:,i+1200)', 1, 80);
    testingLabels{i+3600} = 'slowWalk';
end

for i = 1:1200
    testingData(i+4800,:) = reshape(standing_feat1(:,:,i+1200)', 1, 80);
    testingLabels{i+4800} = 'standing';
end

testingLabels = testingLabels';

%% Construct targets

for i = 1:length(trainingData)
    if strcmp(trainingLabels(i), 'crouch')
        trainingTargets(i,:) = [1 0 0 0 0];
    elseif strcmp(trainingLabels(i), 'fastWalk')
        trainingTargets(i,:) = [0 1 0 0 0];
    elseif strcmp(trainingLabels(i), 'sitting')
        trainingTargets(i,:) = [0 0 1 0 0];
    elseif strcmp(trainingLabels(i), 'slowWalk')
        trainingTargets(i,:) = [0 0 0 1 0];
    else
        trainingTargets(i,:) = [0 0 0 0 1];
    end
end

for i = 1:length(testingData)
    if strcmp(testingLabels(i), 'crouch')
        testingTargets(i,:) = [1 0 0 0 0];
    elseif strcmp(testingLabels(i), 'fastWalk')
        testingTargets(i,:) = [0 1 0 0 0];
    elseif strcmp(testingLabels(i), 'sitting')
        testingTargets(i,:) = [0 0 1 0 0];
    elseif strcmp(testingLabels(i), 'slowWalk')
        testingTargets(i,:) = [0 0 0 1 0];
    else
        testingTargets(i,:) = [0 0 0 0 1];
    end
end

%this is cool    
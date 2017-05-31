%% Try Out ANN on our Data Set!

clear; close all; clc;

%% Import
load crouch_featurized_norm1.mat
load fastWalk_featurized_norm1.mat
load slowWalk_featurized_norm1.mat
load sitting_featurized_norm1.mat
load standing_featurized_norm1.mat
load dorsiFlex_featurized_norm1.mat
load plantarFlex_featurized_norm1.mat
load stairAscent_featurized_norm1.mat
load stairDescent_featurized_norm1.mat

load crouch_featurized_norm2.mat
load fastWalk_featurized_norm2.mat
load slowWalk_featurized_norm2.mat
load sitting_featurized_norm2.mat
load standing_featurized_norm2.mat
load dorsiFlex_featurized_norm2.mat
load plantarFlex_featurized_norm2.mat
load stairAscent_featurized_norm2.mat
load stairDescent_featurized_norm2.mat

%% Reshape the testing data 

% To train the classifier, a matrix must be built where each row
% corresponds to a labeled example, and each column is a
% measurement/feature.

% Use this switch to determine which data is used for training.
% training = 'P1';
 training = 'P2';
% training = 'P1&P2';

% Use this switch to determine which data is used for testing.
% testing = 'P1';
 testing = 'P2';
% testing = 'P1&P2';

parfor i = 1:1200
    trainingData1(i,:) = reshape(crouch_feat_norm1(:,:,i), 1, 80);
    trainingData2(i,:) = reshape(crouch_feat_norm2(:,:,i), 1, 80);
    trainingLabels{i} = 'crouch';
end


parfor i = 1:1200
    trainingData1(i+1200,:) = reshape(fastWalk_feat_norm1(:,:,i), 1, 80);
    trainingData2(i+1200,:) = reshape(fastWalk_feat_norm2(:,:,i), 1, 80);
    trainingLabels{i+1200} = 'fastWalk';
end

parfor i = 1:1200
    trainingData1(i+2400,:) = reshape(sitting_feat_norm1(:,:,i), 1, 80);
    trainingData2(i+2400,:) = reshape(sitting_feat_norm2(:,:,i), 1, 80);
    trainingLabels{i+2400} = 'sitting';
end

parfor i = 1:1200
    trainingData1(i+3600,:) = reshape(slowWalk_feat_norm1(:,:,i), 1, 80);
    trainingData2(i+3600,:) = reshape(slowWalk_feat_norm2(:,:,i), 1, 80);
    trainingLabels{i+3600} = 'slowWalk';
end

parfor i = 1:1200
    trainingData1(i+4800,:) = reshape(standing_feat_norm1(:,:,i), 1, 80);
    trainingData2(i+4800,:) = reshape(standing_feat_norm2(:,:,i), 1, 80);
    trainingLabels{i+4800} = 'standing';
end

parfor i = 1:1200
    trainingData1(i+6000,:) = reshape(ascent_feat_norm1(:,:,i), 1, 80);
    trainingData2(i+6000,:) = reshape(ascent_feat_norm2(:,:,i), 1, 80);
    trainingLabels{i+6000} = 'stair ascent';
end

parfor i = 1:1200
    trainingData1(i+7200,:) = reshape(descent_feat_norm1(:,:,i), 1, 80);
    trainingData2(i+7200,:) = reshape(descent_feat_norm2(:,:,i), 1, 80);
    trainingLabels{i+7200} = 'stair descent';
end

parfor i = 1:1200
    trainingData1(i+8400,:) = reshape(dorsi_feat_norm1(:,:,i), 1, 80);
    trainingData2(i+8400,:) = reshape(dorsi_feat_norm2(:,:,i), 1, 80);
    trainingLabels{i+8400} = 'dorsi';
end

parfor i = 1:1200
    trainingData1(i+9600,:) = reshape(plantar_feat_norm1(:,:,i), 1, 80);
    trainingData2(i+9600,:) = reshape(plantar_feat_norm2(:,:,i), 1, 80);
    trainingLabels{i+9600} = 'plantar';
end

% Put together training matrix based up which data was selected above.
if strcmp(training, 'P1')
    trainingData = trainingData1;
    trainingLabels = trainingLabels';
elseif strcmp(training, 'P2')
    trainingData = trainingData2;
    trainingLabels = trainingLabels';
elseif strcmp(training, 'P1&P2')
    trainingData = vertcat(trainingData1,trainingData2);
    trainingLabels = vertcat(trainingLabels', trainingLabels');
end
%% Reshape the testing data 

parfor i = 1:1200
    testingData1(i,:) = reshape(crouch_feat_norm1(:,:,i+1200), 1, 80);
    testingData2(i,:) = reshape(crouch_feat_norm2(:,:,i+1200), 1, 80);
    testingLabels{i} = 'crouch';
end

parfor i = 1:1200
    testingData1(i+1200,:) = reshape(fastWalk_feat_norm1(:,:,i+1200), 1, 80);
    testingData2(i+1200,:) = reshape(fastWalk_feat_norm2(:,:,i+1200), 1, 80);
    testingLabels{i+1200} = 'fastWalk';
end

parfor i = 1:1200
    testingData1(i+2400,:) = reshape(sitting_feat_norm1(:,:,i+1200), 1, 80);
    testingData2(i+2400,:) = reshape(sitting_feat_norm2(:,:,i+1200), 1, 80);
    testingLabels{i+2400} = 'sitting';
end

parfor i = 1:1200
    testingData1(i+3600,:) = reshape(slowWalk_feat_norm1(:,:,i+1200), 1, 80);
    testingData2(i+3600,:) = reshape(slowWalk_feat_norm2(:,:,i+1200), 1, 80);
    testingLabels{i+3600} = 'slowWalk';
end

parfor i = 1:1200
    testingData1(i+4800,:) = reshape(standing_feat_norm1(:,:,i+1200), 1, 80);
    testingData2(i+4800,:) = reshape(standing_feat_norm2(:,:,i+1200), 1, 80);
    testingLabels{i+4800} = 'standing';
end

parfor i = 1:1200
    testingData1(i+6000,:) = reshape(ascent_feat_norm1(:,:,i+1200), 1, 80);
    testingData2(i+6000,:) = reshape(ascent_feat_norm2(:,:,i+1200), 1, 80);
    testingLabels{i+6000} = 'stair ascent';
end

parfor i = 1:1200
    testingData1(i+7200,:) = reshape(descent_feat_norm1(:,:,i+1200), 1, 80);
    testingData2(i+7200,:) = reshape(descent_feat_norm2(:,:,i+1200), 1, 80);
    testingLabels{i+7200} = 'stair descent';
end

parfor i = 1:1200
    testingData1(i+8400,:) = reshape(dorsi_feat_norm1(:,:,i+1200), 1, 80);
    testingData2(i+8400,:) = reshape(dorsi_feat_norm2(:,:,i+1200), 1, 80);
    testingLabels{i+8400} = 'dorsi';
end

parfor i = 1:1200
    testingData1(i+9600,:) = reshape(plantar_feat_norm1(:,:,i+1200), 1, 80);
    testingData2(i+9600,:) = reshape(plantar_feat_norm2(:,:,i+1200), 1, 80);
    testingLabels{i+9600} = 'plantar';
end

% Put together testing matrix based up which data was selected above.
if strcmp(testing, 'P1')
    testingData = testingData1;
    testingLabels = testingLabels';
elseif strcmp(testing, 'P2')
    testingData = testingData2;
    testingLabels = testingLabels';
elseif strcmp(testing, 'P1&P2')
    testingData = vertcat(testingData1,testingData2);
    testingLabels = vertcat(testingLabels', testingLabels');
end


%% Construct targets

for i = 1:length(trainingData)
    if strcmp(trainingLabels(i), 'crouch')
        trainingTargets(i,:) = [1 0 0 0 0 0 0 0 0];
    elseif strcmp(trainingLabels(i), 'fastWalk')
        trainingTargets(i,:) = [0 1 0 0 0 0 0 0 0];
    elseif strcmp(trainingLabels(i), 'sitting')
        trainingTargets(i,:) = [0 0 1 0 0 0 0 0 0];
    elseif strcmp(trainingLabels(i), 'slowWalk')
        trainingTargets(i,:) = [0 0 0 1 0 0 0 0 0];
    elseif strcmp(trainingLabels(i), 'standing')
        trainingTargets(i,:) = [0 0 0 0 1 0 0 0 0];
    elseif strcmp(trainingLabels(i), 'stair ascent')
        trainingTargets(i,:) = [0 0 0 0 0 1 0 0 0];
    elseif strcmp(trainingLabels(i), 'stair descent')
        trainingTargets(i,:) = [0 0 0 0 0 0 1 0 0];
    elseif strcmp(trainingLabels(i), 'dorsi')
        trainingTargets(i,:) = [0 0 0 0 0 0 0 1 0];
    else %plantarflexion
        trainingTargets(i,:) = [0 0 0 0 0 0 0 0 1];
    end
end

for i = 1:length(testingData)
    if strcmp(testingLabels(i), 'crouch')
        testingTargets(i,:) = [1 0 0 0 0 0 0 0 0];
    elseif strcmp(testingLabels(i), 'fastWalk')
        testingTargets(i,:) = [0 1 0 0 0 0 0 0 0];
    elseif strcmp(testingLabels(i), 'sitting')
        testingTargets(i,:) = [0 0 1 0 0 0 0 0 0];
    elseif strcmp(testingLabels(i), 'slowWalk')
        testingTargets(i,:) = [0 0 0 1 0 0 0 0 0];
    elseif strcmp(testingLabels(i), 'standing')
        testingTargets(i,:) = [0 0 0 0 1 0 0 0 0];
    elseif strcmp(testingLabels(i), 'stair ascent')
        testingTargets(i,:) = [0 0 0 0 0 1 0 0 0];
    elseif strcmp(testingLabels(i), 'stair descent')
        testingTargets(i,:) = [0 0 0 0 0 0 1 0 0];
    elseif strcmp(testingLabels(i), 'dorsi')
        testingTargets(i,:) = [0 0 0 0 0 0 0 1 0];
    else %plantarflexion
        testingTargets(i,:) = [0 0 0 0 0 0 0 0 1];
    end
end
    
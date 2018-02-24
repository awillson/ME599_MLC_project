function [X, Xlabels] = getDataMatrix_ASB(training,testing)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


load fastWalk_featurized1.mat
load slowWalk_featurized1.mat
load sitting_featurized1.mat
load standing_featurized1.mat
load stairAscent_featurized1.mat
load stairDescent_featurized1.mat

load fastWalk_featurized2.mat
load slowWalk_featurized2.mat
load sitting_featurized2.mat
load standing_featurized2.mat
load stairAscent_featurized2.mat
load stairDescent_featurized2.mat

% Reshape the training data into format needed for training.
% To train the classifier, a matrix must be built where each row
% corresponds to a labeled example, and each column is a
% measurement/feature.

parfor i = 1:1200
    trainingData1(i,:) = reshape(fastWalk_feat1(:,:,i), 1, 80);
    trainingData2(i,:) = reshape(fastWalk_feat2(:,:,i), 1, 80);
    trainingLabels{i} = 'fastWalk';
end

parfor i = 1:1200
    trainingData1(i+1200,:) = reshape(sitting_feat1(:,:,i), 1, 80);
    trainingData2(i+1200,:) = reshape(sitting_feat2(:,:,i), 1, 80);
    trainingLabels{i+1200} = 'sitting';
end

parfor i = 1:1200
    trainingData1(i+2400,:) = reshape(slowWalk_feat1(:,:,i), 1, 80);
    trainingData2(i+2400,:) = reshape(slowWalk_feat2(:,:,i), 1, 80);
    trainingLabels{i+2400} = 'slowWalk';
end

parfor i = 1:1200
    trainingData1(i+3600,:) = reshape(standing_feat1(:,:,i), 1, 80);
    trainingData2(i+3600,:) = reshape(standing_feat2(:,:,i), 1, 80);
    trainingLabels{i+3600} = 'standing';
end

parfor i = 1:1200
    trainingData1(i+4800,:) = reshape(ascent_feat1(:,:,i), 1, 80);
    trainingData2(i+4800,:) = reshape(ascent_feat2(:,:,i), 1, 80);
    trainingLabels{i+4800} = 'stair ascent';
end

parfor i = 1:1200
    trainingData1(i+6000,:) = reshape(descent_feat1(:,:,i), 1, 80);
    trainingData2(i+6000,:) = reshape(descent_feat2(:,:,i), 1, 80);
    trainingLabels{i+6000} = 'stair descent';
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


parfor i = 1:1200
    testingData1(i,:) = reshape(fastWalk_feat1(:,:,i+1200), 1, 80);
    testingData2(i,:) = reshape(fastWalk_feat2(:,:,i+1200), 1, 80);
    testingLabels{i} = 'fastWalk';
end

parfor i = 1:1200
    testingData1(i+1200,:) = reshape(sitting_feat1(:,:,i+1200), 1, 80);
    testingData2(i+1200,:) = reshape(sitting_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+1200} = 'sitting';
end

parfor i = 1:1200
    testingData1(i+2400,:) = reshape(slowWalk_feat1(:,:,i+1200), 1, 80);
    testingData2(i+2400,:) = reshape(slowWalk_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+2400} = 'slowWalk';
end

parfor i = 1:1200
    testingData1(i+3600,:) = reshape(standing_feat1(:,:,i+1200), 1, 80);
    testingData2(i+3600,:) = reshape(standing_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+3600} = 'standing';
end

parfor i = 1:1200
    testingData1(i+4800,:) = reshape(ascent_feat1(:,:,i+1200), 1, 80);
    testingData2(i+4800,:) = reshape(ascent_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+4800} = 'stair ascent';
end

parfor i = 1:1200
    testingData1(i+6000,:) = reshape(descent_feat1(:,:,i+1200), 1, 80);
    testingData2(i+6000,:) = reshape(descent_feat2(:,:,i+1200), 1, 80);
    testingLabels{i+6000} = 'stair descent';
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

X = [trainingData; testingData]; % each column is a measurement type, each row is an observation
Xlabels = [trainingLabels; testingLabels];

end


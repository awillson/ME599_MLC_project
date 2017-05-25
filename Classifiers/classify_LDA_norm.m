%% Try Out LDA on our normed Data Set

clear; close all; clc;

%% Import
load crouch_featurized_norm1.mat
load fastWalk_featurized_norm1.mat
load slowWalk_featurized_norm1.mat
load sitting_featurized_norm1.mat
load standing_featurized_norm1.mat

% load crouch_featurized2.mat
% load fastWalk_featurized2.mat
% load slowWalk_featurized2.mat
% load sitting_featurized2.mat
% load standing_featurized2.mat
%% Reshape the training data into the same format as in the example code

for i = 1:1200
    trainingData1(i,:) = reshape(crouch_feat_norm1(:,:,i), 1, 80);
%     trainingData2(i,:) = reshape(crouch_feat_norm2(:,:,i), 1, 80);
    trainingLabels{i} = 'crouch';
end


for i = 1:1200
    trainingData1(i+1200,:) = reshape(fastWalk_feat_norm1(:,:,i), 1, 80);
%     trainingData2(i+1200,:) = reshape(fastWalk_feat_norm2(:,:,i), 1, 80);
    trainingLabels{i+1200} = 'fastWalk';
end

for i = 1:1200
    trainingData1(i+2400,:) = reshape(sitting_feat_norm1(:,:,i), 1, 80);
%     trainingData2(i+2400,:) = reshape(sitting_feat_norm2(:,:,i), 1, 80);
    trainingLabels{i+2400} = 'sitting';
end

for i = 1:1200
    trainingData1(i+3600,:) = reshape(slowWalk_feat_norm1(:,:,i), 1, 80);
%     trainingData2(i+3600,:) = reshape(slowWalk_feat_norm2(:,:,i), 1, 80);
    trainingLabels{i+3600} = 'slowWalk';
end

for i = 1:1200
    trainingData1(i+4800,:) = reshape(standing_feat_norm1(:,:,i), 1, 80);
%     trainingData2(i+4800,:) = reshape(standing_feat_norm2(:,:,i), 1, 80);
    trainingLabels{i+4800} = 'standing';
end
% trainingData = vertcat(trainingData1,trainingData2);
trainingData = trainingData1;
trainingLabels = trainingLabels';
% trainingLabels = vertcat(trainingLabels,trainingLabels);

%% Reshape the testing data 

for i = 1:1200
    testingData1(i,:) = reshape(crouch_feat_norm1(:,:,i+1200), 1, 80);
%     testingData2(i,:) = reshape(crouch_feat_norm2(:,:,i+1200), 1, 80);
    testingLabels{i} = 'crouch';
end

for i = 1:1200
    testingData1(i+1200,:) = reshape(fastWalk_feat_norm1(:,:,i+1200), 1, 80);
%     testingData2(i+1200,:) = reshape(fastWalk_feat_norm2(:,:,i+1200), 1, 80);
    testingLabels{i+1200} = 'fastWalk';
end

for i = 1:1200
    testingData1(i+2400,:) = reshape(sitting_feat_norm1(:,:,i+1200), 1, 80);
%     testingData2(i+2400,:) = reshape(sitting_feat_norm2(:,:,i+1200), 1, 80);
    testingLabels{i+2400} = 'sitting';
end

for i = 1:1200
    testingData1(i+3600,:) = reshape(slowWalk_feat_norm1(:,:,i+1200), 1, 80);
%     testingData2(i+3600,:) = reshape(slowWalk_feat_norm2(:,:,i+1200), 1, 80);
    testingLabels{i+3600} = 'slowWalk';
end

for i = 1:1200
    testingData1(i+4800,:) = reshape(standing_feat_norm1(:,:,i+1200), 1, 80);
%     testingData2(i+4800,:) = reshape(standing_feat_norm2(:,:,i+1200), 1, 80);
    testingLabels{i+4800} = 'standing';
end

% testingData = vertcat(testingData1,testingData2);
testingData = testingData1;
testingLabels = testingLabels';
% testingLabels = vertcat(testingLabels,testingLabels);

%% Create the classifier

% Can't believe it's this easy.
LDAclassifier = fitcdiscr(trainingData,trainingLabels);

%% Evaluate the classifier on the test data

% Test crouching
for i = 1:1200
   ourCrouchPrediction(i) = predict(LDAclassifier, testingData(i,:));
end
ourCrouchPrediction = ourCrouchPrediction';
a = find(strcmp(ourCrouchPrediction,'crouch'));
accuracyCrouch = length(a)/1200;

% Test fastWalk
for i = 1:1200
    ourFastPrediction(i) = predict(LDAclassifier, testingData(i+1200,:));
end
ourFastPrediction = ourFastPrediction';
b = find(strcmp(ourFastPrediction,'fastWalk'));
accuracyFast = length(b)/1200;

% Test sitting
for i = 1:1200
    ourSittingPrediction(i) = predict(LDAclassifier, testingData(i+2400,:));
end
ourSittingPrediction = ourSittingPrediction';
c = find(strcmp(ourSittingPrediction,'sitting'));
accuracySitting = length(c)/1200; 

% Test slow walking
for i = 1:1200
    ourSlowPrediction(i) = predict(LDAclassifier, testingData(i+3600,:));
end
ourSlowPrediction = ourSlowPrediction';
d = find(strcmp(ourSlowPrediction,'slowWalk'));
accuracySlow = length(d)/1200;

% Test standing
for i = 1:1200
    ourStandingPrediction(i) = predict(LDAclassifier, testingData(i+4800,:));
end
ourStandingPrediction = ourStandingPrediction';
e = find(strcmp(ourStandingPrediction,'standing'));
accuracyStanding = length(e)/1200;

meanAccuracy = mean([accuracyCrouch; accuracyFast; accuracySitting;...
                        accuracySlow; accuracyStanding]);
                    
%% Try visualizing

allData = trainingData;
allLabels = trainingLabels;

v(:,1) = LDAclassifier.Coeffs(4, 2).Linear;
v(:,2) = LDAclassifier.Coeffs(1, 3).Linear;
v(:,3) = LDAclassifier.Coeffs(2, 3).Linear;

figure, hold on
for i=1:3:size(allData,1)
x = v(:,1)'*allData(i,:)';
y = v(:,2)'*allData(i,:)';
z = v(:,3)'*allData(i,:)';
    if strcmp(allLabels(i),'crouch')
        plot3(x,y,z,'ro','LineWidth',2);
    elseif strcmp(allLabels(i),'fastWalk')
        plot3(x,y,z,'bo','LineWidth',2);
    elseif strcmp(allLabels(i),'sitting')
        plot3(x,y,z,'go','LineWidth',2);
    elseif strcmp(allLabels(i),'standing')
        plot3(x,y,z,'yo','LineWidth',2);
    elseif strcmp(allLabels(i),'slowWalk')
        plot3(x,y,z,'co','LineWidth',2);
    elseif strcmp(allLabels(i),'dorsiflexion')
        plot3(x,y,z,'mo','LineWidth',2);
    elseif strcmp(allLabels(i),'plantarflexion')
        plot3(x,y,z,'ko','LineWidth',2);
    elseif strcmp(allLabels(i),'stair ascent')
        plot3(x,y,z,'o','Color',[0.75,0.5,0.25],'LineWidth',2);
    elseif strcmp(allLabels(i),'stair descent')
        plot3(x,y,z,'x','Color',[0.25,0.5,0.75],'LineWidth',2);
    end
end
view(85,25), grid on, set(gca,'FontSize',13)



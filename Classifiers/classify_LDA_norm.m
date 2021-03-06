%%  Perform LDA on our normalized Data Set
%   This script trains a linear discriminant analysis classifer to our data
%   and tests its accuracy.
%   Data points are also cast into LDA basis for 3D visualization.

clear; close all; clc;
tic
%% Import data cubes

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

%% Reshape the training data into format needed for training.

% To train the classifier, a matrix must be built where each row
% corresponds to a labeled example, and each column is a
% measurement/feature.

% Use this switch to determine which data is used for training.
 training = 'P1';
% training = 'P2';
% training = 'P1&P2';

% Use this switch to determine which data is used for testing.
 testing = 'P1';
% testing = 'P2';
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

%% Create the classifier

% trainingData(:,46:50) = [];

% Can't believe it's this easy.
LDAclassifier = fitcdiscr(trainingData,trainingLabels);

%% Evaluate the classifier on the test data

% Test crouching
parfor i = 1:1200
   ourCrouchPrediction(i) = predict(LDAclassifier, testingData(i,:));
end
ourCrouchPrediction = ourCrouchPrediction';
a = find(strcmp(ourCrouchPrediction,'crouch'));
accuracyCrouch = length(a)/1200;

% Test fastWalk
parfor i = 1:1200
    ourFastPrediction(i) = predict(LDAclassifier, testingData(i+1200,:));
end
ourFastPrediction = ourFastPrediction';
b = find(strcmp(ourFastPrediction,'fastWalk'));
accuracyFast = length(b)/1200;

% Test sitting
parfor i = 1:1200
    ourSittingPrediction(i) = predict(LDAclassifier, testingData(i+2400,:));
end
ourSittingPrediction = ourSittingPrediction';
c = find(strcmp(ourSittingPrediction,'sitting'));
accuracySitting = length(c)/1200; 

% Test slow walking
parfor i = 1:1200
    ourSlowPrediction(i) = predict(LDAclassifier, testingData(i+3600,:));
end
ourSlowPrediction = ourSlowPrediction';
d = find(strcmp(ourSlowPrediction,'slowWalk'));
accuracySlow = length(d)/1200;

% Test standing
parfor i = 1:1200
    ourStandingPrediction(i) = predict(LDAclassifier, testingData(i+4800,:));
end
ourStandingPrediction = ourStandingPrediction';
e = find(strcmp(ourStandingPrediction,'standing'));
accuracyStanding = length(e)/1200;

% Test stair ascent
parfor i = 1:1200
    ourAscentPrediction(i) = predict(LDAclassifier, testingData(i+6000,:));
end
ourAscentPrediction = ourAscentPrediction';
f = find(strcmp(ourAscentPrediction,'stair ascent'));
accuracyAscent = length(f)/1200;

% Test stair descent
parfor i = 1:1200
    ourDescentPrediction(i) = predict(LDAclassifier, testingData(i+7200,:));
end
ourDescentPrediction = ourDescentPrediction';
g = find(strcmp(ourDescentPrediction,'stair descent'));
accuracyDescent = length(g)/1200;

% Test dorsiflexion
parfor i = 1:1200
    ourDorsiPrediction(i) = predict(LDAclassifier, testingData(i+8400,:));
end
ourDorsiPrediction = ourDorsiPrediction';
h = find(strcmp(ourDorsiPrediction,'dorsi'));
accuracyDorsi = length(h)/1200;

% Test plantarflexion
parfor i = 1:1200
    ourPlantarPrediction(i) = predict(LDAclassifier, testingData(i+9600,:));
end
ourPlantarPrediction = ourPlantarPrediction';
j = find(strcmp(ourPlantarPrediction,'plantar'));
accuracyPlantar = length(j)/1200;

meanAccuracy = mean([accuracyCrouch; accuracyFast; accuracySitting;...
                        accuracySlow; accuracyStanding; accuracyAscent;...
                            accuracyDescent; accuracyDorsi; accuracyPlantar]);
toc
%% Visualize using LDA bases

% The variable allData will be visualized.
allData = trainingData;
allLabels = trainingLabels;

% Within the LDA classifier object, coefficients for basis vectors are
% stored. If you want to differentiate between two activities
% 1. crouch 2. dorsi 3. fast 4. plantar 5. sitting 6. slow 7. stair ascent
% 8. stair descent 9. standing

v(:,1) = LDAclassifier.Coeffs(3, 6).Linear;
v(:,2) = LDAclassifier.Coeffs(7, 8).Linear;
v(:,3) = LDAclassifier.Coeffs(5, 9).Linear;

% Project the high dimensional data into the basis vectors chosen above,
% and color code data points by activity.

figure, hold on
for i = 1:5:length(allLabels)
    
    % Project
    x = v(:,1)'*allData(i,:)';
    y = v(:,2)'*allData(i,:)';
    z = v(:,3)'*allData(i,:)';
    
    % Color and plot
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
    elseif strcmp(allLabels(i),'dorsi')
        plot3(x,y,z,'mo','LineWidth',2);
    elseif strcmp(allLabels(i),'plantar')
        plot3(x,y,z,'ko','LineWidth',2);
    elseif strcmp(allLabels(i),'stair ascent')
        plot3(x,y,z,'o','Color',[0.75,0.5,0.25],'LineWidth',2);
    elseif strcmp(allLabels(i),'stair descent')
        plot3(x,y,z,'x','Color',[0.25,0.5,0.75],'LineWidth',2);
    end
end

view(85,25), grid on, set(gca,'FontSize',13)
xlabel('fast, slow')
ylabel('ascent, descent')
zlabel('sit, stand')


% Project
x = v(:,1)'*allData.'; 
y = v(:,2)'*allData.';
z = v(:,3)'*allData.';
grad = 5;
%index = 2400*[1:8];
index = 1200*[1:8];
x1 = x(1:grad:index(1)); y1 = y(1:grad:index(1));z1 = z(1:grad:index(1));
x2 = x(index(1)+1:grad:index(2)); y2 = y(index(1)+1:grad:index(2));z2 = z(index(1)+1:grad:index(2));
x3 = x(index(2)+1:grad:index(3)); y3 = y(index(2)+1:grad:index(3));z3 = z(index(2)+1:grad:index(3));
x4 = x(index(3)+1:grad:index(4)); y4 = y(index(3)+1:grad:index(4));z4 = z(index(3)+1:grad:index(4));
x5 = x(index(4)+1:grad:index(5)); y5 = y(index(4)+1:grad:index(5));z5 = z(index(4)+1:grad:index(5));
x6 = x(index(5)+1:grad:index(6)); y6 = y(index(5)+1:grad:index(6));z6 = z(index(5)+1:grad:index(6));
x7 = x(index(6)+1:grad:index(7)); y7 = y(index(6)+1:grad:index(7));z7 = z(index(6)+1:grad:index(7));
x8 = x(index(7)+1:grad:index(8)); y8 = y(index(7)+1:grad:index(8));z8 = z(index(7)+1:grad:index(8));
x9 = x(index(8)+1:grad:end); y9 = y(index(8)+1:grad:end);z9 = z(index(8)+1:grad:end);

figure
subplot(1,4,1), grid on, hold on

    plot(x1,y1,'ro','LineWidth',2); hold on    
    plot(x3,y3,'go','LineWidth',2);
    plot(x5,y5,'co','LineWidth',2);
    plot(x8,y8,'o','Color',[0.75,0.5,0.25],'LineWidth',2);
    plot(x9,y9,'x','Color',[0.25,0.5,0.75],'LineWidth',2);
    plot(x6,y6,'mo','LineWidth',2);
    plot(x7,y7,'ko','LineWidth',2);
    plot(x2,y2,'bo','LineWidth',2);
    plot(x4,y4,'yo','LineWidth',2);
    xlabel('fast, slow')
    ylabel('ascent, descent')
subplot(1,4,2), grid on, hold on
    plot(y1,z1,'ro','LineWidth',2); hold on
    plot(y2,z2,'bo','LineWidth',2);
    plot(y4,z4,'yo','LineWidth',2);
    plot(y8,z8,'o','Color',[0.75,0.5,0.25],'LineWidth',2);
    plot(y9,z9,'x','Color',[0.25,0.5,0.75],'LineWidth',2);
    plot(y5,z5,'co','LineWidth',2);
    plot(y3,z3,'go','LineWidth',2);
    plot(y6,z6,'mo','LineWidth',2);
    plot(y7,z7,'ko','LineWidth',2);
    % 1 = crouch red
% 2 = fasWalk blue
% 3 = sitting green
% 4 = slow    yellow
% 5 = sstand   cyan
% 6 = ascent   magenta
% 7 = descent  black
% 8 = dorsiflec  reddish
% 9 = plantarflex  blueish
    legend('crouch','fastWalk','slowWalk','dorsiflex','plantarflex','standing','sitting','stair ascent','stair descent')
    xlabel('ascent, descent')
    ylabel('sit, stand')
subplot(1,4,3), grid on, hold on
    plot(x1,z1,'ro','LineWidth',2); hold on
    plot(x6,z6,'mo','LineWidth',2);
    plot(x7,z7,'ko','LineWidth',2);
    plot(x8,z8,'o','Color',[0.75,0.5,0.25],'LineWidth',2);
    plot(x9,z9,'x','Color',[0.25,0.5,0.75],'LineWidth',2);
    plot(x2,z2,'bo','LineWidth',2);
    plot(x4,z4,'yo','LineWidth',2);
    plot(x5,z5,'co','LineWidth',2);
    plot(x3,z3,'go','LineWidth',2);
    xlabel('fast, slow')
    ylabel('sit, stand')



%% Evaluate most highly weighted dimensions in the LDA basis vectors
          
featTest(:,1) = LDAclassifier.Coeffs(1, 2).Linear;
featTest(:,2) = LDAclassifier.Coeffs(1, 3).Linear;
featTest(:,3) = LDAclassifier.Coeffs(1, 4).Linear;
featTest(:,4) = LDAclassifier.Coeffs(1, 5).Linear;
featTest(:,5) = LDAclassifier.Coeffs(1, 6).Linear;
featTest(:,6) = LDAclassifier.Coeffs(1, 7).Linear;
featTest(:,7) = LDAclassifier.Coeffs(1, 8).Linear;
featTest(:,8) = LDAclassifier.Coeffs(1, 9).Linear;
featTest(:,9) = LDAclassifier.Coeffs(2, 3).Linear;
featTest(:,10) = LDAclassifier.Coeffs(2, 4).Linear;
featTest(:,11) = LDAclassifier.Coeffs(2, 5).Linear;
featTest(:,12) = LDAclassifier.Coeffs(2, 6).Linear;
featTest(:,13) = LDAclassifier.Coeffs(2, 7).Linear;
featTest(:,14) = LDAclassifier.Coeffs(2, 8).Linear;
featTest(:,15) = LDAclassifier.Coeffs(2, 9).Linear;
featTest(:,16) = LDAclassifier.Coeffs(3, 4).Linear;
featTest(:,17) = LDAclassifier.Coeffs(3, 5).Linear;
featTest(:,18) = LDAclassifier.Coeffs(3, 6).Linear;
featTest(:,19) = LDAclassifier.Coeffs(3, 7).Linear;
featTest(:,20) = LDAclassifier.Coeffs(3, 8).Linear;
featTest(:,21) = LDAclassifier.Coeffs(3, 9).Linear;
featTest(:,22) = LDAclassifier.Coeffs(4, 5).Linear;
featTest(:,23) = LDAclassifier.Coeffs(4, 6).Linear;
featTest(:,24) = LDAclassifier.Coeffs(4, 7).Linear;
featTest(:,25) = LDAclassifier.Coeffs(4, 8).Linear;
featTest(:,26) = LDAclassifier.Coeffs(4, 9).Linear;
featTest(:,27) = LDAclassifier.Coeffs(5, 6).Linear;
featTest(:,28) = LDAclassifier.Coeffs(5, 7).Linear;
featTest(:,29) = LDAclassifier.Coeffs(5, 8).Linear;
featTest(:,30) = LDAclassifier.Coeffs(5, 9).Linear;
featTest(:,31) = LDAclassifier.Coeffs(6, 7).Linear;
featTest(:,32) = LDAclassifier.Coeffs(6, 8).Linear;
featTest(:,33) = LDAclassifier.Coeffs(6, 9).Linear;
featTest(:,34) = LDAclassifier.Coeffs(7, 8).Linear;
featTest(:,35) = LDAclassifier.Coeffs(7, 9).Linear;
featTest(:,36) = LDAclassifier.Coeffs(8, 9).Linear;
featTest = abs(featTest);

featSum = mean(featTest,2);
figure;
bar(featSum)

featSumCopy = featSum;
for i = 1:16
    sensor(i) = mean(featSumCopy(1:5));
    featSumCopy(1:5) = [];
end

figure(); bar(sensor)

[a, b] = sort(sensor);
figure; bar(a)

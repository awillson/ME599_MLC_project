%% Play around with PCA

clear; close all; clc;

%% Import
load crouch_featurized1.mat
load fastWalk_featurized1.mat
load slowWalk_featurized1.mat
load sitting_featurized1.mat
load standing_featurized1.mat

%% Reshape the training data into the same format as in the example code

parfor i = 1:1200
    trainingData(i,:) = reshape(crouch_feat1(:,:,i), 1, 80);
    trainingLabels{i} = 'crouch';
end

parfor i = 1:1200
    trainingData(i+1200,:) = reshape(fastWalk_feat1(:,:,i), 1, 80);
    trainingLabels{i+1200} = 'fastWalk';
end

parfor i = 1:1200
    trainingData(i+2400,:) = reshape(sitting_feat1(:,:,i), 1, 80);
    trainingLabels{i+2400} = 'sitting';
end

parfor i = 1:1200
    trainingData(i+3600,:) = reshape(slowWalk_feat1(:,:,i), 1, 80);
    trainingLabels{i+3600} = 'slowWalk';
end

parfor i = 1:1200
    trainingData(i+4800,:) = reshape(standing_feat1(:,:,i), 1, 80);
    trainingLabels{i+4800} = 'standing';
end

trainingLabels = trainingLabels';

%% Reshape the testing data 

parfor i = 1:1200
    testingData(i,:) = reshape(crouch_feat1(:,:,i+1200), 1, 80);
    testingLabels{i} = 'crouch';
end

parfor i = 1:1200
    testingData(i+1200,:) = reshape(fastWalk_feat1(:,:,i+1200), 1, 80);
    testingLabels{i+1200} = 'fastWalk';
end

parfor i = 1:1200
    testingData(i+2400,:) = reshape(sitting_feat1(:,:,i+1200), 1, 80);
    testingLabels{i+2400} = 'sitting';
end

parfor i = 1:1200
    testingData(i+3600,:) = reshape(slowWalk_feat1(:,:,i+1200), 1, 80);
    testingLabels{i+3600} = 'slowWalk';
end

parfor i = 1:1200
    testingData(i+4800,:) = reshape(standing_feat1(:,:,i+1200), 1, 80);
    testingLabels{i+4800} = 'standing';
end

testingLabels = testingLabels';

%% Now break things up by feature

meanData = testingData(:,1:5:end);
zCrossData = testingData(:,2:5:end);
varData = testingData(:,3:5:end);
sChangeData = testingData(:,4:5:end);
wavlData = testingData(:,5:5:end);

%% SVD all of the things

[u1, s1, v1] = svd(meanData,'econ');
[u2, s2, v2] = svd(zCrossData);
[u3, s3, v3] = svd(varData);
[u4, s4, v4] = svd(sChangeData);
[u5, s5, v5] = svd(wavlData);

%% Look at powers
sensors = 1:16;
meanTotPow = 0;
zCrossTotPow = 0;
varTotPow = 0;
sChangeTotPow = 0;
wavlTotPow = 0;
parfor i = 1:16
    meanPCs(i) = s1(i,i);
    meanTotPow = meanTotPow + meanPCs(i);
    zCrossPCs(i) = s2(i,i);
    zCrossTotPow = zCrossTotPow + zCrossPCs(i);
    varPCs(i) = s3(i,i);
    varTotPow = varTotPow + varPCs(i);
    sChangePCs(i) = s4(i,i);
    sChangeTotPow = sChangeTotPow + sChangePCs(i);
    wavlPCs(i) = s5(i,i);
    wavlTotPow = wavlTotPow + wavlPCs(i);
end

meanCumPow = cumsum(meanPCs)./meanTotPow;
zCrossCumPow = cumsum(zCrossPCs)./zCrossTotPow;
varCumPow = cumsum(varPCs)./varTotPow;
sChangeCumPow = cumsum(sChangePCs)./sChangeTotPow;
wavlCumPow = cumsum(wavlPCs)./wavlTotPow;

figure; 
plot(sensors, meanCumPow,'-o'); 
hold on
grid on
plot(sensors, zCrossCumPow,'-o'); 
plot(sensors, varCumPow,'-o'); 
plot(sensors, sChangeCumPow,'-o'); 
plot(sensors, wavlCumPow,'-o');
legend('mean', 'zeroCross','variance','slopeChange','wavelength','Location','Best')
xlabel('Number of Basis Vectors')
ylabel('Cumulative Sum Over Total Sum of Principal Components')
axis([0 16 0 1])

%%

figure, hold on
for i=1:size(meanData,1)
x = v4(:,1)'*sChangeData(i,:)';
y = v4(:,2)'*sChangeData(i,:)';
z = v4(:,3)'*sChangeData(i,:)';
    if strcmp(trainingLabels(i),'crouch')
        plot3(x,y,z,'rx','LineWidth',2);
    elseif strcmp(trainingLabels(i),'fastWalk')
        plot3(x,y,z,'bo','LineWidth',2);
    elseif strcmp(trainingLabels(i),'sitting')
        plot3(x,y,z,'go','LineWidth',2);
    elseif strcmp(trainingLabels(i),'standing')
        plot3(x,y,z,'yo','LineWidth',2);
    elseif strcmp(trainingLabels(i),'slowWalk')
        plot3(x,y,z,'mo','LineWidth',2);
    end
end
view(85,25), grid on, set(gca,'FontSize',13)

% % PCA example from Brunton's book
% 
% 
% % Load data
% 
% load ovariancancer;
% 
% % Do SVD
% 
% [U, S, V] = svd(obs,'econ');
% 
% % Plot stuff
% 
% figure;
% subplot(1,2,1)
% semilogy(diag(S),'k-o','LineWidth',1.5)
% set(gca,'FontSize',13), axis tight, grid on
% subplot(1,2,2)
% plot(cumsum(diag(S))./sum(diag(S)),'k-o','LineWidth',1.5)
% set(gca,'FontSize',13), axis tight, grid on
% set(gcf,'Position',[100 100 600 250])
% 
% figure, hold on
% for i=1:size(obs,1)
% x = V(:,1)'*obs(i,:)';
% y = V(:,2)'*obs(i,:)';
% z = V(:,3)'*obs(i,:)';
% if(grp{i}=='Cancer')
% plot3(x,y,z,'rx','LineWidth',2);
% else
% plot3(x,y,z,'bo','LineWidth',2);
% end
% end
% view(85,25), grid on, set(gca,'FontSize',13)
% 
% 
% 
% 
% 

% make sensor reduction plots

clear; close all; clc;

%%

load sensorReductionResultsANN.mat
load sensorReductionResultsLDA.mat
load sensorReductionResultsSVM.mat
load sensorReductionResultsForest.mat

%%

sensorAccuracyPlotANN = [sensorAccuracyPlotANN, 0.949];
sensorAccuracyPlotLDA = [sensorAccuracyPlotLDA, 0.9657];
sensorAccuracyPlotSVM = [sensorAccuracyPlotSVM, 0.9800];
sensorAccuracyPlotForest = [sensorAccuracyPlotForest, 0.992];


arbitraryLine = zeros(size(sensorAccuracyPlotANN))+0.9;


plot(sensorAccuracyPlotANN,'-o','Linewidth',2)
hold on
plot(sensorAccuracyPlotLDA,'-o','Linewidth',2)
plot(sensorAccuracyPlotSVM,'-o','Linewidth',2)
plot(sensorAccuracyPlotForest,'-o','Linewidth',2)
plot(arbitraryLine,'k--')
xlabel('Number of Sensors')
ylabel('Classification Accuracy')
axis([1 16 0.5 1])
legend('ANN','LDA','SVM','Forest')
grid on


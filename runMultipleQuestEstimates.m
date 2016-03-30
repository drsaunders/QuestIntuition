function finalVals = runMultipleQuestEstimates(tActual, q, upperLimitUnlog, lowerLimitUnlog, numTrials, numRuns)
% runMultipleQuestEstimates(tActual, q, upperLimitUnlog, lowerLimitUnlog, numTrials, numRuns)
%
% Run a simulated QUEST procedure over and over, and graph the resulting
% threshold estimates.
%
% INPUT
%  tActual             The real threshold that will generate the correct and incorrect
%                      responses
%  q                   Parameters of the QUEST procedure
%  upperLimitUnlog, 
%   lowerLimitUnlog    The upper and lower limits of the possible thresholds
%  numTrials           The number of trials for each estimate
%  numRuns             The number of simulations to run
%
% OUTPUT
%  finalVals           Array of all of the thresholds obtained, length numRuns

totalNumAtFloor = 0;
finalVals = [];

% Initialize progress bar
h = waitbar(0,'Running QUEST simulations...');
for i = 1:numRuns
    % Show updated progress bar
    waitbar(i/numRuns,h)
    
    [intensities finalVal numAtFloor] = simulateQuestRun(tActual, upperLimitUnlog, lowerLimitUnlog, q, numTrials);
    
    finalVals = [finalVals finalVal];
    totalNumAtFloor = totalNumAtFloor + numAtFloor;
end
close(h)
watchoff
figure; 
hist(finalVals); 
title([num2str(numRuns) ' runs of ' num2str(numTrials) ' trials. Mean: ' num2str(mean(finalVals)) '  SD: ' num2str(std(finalVals)) '   Mean trials at floor: ' sprintf('%.1f',totalNumAtFloor/numRuns)]);%'  SD/mean: ' num2str(std(finalVals)/mean(finalVals))]);
xlabel('Final estimate of threshold');
ylabel('Frequency')

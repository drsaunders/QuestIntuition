function finalVals = runMultipleQuestEstimates(tActual, q, upperLimitUnlog, lowerLimitUnlog, numTrials, numRuns)

totalNumAtFloor = 0;
finalVals = [];
h = waitbar(0,'Running QUEST simulations...');
for i = 1:numRuns
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

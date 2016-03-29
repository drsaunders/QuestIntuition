function plotQuestRun(intensities, finalVal)

% Plot the trials
figure;  
plot(intensities,'.-'); 
axis tight;
xlabel('Trial');
ylabel('Test level');
title(['Final threshold computation: ' num2str(finalVal)]);

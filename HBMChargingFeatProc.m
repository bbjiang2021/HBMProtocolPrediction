clear; close all; clc

% load batch data

batch_combined = [batch1, batch2, batch8, batch9]; 
numBat = numBat1 + numBat2 + numBat8 + numBat9;

clearvars -except batch_combined batch1 batch2 batch8 batch9 numBat1 numBat2 numBat8 numBat9 numBat

%%
%extract the number of cycles to 0.88
bat_label = zeros(numBat,1);
for i = 1:numBat
    
    if batch_combined(i).summary.QDischarge(end) < 0.88
        bat_label(i) = find(batch_combined(i).summary.QDischarge < 0.88,1);
        
    else
        bat_label(i) = size(batch_combined(i).cycles,2) + 1;
    end
    
end

max_Q = log10(1200);
min_Q = log10(500);

bat_label = log10(bat_label);

colormap('jet')
CM = colormap('jet');

%% specify font size
fs = 11;


%% 
figure()
color_ind = ceil((bat_label(1) - min_Q)./(max_Q - min_Q)*64);
plot(batch_combined(1).summary.QDischarge,'.','MarkerSize',8,'Color',CM(color_ind,:))
for i = numBat:-1:1%:numBat
    hold on
    if i == 1
        %skip
     
    elseif length(batch_combined(i).summary.QDischarge) < 200
        color_ind = ceil((bat_label(i) - min_Q)./(max_Q - min_Q)*64);
        plot(batch_combined(i).summary.QDischarge,'.','MarkerSize',8,'Color',CM(color_ind,:))
    elseif any(abs(diff(batch_combined(i).summary.QDischarge(200:275))) > 1e-2)
        color_ind = ceil((bat_label(i) - min_Q)./(max_Q - min_Q)*64);
        p_ind = [2:246,252:length(batch_combined(i).summary.QDischarge)];
        plot(p_ind,batch_combined(i).summary.QDischarge(p_ind),'.','MarkerSize',8,'Color',CM(color_ind,:))
    else
        color_ind = ceil((bat_label(i) - min_Q)./(max_Q - min_Q)*64);
        plot(batch_combined(i).summary.QDischarge,'.','MarkerSize',8,'Color',CM(color_ind,:))
    end
    xlim([0,1000])
    ylim([0.88,1.1])
    xlabel({'Cycle Number'})
    ylabel('Discharge Capacity (Ah)')
    box on
    set(gca,'fontsize',fs)
end
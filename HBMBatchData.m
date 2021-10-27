clear; close all; clc
   
load('...\Batch_data\2017-05-12_batchdata_updated_struct_errorcorrect.mat')  %batch1
batch1 = batch;
numBat1 = size(batch1,2);
clearvars batch

% load('...\Batch_data\2017-06-30_batchdata_updated_struct_errorcorrect.mat')  %batch2
% batch2 = batch;
% numBat2 = size(batch2,2);
% clearvars batch

% load('...\Batch_data\2017-12-04_batchdata_updated_struct.mat')  %batch4
% batch4 = batch;
% numBat4 = size(batch4,2);
% clearvars batch

% load('...\Batch_data\2018-01-18_batchdata_updated_struct.mat')  %batch5
% batch5 = batch;
% numBat5 = size(batch5,2);
% clearvars batch

% load('...\Batch_data\2018-02-01_batchdata_updated_struct_errorcorrect.mat')  %batch6    
% batch6 = batch;
% numBat6 = size(batch6,2);
% clearvars batchbatch7 = batch;

% load('...\Batch_data\2018-02-20_batchdata_updated_struct_errorcorrect.mat')  %batch7    
% batch7 = batch;
% nind = [23:24,36:47]; 
% batch7(nind) = [];
% numBat7 = size(batch7,2);
% clearvars batch


% load('...\Batch_data\2018-04-12_batchdata_updated_struct_errorcorrect.mat')%batch8    
% batch8 = batch;
% numBat8 = size(batch8,2);
% endcap8 = zeros(numBat8,1);
% clearvars batch
% for i = 1:numBat8
%     endcap8(i) = batch8(i).summary.QDischarge(end);
% end
% rind = find(endcap8 > 0.885);
% batch8(rind) = [];

% batch_combined = [batch1, batch2, batch8, batch9]; 
% numBat = numBat1 + numBat2 + numBat8;

%% Plot
bat_label = zeros(numBat,1);
for i = 1:numBat
    
    if batch_combined(i).summary.QDischarge(end) < 0.88
        bat_label(i) = find(batch_combined(i).summary.QDischarge < 0.88,1);
        
    else
        bat_label(i) = size(batch_combined(i).cycles,2) + 1;
    end
    
end

figure()
hold on
for i = 1:numBat
    plot(batch_combined(i).summary.QDischarge,'.-')
    plot(bat_label(i),0.88,'kx')
end
xlabel('Cycle Number')
ylabel('Discharge Capacity (Ah)')
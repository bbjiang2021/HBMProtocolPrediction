function [deltaVc, Qclin] = HBMChargingFeatProc(batch,batteryNum,cycleList)

mod_policy = batteryNum;
list = cycleList;

for i = 1:2
cycle = list(i);
Qc_beg = 0;
Qc_end(i) = max(batch(mod_policy).cycles(cycle).Qc);
ind_first = find(batch(mod_policy).cycles(cycle).Qc>(Qc_beg+1e-2),1,'first');
ind_last  = find(batch(mod_policy).cycles(cycle).Qc>(min(Qc_end(i),1.1)-1e-3),1,'first'); 
Q_exp{i} = batch(mod_policy).cycles(cycle).Qc(ind_first:ind_last);
V_exp{i} = batch(mod_policy).cycles(cycle).V(ind_first:ind_last);
[Q_exp_unique{i}, ia, ic] = unique(Q_exp{i});
V_exp_unique{i} = V_exp{i}(ia);
end
Q_exp_int = linspace(0,min(max(Qc_end),1.1),1e4);

for i = 1:2
V_exp_int{i} = interp1(Q_exp_unique{i},V_exp_unique{i},Q_exp_int,'linear','extrap');
end

% dVdQ filter 1
for i = 1:2
    temp_dVdQ = dVdQ{i};
    for j = 2:length(temp_dVdQ)
        if abs(temp_dVdQ(j)/temp_dVdQ(j-1))>10
            temp_dVdQ(j) = temp_dVdQ(j-1);
        end
    end
    dVdQ_proc{i} = temp_dVdQ;
end
% dQdV filter 2
for i = 1:2
    temp_dQdV = dQdV{i};
    for j = 2:length(temp_dQdV)
        if abs(temp_dQdV(j)/temp_dQdV(j-1))>10
            temp_dQdV(j) = temp_dQdV(j-1);
        end
    end
    dQdV_proc{i} = temp_dQdV;
end

deltaVc = V_exp_int{2}-V_exp_int{1};
Qclin = Q_exp_int;

end










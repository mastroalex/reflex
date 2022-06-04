%load result.mat
file_struct=dir('*.mat');
VAR={};
for i=1:length(file_struct)
load(file_struct(i).name) 
data{i}.Time=stretch_reflex_result.Time;
data{i}.Gain=mode(stretch_reflex_result.Data(:,1));
data{i}.input=stretch_reflex_result.Data(:,2);
data{i}.response=stretch_reflex_result.Data(:,3);
data{i}.Td=mode(stretch_reflex_result.Data(:,4));
data{i}.margin=mode(stretch_reflex_result.Data(:,5));
clear stretch_reflex_result
end

%%
scale_factor=1/50;
Y_Lim=[-0.2,0.6];
for i=1:length(file_struct)
figure;
plot(data{i}.Time,data{i}.input*scale_factor,'--')
hold on
plot(data{i}.Time,data{i}.response)
strTitle=strcat('\beta: ',num2str(data{i}.Gain),' [Nms] (',num2str(data{i}.margin,2),')',', Td: ',num2str(data{i}.Td), ' [s]');
title(strTitle)
ylim(Y_Lim)
end

%%


% index to extract data
gain_index=1;
step_index=2;
response_index=3;
gain=max(stretch_reflex_result.Data(:,gain_index));

% normalize step to better fit plot 
% use step graph only to see initial point
step_value=1.1*stretch_reflex_result.Data(:,step_index)/(max(stretch_reflex_result.Data(:,step_index))/max(stretch_reflex_result.Data(:,response_index)));
figure;
plot(stretch_reflex_result.Time,step_value,'--')
hold on
plot(stretch_reflex_result.Time,stretch_reflex_result.Data(:,response_index))
title(['Stretch reflex response with gain of ', '\beta = ',num2str(gain)])
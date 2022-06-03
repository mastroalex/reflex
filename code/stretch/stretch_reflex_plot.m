load result.mat
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
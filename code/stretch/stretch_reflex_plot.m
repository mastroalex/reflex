% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Mastrofini Alessandro
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Medical Engineering - University of Rome Tor Vergata
% Physiological Systems Modeling and Simulation
% F. Caselli, MSSF A.Y. 2021/2022
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Physiological reflex control systems
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% load results
clear all
close all
%load result.mat

% to plot results with gain variablity
%file_struct=dir('results/*Td_0.02.mat');

% to plot result with Td variability
%file_struct=dir('results/result_gain_100_*.mat');

% to plot all the results
file_struct=dir('results/*.mat');

% load all the files in data{} structure with different fields
VAR={};
for i=1:length(file_struct)
    load(strcat('results/',file_struct(i).name))
    data{i}.Time=stretch_reflex_result.Time;
    % use mode() function to avoid numerical error
    % this data have to be consant)
    data{i}.Gain=mode(stretch_reflex_result.Data(:,1));
    data{i}.input=stretch_reflex_result.Data(:,2);
    data{i}.response=stretch_reflex_result.Data(:,3);
    data{i}.Td=mode(stretch_reflex_result.Data(:,4));
    data{i}.margin=mode(stretch_reflex_result.Data(:,5));
    % save the name of the file to export corresponding figs
    data{i}.Name=erase(file_struct(i).name,'.mat');
    clear stretch_reflex_result
end

%%
close all
% set a scale factor to plot the input step without cover response
scale_factor=1/50;
% set limits for plot axes
Y_Lim=[-0.2,0.6];
for i=1:length(file_struct)
    figure;
    % plot input
    plot(data{i}.Time,data{i}.input*scale_factor,'--')
    hold on
    % plot system response
    plot(data{i}.Time,data{i}.response)
    strTitle=strcat('\beta: ',num2str(data{i}.Gain),' (Limit: ',num2str(data{i}.margin,5),')',', Td: ',num2str(data{i}.Td,2), ' [s]');
    % title with data info
    title(strTitle)
    ylim(Y_Lim)
    xlabel('time [s]')
    ylabel('\theta [rad]')
end

%% export figs
path='figs/';
% save figs to pdf with same name of results file
for i=1:length(file_struct)
    exportgraphics(figure(i),strcat(path,data{i}.Name,'.pdf'),'BackgroundColor','none','ContentType','vector');
end

%% compare different gain
close all
figure;
hold on
legend_string=['Input step'];
plot(data{1}.Time,data{1}.input*scale_factor,'--')
for i=1:length(file_struct)
    % load results where gain has been changed 
    % i.e. where Td remain default
    if contains(data{i}.Name,'Td_0.02')
        plot(data{i}.Time,data{i}.response)
        % update legend
        legend_string=[legend_string strcat('Gain: '," ",string(data{i}.Gain))]
    end
    pause(0.2)
end
legend(legend_string,'Location','northwest');
ylim(Y_Lim)
xlabel('time [s]')
ylabel('\theta [rad]')
% save figs
exportgraphics(figure(1),strcat(path,'gainPlot.pdf'),'BackgroundColor','none','ContentType','vector');

%% compare different Td
close all
figure;
hold on
legend_string=['Input step'];
plot(data{1}.Time,data{1}.input*scale_factor,'--')
for i=1:length(file_struct)
    % load results where Td has been changed 
    % i.e. where gain remain default
    if contains(data{i}.Name,'gain_100')
        plot(data{i}.Time,data{i}.response)
        % update legend
        legend_string=[legend_string strcat('Td: '," ",string(data{i}.Td),' , Gain limit: '," ",num2str(data{i}.margin,4))]
    end
    pause(0.2)
end
legend(legend_string,'Location','southwest');
ylim([-0.7, 0.8])
xlabel('time [s]')
ylabel('\theta [rad]')
% save figs
exportgraphics(figure(1),strcat(path,'TdPlot.pdf'),'BackgroundColor','none','ContentType','vector');

% load results
close all
clear all
file_struct=dir('results/*.mat');

% load all the files in data{} structure with different fields
VAR={};
for i=1:length(file_struct)
    temp_var=load(strcat('results/',file_struct(i).name))
    data{i}.Time=temp_var.ans.Time;
    % use mode() function to avoid numerical error
    % this data have to be consant)
    data{i}.Gain=mode(temp_var.ans.Data(:,3));
    data{i}.input=temp_var.ans.Data(:,1);
    data{i}.response=temp_var.ans.Data(:,2);
    % save the name of the file to export corresponding figs
    data{i}.Name=erase(file_struct(i).name,'.mat');
    clear stretch_reflex_result
    clear temp_var
end

%%
close all
% set a scale factor to plot the input step without cover response
scale_factor=1;
% set limits for plot axes
Y_Lim=[-1,1];
for i=1:length(file_struct)
    figure;
    % plot input
    plot(data{i}.Time,data{i}.input*scale_factor,'--')
    hold on
    % plot system response
    plot(data{i}.Time,data{i}.response)
    strTitle=strcat('K: ',num2str(data{i}.Gain,3));
    % title with data info
    title(strTitle)
    %ylim(Y_Lim)
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
legend_string=['Input'];
Y_Lim=[-2,3];
scale_factor=0.8;
plot(data{1}.Time,data{1}.input*scale_factor,'--')
for i=1:length(file_struct)
    % load specifics results
    if contains(data{i}.Name,'_0.16')||contains(data{i}.Name,'_1.0')||contains(data{i}.Name,'_1.8')||contains(data{i}.Name,'_2')
        plot(data{i}.Time,data{i}.response)
        % update legend
        legend_string=[legend_string strcat('Gain: '," ",num2str(data{i}.Gain,3))]
    end
    pause(0.2)
end
legend(legend_string,'Location','southwest');
ylim(Y_Lim)
% save figs
exportgraphics(figure(1),strcat(path,'gainPlot.pdf'),'BackgroundColor','none','ContentType','vector');

%% frequency

for i=1:length(file_struct)
    %figure;
    %plot(data{i}.Time,data{i}.response)
    [pks,locs]=findpeaks(data{i}.response);
    figure;
    plot(data{i}.Time,data{i}.response,data{i}.Time(locs),pks,'or')
    cycles = diff(locs);
    meanCycle = mean(cycles);
    dt=10/length(data{i}.Time);
    period=meanCycle*dt;
    f(i)=1/period;
end
disp(f)
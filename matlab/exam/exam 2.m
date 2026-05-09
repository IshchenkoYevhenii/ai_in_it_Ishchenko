%% =====================================================================
%  Klasteryzatsiia metodamy Fuzzy C-Means (FCM)
%  =====================================================================

clc; clear; close all;

%% --- 1. Heneratsiia danykh -----------------------------------------
rng(42);

group1 = [randn(50,1)*0.5 + 2,  randn(50,1)*0.5 + 2];
group2 = [randn(50,1)*0.5 + 6,  randn(50,1)*0.5 + 5];
group3 = [randn(50,1)*0.5 + 4,  randn(50,1)*0.5 + 8];

data = [group1; group2; group3];

%% --- 2. Parametry FCM ----------------------------------------------
numClusters = 3;

fprintf('=== Zapusk FCM klasteryzatsii ===\n');
fprintf('Kilkist klasteriv : %d\n', numClusters);

%% --- 3. Vyklyk fcm() -----------------------------------------------
% BUG 1 FIXED: pidtrymka obokh variantiv syntaksysu
try
    % R2021a+ (Name-Value)
    [centers, U, objFun] = fcm(data, numClusters, ...
        'Exponent',        2.0,  ...
        'MaxNumIteration', 100,  ...
        'MinImprovement',  1e-5, ...
        'Verbose',         false);
    fprintf('Syntaksys R2021a+ (Name-Value)\n\n');
catch
    % R2020b i starshe (options-vector, 4-y element=0 vymykaye vyvid)
    options = [2.0, 100, 1e-5, 0];
    [centers, U, objFun] = fcm(data, numClusters, options);
    fprintf('Zastarii syntaksys (options-vector)\n\n');
end

%% --- 4. Zhorstkyi rozpodil klasteriv --------------------------------
% BUG 3 FIXED: yavno vkazano dim=1 dlya max
[~, clusterIdx] = max(U, [], 1);

%% --- 5. Vyvid u konsol ----------------------------------------------
fprintf('\n=== Tsentry klasteriv ===\n');
fprintf('%-10s %-14s %-14s\n', 'Klaster', 'X (oznaka 1)', 'Y (oznaka 2)');
fprintf('%s\n', repmat('-',1,38));
for k = 1:numClusters
    fprintf('%-10d %-14.4f %-14.4f\n', k, centers(k,1), centers(k,2));
end
fprintf('\nTsilova funktsiia (ostannia iteratsiia): %.6f\n', objFun(end));
fprintf('Vsioho iteratsii vykonano               : %d\n\n', numel(objFun));

%% --- 6. Hrafiky -----------------------------------------------------
colors  = {'#1a73e8','#e8290b','#1e8e3e'};
markers = {'o','s','^'};

figure('Name','FCM Rezultaty klasteryzatsii', ...
       'NumberTitle','off','Color','white', ...
       'Units','pixels','Position',[100 100 1200 500]);

% ---- 6a. Rozpodil tochok --------------------------------------------
subplot(1,2,1); hold on; grid on;

for k = 1:numClusters
    idx = (clusterIdx == k);
    scatter(data(idx,1), data(idx,2), 40, ...
            'Marker',          markers{k}, ...
            'MarkerFaceColor', colors{k},  ...
            'MarkerEdgeColor', 'none',     ...
            'DisplayName',     sprintf('Klaster %d', k));
end

scatter(centers(:,1), centers(:,2), 200, 'k', 'p', ...
        'MarkerFaceColor','yellow','MarkerEdgeColor','k', ...
        'LineWidth',1.5,'DisplayName','Tsentry klasteriv');

theta = linspace(0, 2*pi, 200);
for k = 1:numClusters
    idx = (clusterIdx == k);
    r   = mean(sqrt(sum((data(idx,:) - centers(k,:)).^2, 2)));
    plot(centers(k,1) + r*cos(theta), ...
         centers(k,2) + r*sin(theta), ...
         '--','Color',colors{k},'LineWidth',1.2,'HandleVisibility','off');
end

xlabel('Oznaka 1'); ylabel('Oznaka 2');
title('Fuzzy C-Means: rozpodil za klasteramy');
legend('Location','best','FontSize',9);
hold off;

% ---- 6b. Zbizhnisnist tsilioi funktsii ------------------------------
subplot(1,2,2); hold on; grid on;

iters = 1:numel(objFun);
area(iters, objFun, 'FaceColor','#d2e3fc','EdgeColor','none');
plot(iters, objFun, '-o', ...
     'Color','#1a73e8','LineWidth',2, ...
     'MarkerFaceColor','white', ...
     'MarkerEdgeColor','#1a73e8','MarkerSize',5);

[minVal, minIt] = min(objFun);
plot(minIt, minVal, 'r*', 'MarkerSize',14, 'LineWidth',2, ...
     'DisplayName', sprintf('Min: %.4f (iter %d)', minVal, minIt));

xlabel('Iteratsiia'); ylabel('Znachennia tsilioi funktsii J');
title('Zbizhnisnist alhorytmu FCM');
legend('Location','best','FontSize',9);
hold off;

if ~verLessThan('matlab','9.5')
    sgtitle('Klasteryzatsiia Fuzzy C-Means', ...
            'FontSize',13,'FontWeight','bold');
end
drawnow;

%% --- 7. Matrytsia nalezhnostei (pershi 10 tochok) ------------------
% BUG 2 FIXED: pryamyi fprintf zamist konkatenatsii riadkiv
fprintf('\n=== Matrytsia U (pershi 10 tochok) ===\n');
fprintf('%-8s', 'Tochka');
for k = 1:numClusters
    fprintf('  Klaster%d', k);
end
fprintf('\n%s\n', repmat('-', 1, 8 + 11*numClusters));
for i = 1:10
    fprintf('%-8d', i);
    fprintf('  %9.4f', U(:, i));
    fprintf('\n');
end

fprintf('\n=== Hotovo! ===\n');

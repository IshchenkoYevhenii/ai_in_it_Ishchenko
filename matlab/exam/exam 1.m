%% =====================================================================
%  Nabir sigmoidnykh funktsii — Fuzzy Logic
%  1) Odnostoronna (vidkryta zliva / sprava)
%  2) Dvostoronna symetrychna
%  3) Nesymetrychna
%  =====================================================================

clc; clear; close all;

x = linspace(-10, 10, 1000);

hasSgtitle = ~verLessThan('matlab','9.5');

colors6 = {'#1a73e8','#e8290b','#1e8e3e','#f29900','#9334e6'};

%% --- FIGURE 1: Odnostoronna sigmf -----------------------------------
figure('Name','Fig1 Odnostoronna sigmf', ...
       'NumberTitle','off','Color','white', ...
       'Units','pixels','Position',[50 300 820 460]);

subplot(1,2,1); hold on; grid on;
params_r = {[0.5,0],[1.0,0],[2.0,0],[1.0,-3],[1.0,3]};
labels_r = {'a=0.5,c=0','a=1.0,c=0','a=2.0,c=0','a=1.0,c=-3','a=1.0,c=3'};
for i = 1:numel(params_r)
    plot(x, sigmf(x, params_r{i}), 'LineWidth',2, ...
         'Color',colors6{i}, 'DisplayName',labels_r{i});
end
yline(0.5,'--k','LineWidth',0.8,'HandleVisibility','off');
xlabel('x'); ylabel('f(x)');
title('Vidkryta sprava  (a > 0)','FontWeight','normal');
legend('Location','southeast','FontSize',8);
ylim([-0.05, 1.05]); hold off;

subplot(1,2,2); hold on; grid on;
params_l = {[-0.5,0],[-1.0,0],[-2.0,0],[-1.0,-3],[-1.0,3]};
labels_l = {'a=-0.5,c=0','a=-1.0,c=0','a=-2.0,c=0','a=-1.0,c=-3','a=-1.0,c=3'};
for i = 1:numel(params_l)
    plot(x, sigmf(x, params_l{i}), 'LineWidth',2, ...
         'Color',colors6{i}, 'DisplayName',labels_l{i});
end
yline(0.5,'--k','LineWidth',0.8,'HandleVisibility','off');
xlabel('x'); ylabel('f(x)');
title('Vidkryta zliva  (a < 0)','FontWeight','normal');
legend('Location','southwest','FontSize',8);
ylim([-0.05, 1.05]); hold off;

if hasSgtitle
    sgtitle('Odnostoronna sigmoidna funktsiia  sigmf(x,[a c])', ...
            'FontSize',12,'FontWeight','bold');
end
drawnow;

%% --- FIGURE 2: Dvostoronna symetrychna ------------------------------
figure('Name','Fig2 Dvostoronna sigmf', ...
       'NumberTitle','off','Color','white', ...
       'Units','pixels','Position',[50 50 1100 440]);

subplot(1,3,1); hold on; grid on;
combos = {[5,-4,5,4],[2,-5,2,5],[1,-3,1,3],[3,-2,3,2]};
lbls   = {'a=5,c=+-4','a=2,c=+-5','a=1,c=+-3','a=3,c=+-2'};
for i = 1:numel(combos)
    plot(x, dsigmf(x, combos{i}), 'LineWidth',2, ...
         'Color',colors6{i}, 'DisplayName',lbls{i});
end
xlabel('x'); ylabel('f(x)');
title('dsigmf: riznytsia sigmoid','FontWeight','normal');
legend('Location','north','FontSize',8);
ylim([-0.1, 1.1]); hold off;

subplot(1,3,2); hold on; grid on;
pi_params = {[-8,-3,3,8],[-6,-2,2,6],[-4,-1,1,4],[-3,0,2,5]};
pi_lbls   = {'[-8,-3,3,8]','[-6,-2,2,6]','[-4,-1,1,4]','[-3,0,2,5]'};
for i = 1:numel(pi_params)
    plot(x, pimf(x, pi_params{i}), 'LineWidth',2, ...
         'Color',colors6{i}, 'DisplayName',pi_lbls{i});
end
xlabel('x'); ylabel('f(x)');
title('pimf: pi-funktsiia','FontWeight','normal');
legend('Location','north','FontSize',8);
ylim([-0.1, 1.1]); hold off;

subplot(1,3,3); hold on; grid on;
smf_p = {[-6,-2],[-5,-1],[-4,0]};
zmf_p = {[2,6],[1,5],[0,4]};
sm_l  = {'smf[-6,-2]','smf[-5,-1]','smf[-4,0]'};
zm_l  = {'zmf[2,6]','zmf[1,5]','zmf[0,4]'};
cs    = {'#1a73e8','#e8290b','#1e8e3e'};
for i = 1:3
    plot(x, smf(x, smf_p{i}), '-',  'LineWidth',2, 'Color',cs{i}, 'DisplayName',sm_l{i});
    plot(x, zmf(x, zmf_p{i}), '--', 'LineWidth',2, 'Color',cs{i}, 'DisplayName',zm_l{i});
end
xlabel('x'); ylabel('f(x)');
title('smf (-) i zmf (--) yak para','FontWeight','normal');
legend('Location','best','FontSize',7.5);
ylim([-0.1, 1.1]); hold off;

if hasSgtitle
    sgtitle('Dvostoronna symetrychna sigmoidna funktsiia', ...
            'FontSize',12,'FontWeight','bold');
end
drawnow;

%% --- FIGURE 3: Nesymetrychna ----------------------------------------
figure('Name','Fig3 Nesymetrychna sigmf', ...
       'NumberTitle','off','Color','white', ...
       'Units','pixels','Position',[200 150 1100 440]);

subplot(1,3,1); hold on; grid on;
ps_combos = {[2,-4,-3,4],[5,-3,-2,3],[1,-5,-1,5],[3,-2,-2,4]};
ps_lbls   = {'a1=2,c1=-4|a2=-3,c2=4','a1=5,c1=-3|a2=-2,c2=3', ...
             'a1=1,c1=-5|a2=-1,c2=5','a1=3,c1=-2|a2=-2,c2=4'};
for i = 1:numel(ps_combos)
    plot(x, psigmf(x, ps_combos{i}), 'LineWidth',2, ...
         'Color',colors6{i}, 'DisplayName',ps_lbls{i});
end
xlabel('x'); ylabel('f(x)');
title('psigmf: dobutok sigmoid','FontWeight','normal');
legend('Location','north','FontSize',7);
ylim([-0.1, 1.1]); hold off;

subplot(1,3,2); hold on; grid on;
asym_p = {[-8,-1,2,5],[-5,-2,1,3],[-6,0,3,4],[-4,-3,2,8]};
asym_l = {'povil.up, shvyd.dn','serednii 1','serednii 2','shvyd.up, povil.dn'};
for i = 1:numel(asym_p)
    p = asym_p{i};
    plot(x, min(smf(x,p(1:2)), zmf(x,p(3:4))), 'LineWidth',2, ...
         'Color',colors6{i}, 'DisplayName',asym_l{i});
end
xlabel('x'); ylabel('f(x)');
title('smf & zmf: nesymetrychne plato','FontWeight','normal');
legend('Location','north','FontSize',8);
ylim([-0.1, 1.1]); hold off;

subplot(1,3,3); hold on; grid on;
ds_combos = {[1,-4,5,4],[5,-4,1,4],[2,-6,8,2],[0.5,-3,3,5]};
ds_lbls   = {'a1=1,a2=5','a1=5,a2=1','a1=2,a2=8','a1=0.5,a2=3'};
for i = 1:numel(ds_combos)
    plot(x, dsigmf(x, ds_combos{i}), 'LineWidth',2, ...
         'Color',colors6{i}, 'DisplayName',ds_lbls{i});
end
xlabel('x'); ylabel('f(x)');
title('dsigmf: rizni a1 vs a2','FontWeight','normal');
legend('Location','north','FontSize',7.5);
ylim([-0.25, 1.1]); hold off;

if hasSgtitle
    sgtitle('Nesymetrychna sigmoidna funktsiia', ...
            'FontSize',12,'FontWeight','bold');
end
drawnow;

%% --- FIGURE 4: Zvedenyi ohliad --------------------------------------
figure('Name','Fig4 Zvedenyi ohliad', ...
       'NumberTitle','off','Color','white', ...
       'Units','pixels','Position',[300 200 900 480]);
hold on; grid on;

plot(x, sigmf(x,  [1.5, 0]),       '-',  'Color','#1a73e8','LineWidth',2.5, ...
     'DisplayName','Odnostoronna prava  sigmf(a>0)');
plot(x, sigmf(x,  [-1.5,0]),       '--', 'Color','#1a73e8','LineWidth',2.5, ...
     'DisplayName','Odnostoronna liva   sigmf(a<0)');
plot(x, dsigmf(x, [4,-4,4,4]),     '-',  'Color','#e8290b','LineWidth',2.5, ...
     'DisplayName','Dvostoronna symetre dsigmf');
plot(x, pimf(x,   [-5,-2,2,5]),    '-',  'Color','#1e8e3e','LineWidth',2.5, ...
     'DisplayName','Dvostoronna pi-f    pimf');
plot(x, psigmf(x, [2,-4,-2,4]),    '-',  'Color','#f29900','LineWidth',2.5, ...
     'DisplayName','Nesymetrychna       psigmf');

xlabel('x'); ylabel('f(x)');
title('Zvedenyi ohliad: osnovni typy sigmoidnykh funktsii', ...
      'FontSize',12,'FontWeight','bold');
legend('Location','east','FontSize',10);
ylim([-0.1, 1.15]);
hold off;
drawnow;

fprintf('=== Pobudovano 4 figury ===\n');
fprintf('  Fig.1 - Odnostoronna sigmf\n');
fprintf('  Fig.2 - Dvostoronna symetrychna\n');
fprintf('  Fig.3 - Nesymetrychna\n');
fprintf('  Fig.4 - Zvedenyi ohliad\n');

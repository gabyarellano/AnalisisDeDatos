function createFitFigure(DayOfYear,EstRad,PredInt,SolRatio)
%createFitFigure Summary of this function goes here

% Copyright 2017 The MathWorks, Inc.

figure
ax(1) = subplot(2,1,1);


stem(DayOfYear,SolRatio-EstRad,'.')

ylabel('Error')
xlabel('Day Of Year')
ylim([-1 1])
xlim([1 365])

ax(2) = subplot(2,1,2);

X = [DayOfYear(1:end-1) DayOfYear(1:end-1) DayOfYear(2:end) DayOfYear(2:end)]';
Y = [PredInt(1:end-1,1) PredInt(1:end-1,2) PredInt(2:end,2) PredInt(2:end,1)]';

patch(X,Y,[1 0.8 0.8],'EdgeColor','none') %'FaceAlpha',0.5)
inside = SolRatio >= PredInt(:,1) & SolRatio <= PredInt(:,2);

hold on
plot(DayOfYear(inside),SolRatio(inside),'k.');
plot(DayOfYear(~inside),SolRatio(~inside),'b.');
plot(DayOfYear,PredInt(:,1),'r');
plot(DayOfYear,PredInt(:,2),'r');
plot(DayOfYear,EstRad,'k');
ylabel('Ratio');
xlabel('Day Of Year');

ylim([0 1]);
xlim([1 365]);
box(ax(2),'on')

linkaxes(ax,'x');

end


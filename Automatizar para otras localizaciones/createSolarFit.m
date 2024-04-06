function [fitresult, gof] = createSolarFit(my_AvgRelHum, my_delT, my_SolRatio)
%CREATEFIT1(MY_AVGRELHUM,MY_DELT,MY_SOLRATIO)
%  Create a fit.
%
%  Data for 'equation' fit:
%      X Input: my_AvgRelHum
%      Y Input: my_delT
%      Z Output: my_SolRatio
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 16-Mar-2023 16:32:04


%% Fit: 'equation'.
[xData, yData, zData] = prepareSurfaceData( my_AvgRelHum, my_delT, my_SolRatio );

% Set up fittype and options.
ft = fittype( 'a*(1+b*RelHum)*(1-exp(-c*delT^n))', 'independent', {'RelHum', 'delT'}, 'dependent', 'z' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.979748378356085 0.438869973126103 0.111119223440599 0.258064695912067];

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, opts );

% Plot fit with data.
figure( 'Name', 'equation' );
h = plot( fitresult, [xData, yData], zData );
legend( h, 'equation', 'my_SolRatio vs. my_AvgRelHum, my_delT', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'my_AvgRelHum', 'Interpreter', 'none' );
ylabel( 'my_delT', 'Interpreter', 'none' );
zlabel( 'my_SolRatio', 'Interpreter', 'none' );
grid on
view( -36.1, 19.6 );



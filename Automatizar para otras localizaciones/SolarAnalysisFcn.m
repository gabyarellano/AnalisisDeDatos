function [DayOfYear_test,EstRad,PredInt,SolRatio_test,model] = SolarAnalysisFcn(filename)

% Predicting Global Solar Radiation
% This demo creates and tests a temperature- and humidity-based model to
% estimate mean daily global solar radiation.  As the sun's radiation
% penetrates the atmosphere, a portion of the radiation is scattered,
% reflected or absorbed. The amount reaching the Earth's surface (either
% directly or through scattering) is known as global solar radiation.
% Maximum daily temperature, minimum daily temperature, and average daily
% humidity are used to estimate the ratio of global solar radiation to
% extraterrestrial radiation (i.e. the ratio between the amount of radiation
% that hits the surface of the Earth and that which hits the top of the
% atmosphere).
%
% One of the motivations of this analysis is for designing photovoltaic
% systems in areas such as developing countries where solar radiation
% measurements are not easily available.  We want a simple and low cost way
% to estimate solar radiation and thus estimate the power that can be
% generated from photovoltaic cells.  These results can also be used to
% determine locations to place more elaborate sensors or as input to climate
% and crop growth models.

% Copyright 2023 The MathWorks, Inc.

% Load Data from Excel File
% Data modified from data taken in Davis, CA from 2001-2010 by the
% California Irrigation Management Information System, Department of Water
% Resources. (http://www.cimis.water.ca.gov/cimis/data.jsp)

% filename = 'DavisDaily.xlsx';

% Function created interactively using the Import Tool
Data = importData(filename);
Data.Year = year(Data.Date);
idx = Data.Year ~= 2006;

Data.delT = Data.MaxAirTemp - Data.MinAirTemp;

my_delT = Data.delT(idx);
my_AvgRelHum = Data.AvgRelHum(idx);
my_SolRatio = Data.SolRatio(idx);
my_DayofYear = Data.DayofYear(idx);

% Function created interactively using Curve Fitting App
[model, ~] = createSolarFit(my_AvgRelHum,my_delT,my_SolRatio);

% Add a label corresponding to filename
[~, name, ~] = fileparts(filename) ;
title(gca,['Fit for ' name]);

disp(model)

EstRad = model(Data.AvgRelHum(~idx),Data.delT(~idx));
myErr = Data.SolRatio(~idx) - EstRad;
PredInt = predint(model,[Data.AvgRelHum(~idx) Data.delT(~idx)]);

DayOfYear_test = Data.DayofYear(~idx);
SolRatio_test = Data.SolRatio(~idx);
%Plot Estimated and Measured Solar Ratio
%createFitFigure(Data.DayofYear(~idx),EstRad,PredInt,Data.SolRatio(~idx));


% Calculate Percent of Points within Estimated Bounds

inside = Data.SolRatio(~idx) >= PredInt(:,1) & Data.SolRatio(~idx) <= PredInt(:,2);
percentFit = (nnz(inside)/length(inside))*100;

fprintf('%5.3f percent of data points were within estimated bounds\n',...
    percentFit);


end


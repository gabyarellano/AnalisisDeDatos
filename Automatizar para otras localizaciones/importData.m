function DavisDaily1 = importData(workbookFile, sheetName, dataLines)
%IMPORTFILE2 Import data from a spreadsheet
%  DAVISDAILY1 = IMPORTFILE2(FILE) reads data from the first worksheet
%  in the Microsoft Excel spreadsheet file named FILE.  Returns the data
%  as a table.
%
%  DAVISDAILY1 = IMPORTFILE2(FILE, SHEET) reads from the specified
%  worksheet.
%
%  DAVISDAILY1 = IMPORTFILE2(FILE, SHEET, DATALINES) reads from the
%  specified worksheet for the specified row interval(s). Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  DavisDaily1 = importfile2("C:\Users\garellan\MathWorks\LATAM Team - Documents\Events 2023\08_Costa Rica trip\08_29 UCR Data Analysis\Radiacion Solar\DavisDaily.xlsx", "DavisDaily", [2, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 29-Aug-2023 10:31:36

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [2, Inf];
end

%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 15);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = dataLines(1, :);

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "Var3", "Date", "DayofYear", "Var6", "Var7", "SolRatio", "Var9", "MaxAirTemp", "MinAirTemp", "Var12", "Var13", "Var14", "AvgRelHum"];
opts.SelectedVariableNames = ["Date", "DayofYear", "SolRatio", "MaxAirTemp", "MinAirTemp", "AvgRelHum"];
opts.VariableTypes = ["char", "char", "char", "datetime", "double", "char", "char", "double", "char", "double", "double", "char", "char", "char", "double"];

% Specify file level properties
opts.ImportErrorRule = "omitrow";
opts.MissingRule = "omitrow";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var6", "Var7", "Var9", "Var12", "Var13", "Var14"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var6", "Var7", "Var9", "Var12", "Var13", "Var14"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, ["DayofYear", "SolRatio", "MaxAirTemp", "MinAirTemp", "AvgRelHum"], "TreatAsMissing", '');

% Import the data
DavisDaily1 = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = dataLines(idx, :);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    DavisDaily1 = [DavisDaily1; tb]; %#ok<AGROW>
end

end
clear all; clc;
warning('off', 'all');

banks = create_sector('Excel/banks.xlsx', {'MS', 'JPM', 'GS', 'BAC', 'C'});
tech = create_sector('Excel/tech.xlsx', {'AAPL', 'EBAY', 'MSFT', 'AMZN', 'INTU'});
semiconductor = create_sector('Excel/semiconductor.xlsx', {'NVDA', 'TXN', 'QCOM', 'MU', 'INTC'});
pharma = create_sector('Excel/pharma.xlsx', {'PFE', 'MRK', 'AGN', 'ENDP', 'PRGO'});
energy = create_sector('Excel/energy.xlsx', {'CHK', 'CVX', 'XON', 'MUR', 'HES'});

macro_file_1 = 'Excel/gdp.xlsx';
macro_file_2 = 'Excel/inflation_rate.xlsx';
macro_file_3 = 'Excel/oil.xlsx';
macro_file_4 = 'Excel/unemployment_rate.xlsx';
macro_file_5 = 'Excel/earnings.xlsx';
macros = create_macro(macro_file_1, macro_file_2, macro_file_3, macro_file_4, macro_file_5,...
    {'gdp', 'inflation', 'oil', 'unemploymemt', 'earnings'});

% Linear Approx
linear_approx(banks);
linear_approx(tech);
linear_approx(semiconductor);
linear_approx(pharma);
linear_approx(energy);

% IID Analysis
for i = 1 : 5
    IIDAnalysis(banks(i).PX_LAST, banks(i).name);
    IIDAnalysis(energy(i).PX_LAST, energy(i).name);
    IIDAnalysis(pharma(i).PX_LAST, pharma(i).name);
    IIDAnalysis(semiconductor(i).PX_LAST, semiconductor(i).name);
    IIDAnalysis(tech(i).PX_LAST, tech(i).name);
end

% Technical Indicators
for i = 1 : 5
    technical_indicator(banks(i));
    technical_indicator(energy(i));
    technical_indicator(pharma(i));
    technical_indicator(semiconductor(i));
    technical_indicator(tech(i));
end
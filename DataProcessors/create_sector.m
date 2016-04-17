function [sector] = create_sector(sectorFileName, symbols)
    for i = 1 : 5
        sector(i) = read_equity(symbols(i), sectorFileName, i);
    end
end

function [EQ] = read_equity(name, fileName, sheetNum)

% meta
sheet = xlsread(fileName, sheetNum);
EQ = Equity();
EQ.name = name;

% props
EQ.DATES = sheet(:, 1);  
EQ.PX_LAST = sheet(:, 2);
EQ.PX_VOLUME = sheet(:, 3);
EQ.DIVIDEND_YIELD  = sheet(:, 4);
EQ.LOW_PX_TO_BOOK_RATIO  = sheet(:, 5);
EQ.PE_RATIO  = sheet(:, 6);
EQ.SALES_GROWTH  = sheet(:, 7);
EQ.EBITDA = sheet(:, 8);
EQ.ASSET_TURNOVER = sheet(:, 9);
EQ.TOT_DEBT_TOTAL_ASSET = sheet(:, 10);
EQ.CF_CAP_EXPEND_PRPTY_ADD = sheet(:, 11);
EQ.REL_SHR_PX_MOMENTUM = sheet(:, 12);
EQ.TOT_MKT_VAL = sheet(:, 13);
EQ.RETURN_COM_EQY = sheet(:, 14);
EQ.PROF_MARGIN = sheet(:, 15);

end

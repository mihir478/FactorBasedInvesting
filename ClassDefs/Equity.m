classdef Equity
    properties
        name % e.g. MS
        DATES % x axis for all qtys
        PX_LAST % closing price
        PX_VOLUME % volume traded
        DIVIDEND_YIELD % dividends per share / price per share
        LOW_PX_TO_BOOK_RATIO % price / (assets - liabilites)
        PE_RATIO % price to earnings ratio
        SALES_GROWTH % amount received from sales
        EBITDA % earnings before interest, taxation, depreciation, amortization 
        ASSET_TURNOVER % sales or revenues  / total assets
        TOT_DEBT_TOTAL_ASSET % debt / assets
        CF_CAP_EXPEND_PRPTY_ADD % cash flow, capital expenditures, property additions
        REL_SHR_PX_MOMENTUM % relative share price momentum
        TOT_MKT_VAL % total market value
        RETURN_COM_EQY % return on common equity
        PROF_MARGIN % profit margin
   end
end

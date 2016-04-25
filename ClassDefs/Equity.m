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
    methods
        function [mom acc rsi movavg proc pvt]= technical_indicator(obj)
            
            plotTechnicalIndicator(obj, tsmom(obj.PX_LAST), 'Momentum');
            plotTechnicalIndicator(obj, tsaccel(obj.PX_LAST), 'Acceleration');
            plotTechnicalIndicator(obj, rsindex(obj.PX_LAST), 'Relative Strength Indicator');
            plotTechnicalIndicator(obj, prcroc(obj.PX_LAST), 'Price Rate of Change');
            plotTechnicalIndicator(obj, pvtrend(obj.PX_LAST, obj.PX_VOLUME), 'Price Volume Trend');
            
            if(sum(isnan(obj.PX_LAST)) == 0)
                movavg = tsmovavg(obj.PX_LAST, 'e', 50, 1);
                [mid upper lower] = bollinger(movavg, 50);
                figure()
                plot([obj.PX_LAST,mid,upper,lower])
                title(strcat(char(obj.name), ':', 'Bollinger Bands of 50D Moving Average'))
                legend({'Price','mid','upper','lower'})
            end
        end
        function plotTechnicalIndicator(obj, vector, titleStr)
            figure()
            plot(vector);
            title(strcat(char(obj.name), ':', titleStr))
        end
    end
end

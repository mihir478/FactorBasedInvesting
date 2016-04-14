clear all;

banks = create_sector('Excel/banks.xlsx', {'MS', 'JPM', 'GS', 'BAC', 'C'})
tech = create_sector('Excel/tech.xlsx', {'AAPL', 'EBAY', 'MSFT', 'AMZN', 'INTU'})
semiconductor = create_sector('Excel/semiconductor.xlsx', {'NVDA', 'TXN', 'QCOM', 'MU', 'INTC'})
pharma = create_sector('Excel/pharma.xlsx', {'PFE', 'MRK', 'AGN', 'ENDP', 'PRGO'})
energy = create_sector('Excel/energy.xlsx', {'CHK', 'CVX', 'XON', 'MUR', 'HES'})

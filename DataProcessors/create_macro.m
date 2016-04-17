function [macros] = create_macro(f1, f2, f3, f4, f5, names)
    
    macros(1) = read_macro(f1, names(1));
    macros(2) = read_macro(f2, names(2));
    macros(3) = read_macro(f3, names(3));
    macros(4) = read_macro(f4, names(4));
    macros(5) = read_macro(f5, names(5));
    
   
end

function [MACRO] = read_macro(fileName, name)

MACRO = Macro();
MACRO.name = name;

% meta
sheet = xlsread(fileName);

% props
MACRO.DATES = sheet(:, 1);  
MACRO.VALUES = sheet(:, 2);

end

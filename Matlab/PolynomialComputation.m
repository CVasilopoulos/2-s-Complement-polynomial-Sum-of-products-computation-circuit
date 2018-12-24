clc
clear variables

% Here we define the parameters, the constants and initialize the matrices
% for calculating the values of the polynomials
int_bits = 2;
fract_bits = 3;
total_bits = int_bits + fract_bits;
MAX = ((2 ^ (total_bits - 1)) - 1) / (2 ^ fract_bits);
MIN = (-2 ^ (total_bits - 1)) / (2 ^ fract_bits);
numbers = 10;
x = zeros(numbers, 1);
x = zeros(numbers, 1);
x_rounded = zeros(numbers, 1);
y_rounded = zeros(numbers, 1);
poly_result = zeros(numbers, 1);

% Here we open files for writting input data
fp1 = fopen('x_poly.txt','w');
fp2 = fopen('y_poly.txt','w');

for j = 1 : numbers
    x(j)  = MIN + (MAX - MIN) * rand();
    y(j)  = MIN + (MAX - MIN) * rand();
    temp0 = fi(x(j), 1, total_bits, fract_bits,'RoundingMethod', 'Floor');
    temp1 = fi(y(j), 1, total_bits, fract_bits,'RoundingMethod', 'Floor');
    % Here we have the inputs x and y rounded
    x_rounded(j) = temp0;
    y_rounded(j) = temp1;
    % Here we write x_rounded and y_rounded in binary form in files
    fprintf(fp1, '%s\n', bin(temp0));
    fprintf(fp2, '%s\n', bin(temp1));
end

% Here we close the files for writting input data 
fclose(fp1);
fclose(fp2);

k = 1;
% Here we open the file for writting results
fp3 = fopen('poly_result.txt','w');

for j = 1 : 2 : numbers        
     temp0 = x_rounded(j) * y_rounded(j); % y = ax
     temp1 = temp0 + x_rounded(j + 1) ;   % y=ax+b
     temp2 = fi(temp1, 1, total_bits, fract_bits,'RoundingMethod', 'Floor');
     temp3 = (temp2 * x_rounded(j)) + y_rounded(j + 1); % y = ax^2 + bx + c
     temp4 = fi(temp3, 1, total_bits, fract_bits,'RoundingMethod', 'Floor');
     poly_result(k) = temp4;
     temp5 = fi(poly_result(k),1, total_bits, fract_bits,...
                                    'RoundingMethod', 'Floor');
     fprintf(fp3,'%s\n', bin(temp5));
     k = k + 1;  
end

fclose(fp3);





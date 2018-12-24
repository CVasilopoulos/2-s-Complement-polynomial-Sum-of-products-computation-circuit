clc; clear variables;

% Here we define the parameters and  the constants for calculating
%  the sum of products
int_bits = 2;
fract_bits = 3;
total_bits = int_bits + fract_bits;
MAX = ((2 ^ (total_bits - 1)) - 1) / (2 ^ fract_bits);
MIN = (-2 ^ (total_bits - 1)) / (2 ^ fract_bits);
numbers = 6;

% Here we open files for writting input data and results
fp1 = fopen('x.txt','w');
fp2 = fopen('y.txt','w');
fp3 = fopen('result.txt', 'w');

sum_rounded = 0;

for j = 1 : numbers  
       x  = MIN + (MAX - MIN) * rand(); 
       y  = MIN + (MAX - MIN) * rand(); 
       temp0 = fi(x, 1, total_bits, fract_bits); 
       temp1 = fi(y, 1, total_bits, fract_bits); 
       % Here we have the inputs x and y rounded
       x_rounded = temp0;
       y_rounded = temp1; 
       % Here we write x_rounded and y_rounded in binary form in files
       fprintf(fp1, '%s\n', bin(temp0));
       fprintf(fp2, '%s\n', bin(temp1));
       % Here we compute the sum of products
       sum_rounded = sum_rounded + (x_rounded * y_rounded);
       if (sum_rounded < -2)
           sum_rounded = -2;
       elseif (sum_rounded > 1.984375)
           sum_rounded = 1.984375;
       else
           sum_rounded = sum_rounded;
       end
       % Here we have the result rounded
       result_rounded = fi(sum_rounded, 1, total_bits,...
                            fract_bits,'RoundingMethod', 'Floor');
       fprintf(fp3, '%s\n', bin(result_rounded));
end

% Here we close the files for writting input data and results
fclose(fp1);
fclose(fp2);
fclose(fp3);







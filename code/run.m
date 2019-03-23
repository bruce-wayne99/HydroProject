clear all;
data = csvread('rainfall.csv',1,3);
col = size(data,1);
narr = [31,28,31,30,31,30,31,31,30,31,30,31];
larr = [31,29,31,30,31,30,31,31,30,31,30,31];
monthly_data = zeros(col,33);
for i = 1:col
    su = 1;
    arr = data(i,:);
    for j = 1:33
      for k = 1:12
        if rem(j,4) == 1
             monthly_data(i,k+(j-1)*12) = sum(arr(1,su:larr(k)+su-1));
             su = su+larr(k);
        else
            monthly_data(i,k+(j-1)*12) = sum(arr(1,su:narr(k)+su-1));
            su = su+narr(k);
        end
      end
    end
end
% an = zeros(22,1);
% for i = 1:22
%   [s,a,Z] =  spi(monthly_data(i,:).',24,12);
%   an(i,1) = s;
%   an(i,2) = a;
%   spi_val(i,:) = Z;
% end
% % sum_spi = sum(spi_val,1);
% % sum_spi = sum_spi/22;
% sum_spi = spi_val(1,:);
% figure
% plot(sum_spi);
% xlabel('Over Years');
% ylabel('SPI');
% figure
% for t = 1:12
%     avg_spi(t) = mean(sum_spi(t:12:size(sum_spi,2)));
% end
% xValues =[1,2,3,4,5,6,7,8,9,10,11,12];
% yValues = avg_spi';
% positiveIndexes = yValues >  0;
% negativeIndexes = yValues <  0;
% bar(xValues(positiveIndexes), yValues(positiveIndexes), 'r', 'BarWidth', 0.48)
% hold on
% bar(xValues(negativeIndexes), yValues(negativeIndexes), 'b', 'BarWidth', 0.48)
% hold off   
    

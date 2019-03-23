function [var] = pics(monthly_data,scale)
    an = zeros(22,1);
    clear spi_val;
    for i = 1:22
      [s,a,Z] =  spi(monthly_data(i,:).',scale,12);
      an(i,1) = s;
      an(i,2) = a;
      spi_val(i,:) = Z; 
    end
    save('spi_24','an');
    for c = 1:22
        sum_spi = spi_val(c,:);
        figure1 = figure;
        plot(sum_spi);
        xlabel('Over Years');
        ylabel('SPI');
        str = char(strcat('station_',string(c),'_','spi','_',string(scale)));
        disp(str);
        saveas(figure1,str,'jpg');
        figure2 = figure;
        avg_spi = zeros(1,12);
        for t = 1:12
            avg_spi(t) = mean(sum_spi(t:12:size(sum_spi,2)));
        end
        xValues =[1,2,3,4,5,6,7,8,9,10,11,12];
        yValues = avg_spi';
        positiveIndexes = yValues >  0;
        negativeIndexes = yValues <  0;
        bar(xValues(positiveIndexes), yValues(positiveIndexes), 'r', 'BarWidth', 0.48)
        hold on
        bar(xValues(negativeIndexes), yValues(negativeIndexes), 'b', 'BarWidth', 0.48)
        hold off
        va = char(strcat('station_',string(c),'_','hist','_',string(scale)));
        saveas(figure2,va,'jpg');
    end
end
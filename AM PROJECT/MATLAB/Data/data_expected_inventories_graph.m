data = load('MATLAB/Data/all_expected_inventories.txt');

Month = data(:,1) + datenum(1970,1,1);   % conversione R Date → MATLAB datenum
Y = data(:,2:4);

figure
plot(Month, Y, 'LineWidth', 1)
grid on
legend('3','6','9')

xlim([datenum(2008,1,1) datenum(2025,9,1)])
set(gca,'XTick', datenum(2008:2025,1,1))
datetick('x','yyyy','keepticks')

ylim([5.6 6.4])
ylabel('log expected inventories')

%% 子函数2：计算两点间距
% 输入：x1、x2:1*2矩阵，分别为待求点x、y坐标
% 输出：y：浮点，x1、x2两点间距
function y=dis(x1,x2)
y=sqrt((x2(1)-x1(1))^2+(x2(2)-x1(2))^2);
end
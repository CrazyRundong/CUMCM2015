%% �����˿��ܶ�����
clear; clc;
%% ��ȡ�������
% ��ȡ�ɶ��е�ͼ����
map_Chengdu=shaperead('D:\File\CUMCM2015\B\��ͼ\�ɶ���shp��ͼ\�ؽ�_region.shp');
% ��ȡ�������������˿�
% ��������Ϊ��γ��	����	���˿�
[~, ~, raw] = xlsread('D:\File\CUMCM2015\B\��ͼ\test\�ɶ�����������_geo_ok.xlsx','OK','B2:D413');
data_pop_loc = reshape([raw{:}],size(raw));
clearvars raw;
X_MIN=min(data_pop_loc(:,2));
X_MAX=max(data_pop_loc(:,2));
Y_MIN=min(data_pop_loc(:,1));
Y_MAX=max(data_pop_loc(:,1));
%% �����˿��ܶ�����
x=linspace(X_MIN,X_MAX,100);
y=linspace(Y_MIN,Y_MAX,100);
pop_grid=zeros(100,100);
for i=1:size(data_pop_loc,1)
    index_x=find(x>data_pop_loc(i,2));
    if isempty(index_x)
        index_x=100;
    elseif index_x(1)~=1
        index_x(1)=index_x(1)-1;
    end
    index_y=find(y>data_pop_loc(i,1));
    if isempty(index_y)
        index_y=100;
    elseif index_y(1)~=1
        index_y(1)=index_y(1)-1;
    end
    pop_grid(index_x(1),index_y(1))=data_pop_loc(i,3);
end
% �����άͼ��
[xx,yy]=meshgrid(x,y);
surf(xx,yy,pop_grid);
shading interp;
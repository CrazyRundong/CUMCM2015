%% ����һ��������
clear; clc;
%% ��ȡ�������
% ��ȡ�ɶ��е�ͼ����
% map_Chengdu=shaperead('D:\File\CUMCM2015\B\��ͼ\�ɶ���shp��ͼ\�ؽ�_region.shp');
% ��ȡ�������������˿�
% ��������Ϊ��γ��	����	���˿�
[~, ~, raw] = xlsread('D:\File\CUMCM2015\B\��ͼ\test\�ɶ�����������_geo_ok.xls','OK','B2:D413');
data_pop_loc = reshape([raw{:}],size(raw));
clearvars raw;
% ��ȡ���⳵������ֲ�����
% ÿСʱ300�����ݵ�
% ����ʱ�䣺15/09/05
% ��������Ϊ���ȡ�γ�ȡ�����
[~, ~, raw] = xlsread('D:\File\CUMCM2015\B\�����ļ�\150905_�ֲ�������.xls','���⳵����','A2:C1626');
data_dem = reshape([raw{:}],size(raw));
clearvars raw;

[~, ~, raw] = xlsread('D:\File\CUMCM2015\B\�����ļ�\150905_�ֲ�������.xls','���⳵�ֲ�','A2:C7225');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); 
raw(R) = {NaN};
data_dist_t = reshape([raw{:}],size(raw));
clearvars raw R;
% ��ȡ��ҵ���ݣ����ȡ�γ��
[~, ~, raw] = xlsread('D:\File\CUMCM2015\B\�����ļ�\120����ҵ.xls','sheet1','B1:C109');
data_co = reshape([raw{:}],size(raw));
clearvars raw;
%% �������ֲ�����
% ����ʵ�ʳ�����������ߴ����˳����Ĺ�ϵ
T_dist=300;
for i=1:24
    data_dist(:,:,i)=[data_dist_t((i-1)*T_dist+1:i*T_dist,[1,2]),...
        data_dist_t((i-1)*T_dist+1:i*T_dist,3)*2];
end
%% �趨����
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
%% ������ҵ�˿��ܶ�����
co_grid=zeros(100,100);
for i=1:size(data_co,1)
    index_x=find(x>data_co(i,1));
    if isempty(index_x)
        index_x=100;
    elseif index_x(1)~=1
        index_x(1)=index_x(1)-1;
    end
    index_y=find(y>data_co(i,2));
    if isempty(index_y)
        index_y=100;
    elseif index_y(1)~=1
        index_y(1)=index_y(1)-1;
    end
    co_grid(index_x(1),index_y(1))=10000+50000*rand(1);
end
%% ����7�㡢9��ʱ���⳵�ֲ�����
% ��������Ϊ���ȡ�γ�ȡ�����
car7_grid=zeros(100,100);
car9_grid=zeros(100,100);
for i=1:size(data_dist(:,:,7),1)
    index7_x=find(x>data_dist(i,1,7));
    if isempty(index7_x)
        index7_x=100;
    elseif index7_x(1)~=1
        index7_x(1)=index7_x(1)-1;
    end
    index7_y=find(y>data_dist(i,2,7));
    if isempty(index7_y)
        index7_y=100;
    elseif index7_y(1)~=1
        index7_y(1)=index7_y(1)-1;
    end
    car7_grid(index7_x(1),index7_y(1))=car7_grid(index7_x(1),index7_y(1))+...
        data_dist(i,3,7);
    
    index9_x=find(x>data_dist(i,1,9));
    if isempty(index9_x)
        index9_x=100;
    elseif index9_x(1)~=1
        index9_x(1)=index9_x(1)-1;
    end
    index9_y=find(y>data_dist(i,2,9));
    if isempty(index9_y)
        index9_y=100;
    elseif index9_y(1)~=1
        index9_y(1)=index9_y(1)-1;
    end
    car9_grid(index9_x(1),index9_y(1))=car9_grid(index9_x(1),index9_y(1))+...
        data_dist(i,3,9);
end
%% ����ʵ������
% ��ʼ״̬����
pop_grid_std2=pop_grid*2.6*0.062*6.2/(0.65*16*23*2);
pop_std2_sum=sum(sum(pop_grid_std2));
% �ϰ��������
co_grid_std2=pop_std2_sum*co_grid/sum(sum(co_grid));
%% �����άͼ��
% �˿��ȶ�
subplot(2,2,1);
[xx,yy]=meshgrid(x,y);
surf(xx,yy,pop_grid_std2);
shading interp;
axis([X_MIN,X_MAX,Y_MIN,Y_MAX]);
% scatterbar(xx,yy,pop_grid);
% �����ֲ�
subplot(2,2,2);
surf(xx,yy,car7_grid);
shading interp;
axis([X_MIN,X_MAX,Y_MIN,Y_MAX]);
% scatterbar(xx,yy,car7_grid);
% 9��ʱ
subplot(2,2,3);
surf(xx,yy,co_grid_std2);
shading interp;
axis([X_MIN,X_MAX,Y_MIN,Y_MAX]);
subplot(2,2,4);
surf(xx,yy,car9_grid);
shading interp;
axis([X_MIN,X_MAX,Y_MIN,Y_MAX]);
%% ���������ϵ��ֻըһ��
% ǿ�в����Ӻ���������������ѽ233333333333
% ����car7_grid   ��pop_grid_std2
% �糿7��
% ��ʼ״̬
fprintf(sprintf('�糿7����⳵��ʼ����������%f��\n',sum(sum(abs(car7_grid)))));
for i=1:100 % ��
    for j=1:100 % ��
        if pop_grid_std2(i,j)
            if i==1 && j==1
                if car7_grid(i,j)>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j);
                elseif (car7_grid(i,j)+car7_grid(i,j+1)+car7_grid(i+1,j))>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-0.5*pop_grid_std2(i,j);
                    car7_grid(i+1,j)=car7_grid(i+1,j)-0.25*pop_grid_std2(i,j);
                    car7_grid(i,j+1)=car7_grid(i,j+1)-0.25*pop_grid_std2(i,j);
                else
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j)/3;
                    car7_grid(i+1,j)=car7_grid(i+1,j)-pop_grid_std2(i,j)/3;
                    car7_grid(i,j+1)=car7_grid(i,j+1)-pop_grid_std2(i,j)/3;
                end
            elseif i==1 && j==100
                if car7_grid(i,j)>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j);
                elseif (car7_grid(i,j)+car7_grid(i,j-1)+car7_grid(i+1,j))>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-0.5*pop_grid_std2(i,j);
                    car7_grid(i+1,j)=car7_grid(i+1,j)-0.25*pop_grid_std2(i,j);
                    car7_grid(i,j-1)=car7_grid(i,j-1)-0.25*pop_grid_std2(i,j);
                else
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j)/3;
                    car7_grid(i+1,j)=car7_grid(i+1,j)-pop_grid_std2(i,j)/3;
                    car7_grid(i,j-1)=car7_grid(i,j-1)-pop_grid_std2(i,j)/3;
                end
            elseif i==100 && j==1
                if car7_grid(i,j)>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j);
                elseif (car7_grid(i,j)+car7_grid(i,j+1)+car7_grid(i-1,j))>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-0.5*pop_grid_std2(i,j);
                    car7_grid(i-1,j)=car7_grid(i-1,j)-0.25*pop_grid_std2(i,j);
                    car7_grid(i,j+1)=car7_grid(i,j+1)-0.25*pop_grid_std2(i,j);
                else
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j)/3;
                    car7_grid(i-1,j)=car7_grid(i-1,j)-pop_grid_std2(i,j)/3;
                    car7_grid(i,j+1)=car7_grid(i,j+1)-pop_grid_std2(i,j)/3;
                end
            elseif i==100 && j==100
                if car7_grid(i,j)>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j);
                elseif (car7_grid(i,j)+car7_grid(i,j-1)+car7_grid(i-1,j))>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-0.5*pop_grid_std2(i,j);
                    car7_grid(i-1,j)=car7_grid(i-1,j)-0.25*pop_grid_std2(i,j);
                    car7_grid(i,j-1)=car7_grid(i,j-1)-0.25*pop_grid_std2(i,j);
                else
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j)/3;
                    car7_grid(i-1,j)=car7_grid(i-1,j)-pop_grid_std2(i,j)/3;
                    car7_grid(i,j-1)=car7_grid(i,j-1)-pop_grid_std2(i,j)/3;
                end
            elseif i==1
                if car7_grid(i,j)>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j);
                elseif (car7_grid(i,j)+car7_grid(i,j-1)+car7_grid(i,j+1)+car7_grid(i+1,j))>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-0.5*pop_grid_std2(i,j);
                    car7_grid(i,j-1)=car7_grid(i,j-1)-0.5*pop_grid_std2(i,j)/3;
                    car7_grid(i,j+1)=car7_grid(i,j+1)-0.5*pop_grid_std2(i,j)/3;
                    car7_grid(i+1,j)=car7_grid(i+1,j)-0.5*pop_grid_std2(i,j)/3;
                else
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j)/4;
                    car7_grid(i,j-1)=car7_grid(i,j-1)-pop_grid_std2(i,j)/4;
                    car7_grid(i+1,j)=car7_grid(i+1,j)-pop_grid_std2(i,j)/4;
                    car7_grid(i,j+1)=car7_grid(i,j+1)-pop_grid_std2(i,j)/4;
                end
            elseif i==100
                if car7_grid(i,j)>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j);
                elseif (car7_grid(i,j)+car7_grid(i,j-1)+car7_grid(i-1,j)+car7_grid(i,j+1))>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-0.5*pop_grid_std2(i,j);
                    car7_grid(i-1,j)=car7_grid(i-1,j)-0.5*pop_grid_std2(i,j)/3;
                    car7_grid(i,j-1)=car7_grid(i,j-1)-0.5*pop_grid_std2(i,j)/3;
                    car7_grid(i,j+1)=car7_grid(i,j+1)-0.5*pop_grid_std2(i,j)/3;
                else
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j)/4;
                    car7_grid(i-1,j)=car7_grid(i-1,j)-pop_grid_std2(i,j)/4;
                    car7_grid(i,j-1)=car7_grid(i,j-1)-pop_grid_std2(i,j)/4;
                    car7_grid(i,j+1)=car7_grid(i,j+1)-pop_grid_std2(i,j)/4;
                end
            elseif j==1
                if car7_grid(i,j)>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j);
                elseif (car7_grid(i,j)+car7_grid(i-1,j)+car7_grid(i,j+1)+car7_grid(i+1,j))>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-0.5*pop_grid_std2(i,j);
                    car7_grid(i-1,j)=car7_grid(i-1,j)-0.5*pop_grid_std2(i,j)/3;
                    car7_grid(i,j+1)=car7_grid(i,j+1)-0.5*pop_grid_std2(i,j)/3;
                    car7_grid(i+1,j)=car7_grid(i+1,j)-0.5*pop_grid_std2(i,j)/3;
                else
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j)/4;
                    car7_grid(i-1,j)=car7_grid(i-1,j)-pop_grid_std2(i,j)/4;
                    car7_grid(i+1,j)=car7_grid(i+1,j)-pop_grid_std2(i,j)/4;
                    car7_grid(i,j+1)=car7_grid(i,j+1)-pop_grid_std2(i,j)/4;
                end
            elseif j==100
                if car7_grid(i,j)>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j);
                elseif (car7_grid(i,j)+car7_grid(i,j-1)+car7_grid(i-1,j)+car7_grid(i+1,j))>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-0.5*pop_grid_std2(i,j);
                    car7_grid(i-1,j)=car7_grid(i-1,j)-0.5*pop_grid_std2(i,j)/3;
                    car7_grid(i,j-1)=car7_grid(i,j-1)-0.5*pop_grid_std2(i,j)/3;
                    car7_grid(i+1,j)=car7_grid(i+1,j)-0.5*pop_grid_std2(i,j)/3;
                else
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j)/4;
                    car7_grid(i-1,j)=car7_grid(i-1,j)-pop_grid_std2(i,j)/4;
                    car7_grid(i,j-1)=car7_grid(i,j-1)-pop_grid_std2(i,j)/4;
                    car7_grid(i+1,j)=car7_grid(i+1,j)-pop_grid_std2(i,j)/4;
                end
            else
                if car7_grid(i,j)>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j);
                elseif (car7_grid(i,j)+car7_grid(i,j-1)+car7_grid(i-1,j)+car7_grid(i,j+1)+car7_grid(i+1,j))>=pop_grid_std2(i,j)
                    car7_grid(i,j)=car7_grid(i,j)-0.5*pop_grid_std2(i,j);
                    car7_grid(i-1,j)=car7_grid(i-1,j)-0.125*pop_grid_std2(i,j);
                    car7_grid(i,j-1)=car7_grid(i,j-1)-0.125*pop_grid_std2(i,j);
                    car7_grid(i,j+1)=car7_grid(i,j+1)-0.125*pop_grid_std2(i,j);
                    car7_grid(i+1,j)=car7_grid(i+1,j)-0.125*pop_grid_std2(i,j);
                else
                    car7_grid(i,j)=car7_grid(i,j)-pop_grid_std2(i,j)/5;
                    car7_grid(i-1,j)=car7_grid(i-1,j)-pop_grid_std2(i,j)/5;
                    car7_grid(i,j-1)=car7_grid(i,j-1)-pop_grid_std2(i,j)/5;
                    car7_grid(i+1,j)=car7_grid(i+1,j)-pop_grid_std2(i,j)/5;
                    car7_grid(i,j+1)=car7_grid(i,j+1)-pop_grid_std2(i,j)/5;
                end
            end
        end
    end
end
fprintf(sprintf('�糿7��򲻵�����������%f��\n��ԽСԽ�ã�\n',sum(sum(abs(car7_grid.*car7_grid<=0)))));
fprintf(sprintf('�糿7����еĳ��⳵������%f��\n��ԽСԽ�ã�\n',sum(sum(abs(car7_grid.*car7_grid>=1)))));
% �糿9��
% ��ʼ״̬
fprintf(sprintf('�糿9����⳵��ʼ����������%f��\n',sum(sum(abs(car9_grid)))));
for i=1:100 % ��
    for j=1:100 % ��
        if co_grid_std2(i,j)
            if i==1 && j==1
                if car9_grid(i,j)>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j);
                elseif (car9_grid(i,j)+car9_grid(i,j+1)+car9_grid(i+1,j))>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-0.5*co_grid_std2(i,j);
                    car9_grid(i+1,j)=car9_grid(i+1,j)-0.25*co_grid_std2(i,j);
                    car9_grid(i,j+1)=car9_grid(i,j+1)-0.25*co_grid_std2(i,j);
                else
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j)/3;
                    car9_grid(i+1,j)=car9_grid(i+1,j)-co_grid_std2(i,j)/3;
                    car9_grid(i,j+1)=car9_grid(i,j+1)-co_grid_std2(i,j)/3;
                end
            elseif i==1 && j==100
                if car9_grid(i,j)>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j);
                elseif (car9_grid(i,j)+car9_grid(i,j-1)+car9_grid(i+1,j))>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-0.5*co_grid_std2(i,j);
                    car9_grid(i+1,j)=car9_grid(i+1,j)-0.25*co_grid_std2(i,j);
                    car9_grid(i,j-1)=car9_grid(i,j-1)-0.25*co_grid_std2(i,j);
                else
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j)/3;
                    car9_grid(i+1,j)=car9_grid(i+1,j)-co_grid_std2(i,j)/3;
                    car9_grid(i,j-1)=car9_grid(i,j-1)-co_grid_std2(i,j)/3;
                end
            elseif i==100 && j==1
                if car9_grid(i,j)>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j);
                elseif (car9_grid(i,j)+car9_grid(i,j+1)+car9_grid(i-1,j))>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-0.5*co_grid_std2(i,j);
                    car9_grid(i-1,j)=car9_grid(i-1,j)-0.25*co_grid_std2(i,j);
                    car9_grid(i,j+1)=car9_grid(i,j+1)-0.25*co_grid_std2(i,j);
                else
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j)/3;
                    car9_grid(i-1,j)=car9_grid(i-1,j)-co_grid_std2(i,j)/3;
                    car9_grid(i,j+1)=car9_grid(i,j+1)-co_grid_std2(i,j)/3;
                end
            elseif i==100 && j==100
                if car9_grid(i,j)>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j);
                elseif (car9_grid(i,j)+car9_grid(i,j-1)+car9_grid(i-1,j))>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-0.5*co_grid_std2(i,j);
                    car9_grid(i-1,j)=car9_grid(i-1,j)-0.25*co_grid_std2(i,j);
                    car9_grid(i,j-1)=car9_grid(i,j-1)-0.25*co_grid_std2(i,j);
                else
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j)/3;
                    car9_grid(i-1,j)=car9_grid(i-1,j)-co_grid_std2(i,j)/3;
                    car9_grid(i,j-1)=car9_grid(i,j-1)-co_grid_std2(i,j)/3;
                end
            elseif i==1
                if car9_grid(i,j)>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j);
                elseif (car9_grid(i,j)+car9_grid(i,j-1)+car9_grid(i,j+1)+car9_grid(i+1,j))>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-0.5*co_grid_std2(i,j);
                    car9_grid(i,j-1)=car9_grid(i,j-1)-0.5*co_grid_std2(i,j)/3;
                    car9_grid(i,j+1)=car9_grid(i,j+1)-0.5*co_grid_std2(i,j)/3;
                    car9_grid(i+1,j)=car9_grid(i+1,j)-0.5*co_grid_std2(i,j)/3;
                else
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j)/4;
                    car9_grid(i,j-1)=car9_grid(i,j-1)-co_grid_std2(i,j)/4;
                    car9_grid(i+1,j)=car9_grid(i+1,j)-co_grid_std2(i,j)/4;
                    car9_grid(i,j+1)=car9_grid(i,j+1)-co_grid_std2(i,j)/4;
                end
            elseif i==100
                if car9_grid(i,j)>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j);
                elseif (car9_grid(i,j)+car9_grid(i,j-1)+car9_grid(i-1,j)+car9_grid(i,j+1))>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-0.5*co_grid_std2(i,j);
                    car9_grid(i-1,j)=car9_grid(i-1,j)-0.5*co_grid_std2(i,j)/3;
                    car9_grid(i,j-1)=car9_grid(i,j-1)-0.5*co_grid_std2(i,j)/3;
                    car9_grid(i,j+1)=car9_grid(i,j+1)-0.5*co_grid_std2(i,j)/3;
                else
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j)/4;
                    car9_grid(i-1,j)=car9_grid(i-1,j)-co_grid_std2(i,j)/4;
                    car9_grid(i,j-1)=car9_grid(i,j-1)-co_grid_std2(i,j)/4;
                    car9_grid(i,j+1)=car9_grid(i,j+1)-co_grid_std2(i,j)/4;
                end
            elseif j==1
                if car9_grid(i,j)>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j);
                elseif (car9_grid(i,j)+car9_grid(i-1,j)+car9_grid(i,j+1)+car9_grid(i+1,j))>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-0.5*co_grid_std2(i,j);
                    car9_grid(i-1,j)=car9_grid(i-1,j)-0.5*co_grid_std2(i,j)/3;
                    car9_grid(i,j+1)=car9_grid(i,j+1)-0.5*co_grid_std2(i,j)/3;
                    car9_grid(i+1,j)=car9_grid(i+1,j)-0.5*co_grid_std2(i,j)/3;
                else
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j)/4;
                    car9_grid(i-1,j)=car9_grid(i-1,j)-co_grid_std2(i,j)/4;
                    car9_grid(i+1,j)=car9_grid(i+1,j)-co_grid_std2(i,j)/4;
                    car9_grid(i,j+1)=car9_grid(i,j+1)-co_grid_std2(i,j)/4;
                end
            elseif j==100
                if car9_grid(i,j)>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j);
                elseif (car9_grid(i,j)+car9_grid(i,j-1)+car9_grid(i-1,j)+car9_grid(i+1,j))>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-0.5*co_grid_std2(i,j);
                    car9_grid(i-1,j)=car9_grid(i-1,j)-0.5*co_grid_std2(i,j)/3;
                    car9_grid(i,j-1)=car9_grid(i,j-1)-0.5*co_grid_std2(i,j)/3;
                    car9_grid(i+1,j)=car9_grid(i+1,j)-0.5*co_grid_std2(i,j)/3;
                else
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j)/4;
                    car9_grid(i-1,j)=car9_grid(i-1,j)-co_grid_std2(i,j)/4;
                    car9_grid(i,j-1)=car9_grid(i,j-1)-co_grid_std2(i,j)/4;
                    car9_grid(i+1,j)=car9_grid(i+1,j)-co_grid_std2(i,j)/4;
                end
            else
                if car9_grid(i,j)>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j);
                elseif (car9_grid(i,j)+car9_grid(i,j-1)+car9_grid(i-1,j)+car9_grid(i,j+1)+car9_grid(i+1,j))>=co_grid_std2(i,j)
                    car9_grid(i,j)=car9_grid(i,j)-0.5*co_grid_std2(i,j);
                    car9_grid(i-1,j)=car9_grid(i-1,j)-0.125*co_grid_std2(i,j);
                    car9_grid(i,j-1)=car9_grid(i,j-1)-0.125*co_grid_std2(i,j);
                    car9_grid(i,j+1)=car9_grid(i,j+1)-0.125*co_grid_std2(i,j);
                    car9_grid(i+1,j)=car9_grid(i+1,j)-0.125*co_grid_std2(i,j);
                else
                    car9_grid(i,j)=car9_grid(i,j)-co_grid_std2(i,j)/5;
                    car9_grid(i-1,j)=car9_grid(i-1,j)-co_grid_std2(i,j)/5;
                    car9_grid(i,j-1)=car9_grid(i,j-1)-co_grid_std2(i,j)/5;
                    car9_grid(i+1,j)=car9_grid(i+1,j)-co_grid_std2(i,j)/5;
                    car9_grid(i,j+1)=car9_grid(i,j+1)-co_grid_std2(i,j)/5;
                end
            end
        end
    end
end
fprintf(sprintf('�糿9��򲻵�����������%f��\n��ԽСԽ�ã�\n',sum(sum(abs(car9_grid.*car9_grid<=0)))));
fprintf(sprintf('�糿9����еĳ��⳵������%f��\n��ԽСԽ�ã�\n',sum(sum(abs(car9_grid.*car9_grid>=1)))));
%% ���25*25����
% Ԥ��������
pop_grid_big=zeros(25,25);
car7_grid_big=zeros(25,25);
co_grid_big=zeros(25,25);
car9_grid_big=zeros(25,25);
for i=1:25
    for j=1:25
        pop_grid_big(i,j)=sum(sum(pop_grid_std2((i-1)*4+1:i*4,(j-1)*4+1:j*4)));
        co_grid_big(i,j)=sum(sum(co_grid_std2((i-1)*4+1:i*4,(j-1)*4+1:j*4)));
        car7_grid_big(i,j)=sum(sum(car7_grid((i-1)*4+1:i*4,(j-1)*4+1:j*4)));
        car9_grid_big(i,j)=sum(sum(car9_grid((i-1)*4+1:i*4,(j-1)*4+1:j*4)));
    end
end
%% ��ͼ
subplot(2,2,1)
colorbar3(pop_grid_big);
axis([0.5,25.5,0.5,25.5]);
title('�˿������ȵ�����','FontName','SimHei','FontSize',14);
xlabel('T2','FontName','SimHei','FontSize',14);
subplot(2,2,2)
colorbar3(car7_grid_big);
axis([0.5,25.5,0.5,25.5]);
title('���⳵��Ӧ�ȵ�����','FontName','SimHei','FontSize',14);
xlabel('T2','FontName','SimHei','FontSize',14);
subplot(2,2,3)
colorbar3(co_grid_big);
axis([0.5,25.5,0.5,25.5]);
xlabel('T3','FontName','SimHei','FontSize',14);
subplot(2,2,4)
colorbar3(car9_grid_big);
axis([0.5,25.5,0.5,25.5]);
xlabel('T3','FontName','SimHei','FontSize',14);
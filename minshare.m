%% �Ӻ���3������˿�iƴ����⳵j�����ʱ���·��
% ���룺rout��m*2����ÿһ������Ϊ��ǰ·����
%      p_in��2*2����ÿһ�д���������꣨��㡢�յ㣩
% �����y��ƴ�����ʱ��
function [y_out,rout_new]=minshare(rout,p_in)
v=23; Beta=0.2; % ��·ϵ����
MAX_cost=99999999;
num_node=size(rout,1);
y=0;
for i=1:num_node-1
    y=y+dis(rout(i,:),rout(i+1,:));
end
[rout_new,~,~]=mininter(rout,p_in(1,:));
num_node_new=size(rout_new,1);
y_new=0;
for i=1:num_node_new-1
    y_new=y_new+dis(rout_new(i,:),rout_new(i+1,:));
end
if (y_new-y)/y>Beta
    y_new=MAX_cost;
elseif y_new-y<0
    error('����ڵ�ʱ�������⣡');
end
y_out=y_new/v;
end
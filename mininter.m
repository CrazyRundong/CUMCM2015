%% �Ӻ���1����С��������ѡ��
% ���룺rout��m*2����ÿһ������Ϊ��ǰ·����
%      p_in��1*2���󣬴����������
% �����rout_new��(m+1)*2���󣬲���p_in���·��
%       mincost��������������p_in�����ӵľ���
%       p��������p_in����λ�ýڵ��
function [rout_new,mincost,p]=mininter(rout,p_in)
MAX_T=99999999;
Alpha=1; % ��·ϵ����
mincost=MAX_T;
flag_change=0;
[num_node,~]=size(rout);
for i=1:num_node-1
    cost=dis(rout(i,:),p_in)+dis(rout(i+1,:),p_in)-dis(rout(i,:),rout(i+1,:));
    r=cost/dis(rout(i,:),rout(i+1,:));
    if r>Alpha; % �ж��Ƿ�������·ϵ����
        cost=MAX_T;
    end
    if cost<mincost
        mincost=cost;
        p=i;
        flag_change=1;
    end
end
if flag_change==1
    rout_new=[rout(1:p,:);p_in;rout(p+1:end,:)];
else
    rout_new=[rout;p_in];
    p=num_node;
    mincost=dis(rout(end,:),p_in);
end
end
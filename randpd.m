%% �Ӻ���4����20*20km��������������ɳ˿���˾������
% ���룺num_pas�����������ɵĳ˿�����
%       num_driv�����������ɵ�˾������
%       min_dis�����������˿ͳ˳�������С��ֵ
% �����pas��(num_pas*2)*2����ÿ����Ϊһ�����ݣ��ֱ������˿͵�������յ�
%       driv��num_driv*2����˾��λ��
function [pas,driv]=randpd(num_pas,num_driv,min_dis)
pas=[]; 
driv=rand(num_driv,2)*20;
while size(pas,1)~=num_pas*2
    pas_t=rand(2,2)*20;
    if dis(pas_t(1,:),pas_t(2,:))>min_dis
        pas=[pas;pas_t];
    end
end
end
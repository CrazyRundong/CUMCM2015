%% ������̬ƴ��ģ�Ͳ�ģ��
%% ������
clear;
v=23; % ��ʻ�ٶ�
max_seats=4; % ÿ��������ؿ���
num_pas=30;
num_driv=5;
min_dis=1.5;
[pas,driv]=randpd(num_pas,num_driv,min_dis);
pas_wait=inf*ones(num_pas,2); % �˿͵ȴ�ʱ�䡪��·�Ϻͳ���
% Ϊÿ���������ʼ�˿�
% ����num_driv*4��cell����cars�����зֱ�Ϊ��·�����ؿͱ�š�����ʻʱ�䡢�Ƿ�����
cars=cell(num_driv,4);
dis_car_pas=zeros(num_driv,num_pas);
flag_pas=ones(1,num_pas); % ���˿����ϳ������flag=0
flag_cars=zeros(1,num_driv); % �������ر��
for I=1:num_driv % ÿһ����
    cars{I,1}=driv(I,:);
    cars{I,4}=0; % �������ر��
    for J=1:num_pas
        if flag_pas(J)==1
            dis_car_pas(I,J)=dis(pas(2*J-1,:),driv(I,:));
        else
            dis_car_pas(I,J)=9999999999;
        end
    end
    [dis_min,idx]=min(dis_car_pas(I,:));
    pas_wait(idx,1)=dis_min/v;
    cars{I,3}=dis_min/v;
    cars{I,2}=[cars{I,2},idx];
    cars{I,1}=[cars{I,1};pas(2*idx-1,:);pas(2*idx,:)];
    flag_pas(idx)=0;
end
% ����ʣ��˿�ƴ��ʱ��
pas_remain=[1:num_pas].*flag_pas;
pas_remain=pas_remain(pas_remain~=0);
time_cij=zeros(num_driv,size(pas_remain,2)); % ��Ϊ��������Ϊ��ƴ���˿�
for I=1:num_driv % ÿһ����
    for J=1:size(time_cij,2) % ÿһλ��ƴ���˿�
        [time_cij(I,J),~]=minshare(cars{I,1},pas([2*pas_remain(J)-1,2*pas_remain(J)],:));
    end
end
% ����ÿλ�˿�suffֵ
suff_pas=zeros(1,size(pas_remain,2));
for J=1:size(suff_pas,2) % ÿһλ��ƴ���˿�
    cij_t=time_cij(:,J)';
    [c_min,idx_min]=min(cij_t);
    cij_t(idx_min)=max(cij_t);
    [c_min2,~]=min(cij_t);
    suff_pas(J)=c_min2-c_min;
end
% Ϊδ���ͳ��⳵�����ƴ���˿�
% ����num_driv*4��cell����cars�����зֱ�Ϊ��·�����ؿͱ�š�����ʻʱ�䡢�Ƿ�����
T=1;
while sum(flag_pas)~=0 && sum(flag_cars)~=num_driv && T<100
    for I=1:num_driv % ����ÿһ����
        % �ж��Ƿ��г˿�
        if sum(flag_pas)==0
            break;
        end
        if cars{I,4}==1
            continue;
        end
        while cars{I,4}~=1
            [~,idx_per_max]=max(suff_pas);
            cars{I,2}=[cars{I,2},pas_remain(idx_per_max)]; % ��suff����߽��ϳ�
            flag_pas(pas_remain(idx_per_max))=0; % ���´�ƴ���˿ͱ��
            [cars{I,3},cars{I,1}]=minshare(cars{I,1},pas([2*pas_remain(idx_per_max)-1,2*pas_remain(idx_per_max)],:)); % ����·����ʱ��
            % ����suff����
            suff_pas(idx_per_max)=0;
            % �ж��Ƿ�����
            if size(cars{I,2},2)==max_seats
                cars{I,4}=1;
                flag_cars(I)=1;
            end
        end
    end
    T=T+1;
end
% ����ÿһλ�˿͵ȴ�ʱ��
for I=1:num_driv % ����ÿһ����
    for J=1:size(cars{I,2},2) % ÿһλ�˿�
        % ����ȴ�ʱ��
        t=1; dis_t=0; 
        dis_t=dis_t+dis(cars{I,1}(t,:),pas(2*cars{I,2}(J)-1,:));
        while sum(cars{I,1}(t,:)==pas(2*cars{I,2}(J)-1,:))~=2
            t=t+1;
            dis_t=dis_t+dis(cars{I,1}(t,:),cars{I,1}(t-1,:));
            if t>size(cars{I,1},1)
                break;
            end
        end
        pas_wait(cars{I,2}(J),1)=dis_t/v;
        t=3; dis_t=0; 
        dis_t=dis_t+dis(cars{I,1}(t,:),cars{I,1}(t-1,:));
        while sum(cars{I,1}(t,:)==pas(2*cars{I,2}(J),:))~=2
            dis_t=dis_t+dis(cars{I,1}(t,:),cars{I,1}(t-1,:));
            t=t+1;
            if t>size(cars{I,1},1)
                break;
            end
        end
        pas_wait(cars{I,2}(J),2)=dis_t/v;
    end
end
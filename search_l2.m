%% ����2�������ڶ���
% flag_in=1:�����������ϱ�
% flag_in=2:�����������±�
% flag_in=3:�������������
% flag_in=4:�����������ұ�
function web_out=search_l2(web_in,x,i,j,flag_in)
[a,b]=size(web_in);
if flag_in==1 % �������ϱߵ�
    if i+1>a && j+1>b % �����±ߺ��ұ�
        web_in(i,j-1)=web_in(i,j-1)-x;
    elseif i+1>a && j-1<1 % �����±ߺ����
        web_in(i,j+1)=web_in(i,j+1)-x;
    elseif i+1>a % �����±�
        web_in(i,j-1)=web_in(i,j-1)-x/2;
        web_in(i,j+1)=web_in(i,j+1)-x/2;
    elseif j+1>b % �����ұ�
        web_in(i,j-1)=web_in(i,j-1)-x/2;
        web_in(i+1,j)=web_in(i+1,j)-x/2;
    elseif j-1<1 % �������
        web_in(i,j+1)=web_in(i,j+1)-x/2;
        web_in(i+1,j)=web_in(i+1,j)-x/2;
    else
        web_in(i,j-1)=web_in(i,j-1)-x/3;
        web_in(i,j+1)=web_in(i,j+1)-x/3;
        web_in(i+1,j)=web_in(i+1,j)-x/3;
    end
elseif flag_in==2 % �������±ߵ�
    if i-1<1 && j+1>b % �����ϱߺ��ұ�
        web_in(i,j-1)=web_in(i,j-1)-x;
    elseif i-1<1 && j-1<1 % �����ϱߺ����
        web_in(i,j+1)=web_in(i,j+1)-x;
    elseif i-1<1 % �����ϱ�
        web_in(i,j-1)=web_in(i,j-1)-x/2;
        web_in(i,j+1)=web_in(i,j+1)-x/2;
    elseif j+1>b % �����ұ�
        web_in(i,j-1)=web_in(i,j-1)-x/2;
        web_in(i-1,j)=web_in(i-1,j)-x/2;
    elseif j-1<1 % �������
        web_in(i,j+1)=web_in(i,j+1)-x/2;
        web_in(i-1,j)=web_in(i-1,j)-x/2;
    else
        web_in(i,j-1)=web_in(i,j-1)-x/3;
        web_in(i,j+1)=web_in(i,j+1)-x/3;
        web_in(i-1,j)=web_in(i-1,j)-x/3;
    end
elseif flag_in==3 % ��������ߵ�
    if i-1<1 && j+1>b % �����ϱߺ��ұ�
        web_in(i+1,j)=web_in(i+1,j)-x;
    elseif i+1>a && j+1>b % �����±ߺ��ұ�
        web_in(i-1,j)=web_in(i-1,j)-x;
    elseif j+1>b % �����ұ�
        web_in(i+1,j)=web_in(i+1,j)-x/2;
        web_in(i-1,j)=web_in(i-1,j)-x/2;
    elseif i+1>a % �����±�
        web_in(i-1,j)=web_in(i-1,j)-x/2;
        web_in(i,j+1)=web_in(i,j+1)-x/2;
    elseif i-1<1 % �����ϱ�
        web_in(i+1,j)=web_in(i+1,j)-x/2;
        web_in(i,j+1)=web_in(i,j+1)-x/2;
    else
        web_in(i+1,j)=web_in(i+1,j)-x/3;
        web_in(i-1,j)=web_in(i-1,j)-x/3;
        web_in(i,j+1)=web_in(i,j+1)-x/3;
    end
elseif flag_in==4 % �������ұߵ�
    if i-1<1 && j-1<1 % �����ϱߺ����
        web_in(i+1,j)=web_in(i+1,j)-x;
    elseif i+1>a && j-1<1 % �����±ߺ����
        web_in(i-1,j)=web_in(i-1,j)-x;
    elseif j-1<1 % �������
        web_in(i+1,j)=web_in(i+1,j)-x/2;
        web_in(i-1,j)=web_in(i-1,j)-x/2;
    elseif i+1>a % �����±�
        web_in(i-1,j)=web_in(i-1,j)-x/2;
        web_in(i,j-1)=web_in(i,j-1)-x/2;
    elseif i-1<1 % �����ϱ�
        web_in(i+1,j)=web_in(i+1,j)-x/2;
        web_in(i,j-1)=web_in(i,j-1)-x/2;
    else
        web_in(i+1,j)=web_in(i+1,j)-x/3;
        web_in(i-1,j)=web_in(i-1,j)-x/3;
        web_in(i,j-1)=web_in(i,j-1)-x/3;
    end
end
web_out=web_in;
end
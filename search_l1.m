%% ��������ĺ���
%% ����1��������һ��
function web_out=search_l1(web_in,x,i,j)
[a,b]=size(web_in);
if web_in(i,j)>=x
    web_in(i,j)=web_in(i,j)-x;
elseif i==1 && j==1 % ���Ͻ�
    if sum([web_in(i,j),web_in(i+1,j),web_in(i,j+1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i+1,j)=web_in(i+1,j)-x/4;
        web_in(i,j+1)=web_in(i,j+1)-x/4;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/4,i+1,j,1);
        web_in=search_l2(web_in,x/4,i,j+1,3);
    end
elseif i==a && j==1 % ���½�
    if sum([web_in(i,j),web_in(i-1,j),web_in(i,j+1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i-1,j)=web_in(i-1,j)-x/4;
        web_in(i,j+1)=web_in(i,j+1)-x/4;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/4,i-1,j,2);
        web_in=search_l2(web_in,x/4,i,j+1,3);
    end
elseif i==1 && j==b % ���Ͻ�
    if sum([web_in(i,j),web_in(i+1,j),web_in(i,j-1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i+1,j)=web_in(i+1,j)-x/4;
        web_in(i,j-1)=web_in(i,j-1)-x/4;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/4,i+1,j,1);
        web_in=search_l2(web_in,x/4,i,j-1,4);
    end
elseif i==a && j==b % ���½�
    if sum([web_in(i,j),web_in(i-1,j),web_in(i,j-1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i-1,j)=web_in(i-1,j)-x/4;
        web_in(i,j-1)=web_in(i,j-1)-x/4;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/4,i-1,j,2);
        web_in=search_l2(web_in,x/4,i,j-1,4);
    end
elseif i==1 % �ϱ�
    if sum([web_in(i,j),web_in(i+1,j),web_in(i,j-1),web_in(i,j+1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i+1,j)=web_in(i+1,j)-x/6;
        web_in(i,j-1)=web_in(i,j-1)-x/6;
        web_in(i,j+1)=web_in(i,j+1)-x/6;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/6,i+1,j,1);
        web_in=search_l2(web_in,x/6,i,j-1,4);
        web_in=search_l2(web_in,x/6,i,j+1,3);
    end
elseif i==a % �±�
    if sum([web_in(i,j),web_in(i-1,j),web_in(i,j-1),web_in(i,j+1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i-1,j)=web_in(i-1,j)-x/6;
        web_in(i,j-1)=web_in(i,j-1)-x/6;
        web_in(i,j+1)=web_in(i,j+1)-x/6;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/6,i-1,j,2);
        web_in=search_l2(web_in,x/6,i,j-1,4);
        web_in=search_l2(web_in,x/6,i,j+1,3);
    end
elseif j==1 % ���
    if sum([web_in(i,j),web_in(i+1,j),web_in(i-1,j),web_in(i,j+1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i+1,j)=web_in(i+1,j)-x/6;
        web_in(i-1,j)=web_in(i-1,j)-x/6;
        web_in(i,j+1)=web_in(i,j+1)-x/6;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/6,i+1,j,1);
        web_in=search_l2(web_in,x/6,i-1,j,2);
        web_in=search_l2(web_in,x/6,i,j+1,3);
    end
elseif j==b % �ұ�
    if sum([web_in(i,j),web_in(i+1,j),web_in(i-1,j),web_in(i,j-1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i+1,j)=web_in(i+1,j)-x/6;
        web_in(i-1,j)=web_in(i-1,j)-x/6;
        web_in(i,j-1)=web_in(i,j-1)-x/6;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/6,i+1,j,1);
        web_in=search_l2(web_in,x/6,i-1,j,2);
        web_in=search_l2(web_in,x/6,i,j-1,4);
    end
else % �м�
    if sum([web_in(i,j),web_in(i+1,j),web_in(i-1,j),web_in(i,j+1),web_in(i,j-1)])>=x
        web_in(i,j)=web_in(i,j)-x/2;
        web_in(i+1,j)=web_in(i+1,j)-x/8;
        web_in(i-1,j)=web_in(i-1,j)-x/8;
        web_in(i,j+1)=web_in(i,j+1)-x/8;
        web_in(i,j+1)=web_in(i,j+1)-x/8;
    else
        web_in(i,j)=web_in(i,j)-x/2;
        web_in=search_l2(web_in,x/8,i+1,j,1);
        web_in=search_l2(web_in,x/8,i-1,j,2);
        web_in=search_l2(web_in,x/8,i,j+1,3);
        web_in=search_l2(web_in,x/8,i,j-1,4);
    end
end
web_out=web_in;
end
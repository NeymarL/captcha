%基于MATLAB的图片中字符的提取（源代码）
function getPicChar    %%建立字符提取函数，在MATLAB平台上直接运行即可
    %运用MATLAB的UI，直接打牌需要提取的字符图片即可 
    [filename,pathname,~]=uigetfile({'*.jpg';'*.bmp';'*.png'},'Chose a picture');
    picstr=[pathname filename]; 
    if ~ischar(picstr)     
        return; 
    end
    pic=imread(picstr);     %打开图片
    if length(size(pic))==3     %判断图片的维数，统一为灰度图片
        pic=rgb2gray(pic); 
    end
    pic=(pic<127); %转化为二值图片
    pic=xylimit(pic);       %图片区域的第一次边界限定
    
    %%%%%%%第一阶段%%%%%% 
    
    m=size(pic,1);
    Ycount=zeros(1,m); 
    for i=1:m,
        Ycount(i)=sum(pic(i,:)); 
    end
    lenYcount=length(Ycount); 
    Yflag=zeros(1,lenYcount); 
    for k=1:lenYcount-2,
        if Ycount(k) < 3 && Ycount(k+1) < 3 && Ycount(k+2)<3, 
            Yflag(k)=1; 
        end 
    end
    for k=lenYcount:1+2
        if Ycount(k)<3 && Ycount(k-1)<3 && Ycount(k-2)<3 
            Yflag(k)=1; 
        end 
    end
    Yflag2=[0 Yflag(1:end-1)];

    Yflag3=abs(Yflag-Yflag2); %做差分运算 
    [~,row]=find(Yflag3==1); %找突变位置 
    row=[1 row m]; %调整突变位置点 
    row1=zeros(1,length(row)/2); %截取图像的起始位置向量

    row2=row1; %截取图像的终止位置向量

    for k=1:length(row)

        if mod(k,2)==1; %奇数为起始 
            row1((k+1)/2)=row(k);
        else %偶数为终止 
            row2(k/2)=row(k); 
        end 
    end

    pic2=pic(row1(1):row2(1),:); %截取第一列字符 
    alpha=1024/size(pic2,2); %计算放缩比例
    size(pic2) 
    pic2=imresize(pic2,alpha); %调整第一列字符图片大小，作为基准 
    for k=2:length(row)/2,

        pictemp=imresize(pic(row1(k):row2(k),:),[size(pic2,1) size(pic2,2)]);

        pic2=cat(2,pic2,pictemp); %横向连接图像块 
    end

    pic=xylimit(pic2); %限定图像区域

    %%%%%%%第二阶段%%%%%% 

    [~,n]=size(pic); 
    Xcount=zeros(1,n); 
    for j=1:n
        Xcount(j)=sum(pic(:,j));
    end

    lenXcount=length(Xcount); 
    Xflag=zeros(1,lenXcount); 
    for k=1:lenXcount-2

        if Xcount(k)<3 && Xcount(k+1)<3 && Xcount(k+2)<3 
            Xflag(k)=1; 
        end 
    end

    for k=lenXcount:1+2

        if Xcount(k)<3 && Xcount(k-1)<3 && Xcount(k-2)<3 
            Xflag(k)=1; 
        end 
    end

    Xflag2=[0 Xflag(1:end-1)]; 
    Xflag3=abs(Xflag-Xflag2); 
    [~,col]=find(Xflag3==1); 
    col=[1 col size(pic,2)];

    coltemp=col(2:end)-col(1:end-1); 
    [~,ind]=find(coltemp<3); 
    col(ind)=0; 
    col(ind+1)=0; 
    col=col(col>0);

    col1=zeros(1,length(col)/2); 
    col2=col1;

    for k=1:length(col) 
        if mod(k,2)==1
            col1((k+1)/2)=col(k); 
        else
            col2(k/2)=col(k); 
        end 
    end

    picnum2=length(col)/2; 
    piccell2=cell(1,picnum2); 
    for k=1:picnum2
        piccell2{k}=pic(:,col1(k):col2(k)); 
        piccell2{k}=xylimit(piccell2{k});
        piccell2{k}=imresize(piccell2{k},[128 128]); 
    end

    %显示提取出的字符，每行最多输出8个字符
    if mod(picnum2,8)
        rownum=ceil(picnum2/8)+1; 
    else
        rownum=picnum2/8; 
    end

    for k=1:picnum2

        subplot(rownum,8,k); 
        imshow(piccell2{k}); 
    end

end
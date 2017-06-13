function Objs = JoinObjects(Objects)
    Objs = zeros(100,4);
    used = zeros(100);
    n=1;
    
    for i=1 : size(Objects,1)
        if ~used(i)
            used(i) = 1;
            obj = Objects(i, :);
            for j=1 : size(Objects,1)
                if ~used(j) && intersect(obj, Objects(j,:))
                    obj = join(obj, Objects(j,:));
                    used(j) = 1;
                end
            end
            Objs(n, :) = obj(1,:);
            n = n+1;
        end
        
    end
    
    Objs=Objs(1:n,:);
end

function result = join(obj1, obj2)
    x11 = obj1(1);
    y11 = obj1(2);
    x12 = x11 + obj1(3);
    y12 = y11 + obj1(4);
    
    x21 = obj2(1);
    y21 = obj2(2);
    x22 = x21 + obj2(3);
    y22 = y21 + obj2(4);
    
    xf1 = min(x11, x21);
    yf1 = min(y11, y21);
    xf2 = max(x12, x22);
    yf2 = max(y12, y22);
    
    result = [xf1 yf1 (xf2-xf1) (yf2-yf1)];
end

function inter = intersect(obj1, obj2)
    inter = false;
    
    x11 = obj1(1);
    y11 = obj1(2);
    x12 = x11 + obj1(3);
    y12 = y11 + obj1(4);
    
    x21 = obj2(1);
    y21 = obj2(2);
    x22 = x21 + obj2(3);
    y22 = y21 + obj2(4);
    
    x31 = max(x11, x21);
    x32 = min(x12, x22);
    y31 = max(y11, y21);
    y32 = min(y12, y22);
    a3 = (x32-x31) * (y32-y31);
    a1 = (x12-x11) * (y12-y11);
    a2 = (x22-x21) * (y22-y21);
    inter = inter || (x31 <= x32 && y31 <=y32 && (a3 >= a1/2 || a3 >= a2/2));
end
function y = invq(Z),
% FUNCTION evaluates y so that Z = 2*(y - 1) + log(y), 
% Z may be a scalar, a vector or a matrix.

m = size(Z); m1 = m(1,1); m2 = m(1,2);

if m1 == 1,
    if m2 > 1,
        Z = Z';
        m3 = 1;
    else
        Z = Z;
        m3 = m2;
    end
else
    Z = Z;
    m3 = m2;
end

k = 1;
while k <= m3,
    y = Z(:,k);
    [a1 b1] = find(y<=.1); Y = y(a1);  
    e = 1; u = Y + 2;
    while max(abs(e)) >= 1e-8,
        d = Y - 2*(exp(u)-1) - u;
        e = d./(2*exp(u) + 1);
        u = u + e; 
    end
    x(a1,:) = exp(u); 


    [a2 b2] = find(y>.1); Y = y(a2);  
    e = 1; X = 1e-4*b2;
    while e >= 1e-4;
        z = 2*(X-1) + log(X); 
        u = X.*(1 + (Y-z)./(2*X+1));
        e = max(abs((u - X)./X));
        X = u; 
    end
    if size(a2) == 0,
        x = x;
    else
        x(a2,:) = X; 
    end
    xx(:,k) = x;
    k = k + 1;
end

if m1 == 1,
    if m2 > 1,
        y = xx';
    else
        y = xx;
    end
else
 	y = xx;
end 

function [su,an,Z]=spei(Data,scale,nseas)
    erase_yr=ceil(scale/12);
    A1=[];
    for is = 1:scale
        A1 = [A1,Data(is:length(Data)-scale+is)];
    end
    XS = sum(A1,2);

    if(scale>1)
        XS(1:nseas*erase_yr-scale+1)=[];   
    end

    srt = zeros(size(XS));
    n = size(XS);
    srt = sort(XS(:),'descend');
    w0=0;
    w1=0;
    w2=0;

    for i=1:n
        w0=w0+srt(i);
    end
    w0=w0/n;

    for i=1:n-1
        w1=w1+ (n-i)*srt(i);
    end
    w1=w1/(n*(n-1));

    for i=1:n-2
        w2=w2+ (((n-i)*(n-2-i))/2)*srt(i);
    end
    w2=w2/((n-1)*(n-2)*66);

    bet= ((2*w1)-w0)/((6*w1)-w0-(6*w2));
    alp= ((w0- 2*w1)*bet) /( gamma(1+(1/bet)) * gamma(1-(1/bet)) );
    gam= w0- (alp* gamma(1+(1/bet)) * gamma(1-(1/bet)));

    for i=1:n
        fun(i)=1 / ( 1 + ((alp/(d(i) - gam ))^bet));
    end

    for i=1:n
        if fun(i)< 0.5
            w(i)= (-2*log(fun(i)))^0.5;
            sign(i)=1;
        else 
            w(i) = (-2*log(1-fun(i)))^0.5;
            sign(i)=-1;
        end
    end

    for i=1:n
        spei(i) = w(i) - (( 2.515517 + 0.802853*w(i) + 0.010328*(w(i)^2)) /(1 + 1.432788*w(i) + 0.189269*(w(i)^2)+0.001308*(w(i)^3)));
        spei(i) = spei(i)*sign(i);
    end
    save('SPEI12.mat','spei');

    for i=1:n
        test_d(i)=spei(i);
        Y(i)=i;
    end
    [d,f] = normfit(XS);
    cdfarr = normcdf(XS,d,f);
    for i = 1:size(XS)
        if cdfarr(i) > 0.3
            if test_d(i) >= -1        
                weight(i) = 1;
            end
            if test_d(i) < -1 && test_d(i) >= -1.5
                    weight(i) = 2;
            end
            if test_d(i) < -1.5
                weighnumt(i) = 3;
            end
            if cdfarr(i) >= 0.3 && cdfarr(i) < 0.425
                rating(i) = 4;
            end
            if cdfarr(i) >= 0.425 && cdfarr(i) < 0.55

                rating(i) = 3;
            end
            if cdfarr(i) >= 0.55 && cdfarr(i) < 0.675
                rating(i) = 2;
            end
            if cdfarr(i) >= 0.675 && cdfarr(i) < 0.8
                rating(i) = 1;
            end
        end
    end
    su = 0;
    for i = 1:size(rating,2)
        su = su+weight(1,i)*rating(1,i);
    end
    an = icdf('normal',0.8,mean(Z),std(Z));
end
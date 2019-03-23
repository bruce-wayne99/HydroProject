function [su,an,Z]=spi(Data,scale,nseas)
    erase_yr=ceil(scale/12);
    A1=[];
    for is = 1:scale
        A1 = [A1,Data(is:length(Data)-scale+is)];
    end
    XS = sum(A1,2);

    if(scale>1)
        XS(1:nseas*erase_yr-scale+1)=[];   
    end

    for is=1:nseas
        tind=is:nseas:length(XS);
        Xn=XS(tind);
        [zeroa]=find(Xn==0);
        Xn_nozero=Xn;Xn_nozero(zeroa)=[];
        q=length(zeroa)/length(Xn);
        parm=gamfit(Xn_nozero);
        Gam_xs=q+(1-q)*gamcdf(Xn,parm(1),parm(2));
        Z(tind)=norminv(Gam_xs);
    end
    test_d = Z;
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
        

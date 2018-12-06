function F = DFT(image)

    [M,N] = size(image);
    K = M;
    L = N;
    ret = zeroes(K,L);
    for k=1:K
        for l=1:L
            Msum=0;
            Nsum-0;
            for m=1:M
                for n=1:N
                    f = image(n,m);
                    im = exp(-2j*pi*((k*m/M) + (l*n/N)));
                    Nsum = Nsum + f*im;
                end
                Msum = Msum + Nsum;
            end
            ret(k,l) = Msum/(M*N);
        end
    end      
    F = ret;
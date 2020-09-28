function outputNums = AntiNormalConvertor_Mk1(x, y, z)

    if x>=0
        pkx = x * 1024;
    else
        pkx = (x+2) * 1024;
    end
    
    if y>=0
        pky = y * 1024;
    else
        pky = (y+2) * 1024;
    end
    
    if z>=0
        pkz = z * 512;
    else
        pkz = (z+2) * 512;
    end
    
    outputNum = pkz*(2^22) + pky*(2^11) + pkx;
    
    outputNums(4) = floor(outputNum/256^3);
    outputNums(3) = floor(mod(outputNum/(256^2), 256));
    outputNums(2) = floor(mod(outputNum/(256), 256));
    outputNums(1) = floor(mod(outputNum, 256));

end
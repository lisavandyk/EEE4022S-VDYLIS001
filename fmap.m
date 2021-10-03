function [f] = fmap(s,t,tol)
%This function is created to map the correlation of an image to ordial
%values
%Akyüz, A. O. (2011, April). Photographically Guided Alignment for HDR Images. In Eurographics (Areas Papers) (pp. 73-74).

if t >tol
    if s > tol
        f = 1;
    elseif s < -1*tol
        f = 2;
    else
        f = 3;
    end
elseif t < -1*tol
    if s > tol
        f = 4;
    elseif s < -1*tol
        f = 5;
    else
        f = 6;
    end
else
    if s > tol
        f = 7;
    elseif s < -1*tol
        f = 8;
    else
        f = 9;
    end
end


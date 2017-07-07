function [ VRet ] = getPCAVideo( V )
    VCov = V*V';
    [U, lam] = eig(VCov);
    lam = diag(lam);
    lam(lam < 0) = 0;
    lam = sqrt(lam);
    VRet = bsxfun(@times, lam(:)', U);
    VRet = fliplr(VRet); %Order more important dimensions first
end
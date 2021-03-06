function g = Obs(X)
%%%%%%%%%%%%%%%%%%%% Single Target Observation Function
%Input: 
%       X - ECI State Vector: [r0, v0, r1, v1,..., rn, vn].'
%       R - Noise Covariance
%Output:
%       g = [d/dt(norm(r0)),d/dt(norm(r1-r0)),...,d/dt(norm(rn-r0))]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m = 3; %Coordinate Size
n = length(X)/(2*m); %Number of targets
x = cell(0);
for idx = 1:n
    x{idx,1} = X(2*m*(idx-1)+1 : 2*m*(idx-1)+m); %Position vector
    x{idx,2} = X(2*m*(idx-1)+m+1 : 2*m*idx); %Velocity vector
end

g = [x{1,1};x{1,2}]; %Hub position & velocity
for idx = 2:n
    DistN = norm(x{idx,1} - x{1,1}); %Distance to hub for satellite idx
    g = [g;DistN];
end
% v = sqrtm(R)*randn(n,1); %Gaussian Noise
% g = g + v; %Add Gaussian Noise
end
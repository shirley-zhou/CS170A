function T = jacobirotation(x,y,z)
c = 1;
s = 0;
if (abs(y) > 0)
if (abs(y) >= abs(x))
cotangent = x/y;
s = 1/sqrt(1 + cotangent^2);
c = s * cotangent;
else
tangent = y/x;
c = 1/sqrt(1 + tangent^2);
s = c * tangent;
end
end
T = [c -s ; s c]; % rotation matrix
% assertion: (-s*x + c*y) = 0
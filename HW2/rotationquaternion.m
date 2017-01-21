function q = rotationquaternion(theta, v)

v = v/norm(v);
q = [cos(theta/2) sin(theta/2)*v];
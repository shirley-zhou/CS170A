function qinv = quaternioninverse(q)

qinv = [q(1) -q(2:4)] / (q*q');
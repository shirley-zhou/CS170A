function result = randgenerator(n)

random_percents = rand(1, n);

random_percentiles = icdf('Lognormal', random_percents, 0, 1);
result = random_percentiles;

%1 = rand(1,n);
%v2 = rand(1,n);

%result = v1 + v2 + 2;
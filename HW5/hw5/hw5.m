%Problem 1:

vals = textread('incomeTax/HR_Clinton_2014_tax_return_numbers.txt', '%s');

numbers = unique(str2double(vals));

firstdigit = @(x) floor(x ./ (10 .^ floor(log10(x)))); %obtain first digits

number_of_bins = 9;
nu = number_of_bins - 1;

Histogram = hist(firstdigit(numbers), 1:9);
hist(firstdigit(numbers), 1:9);

BenfordProbabilities = diff(log10(1:10));
N = length(numbers);
BenfordHistogram = N * BenfordProbabilities;
hold on
plot(1:9, BenfordHistogram, 'r')

ChiSquareStatistic = sum((Histogram - BenfordHistogram) .^2 ./ BenfordHistogram)
ChiSquareProbability = cdf('Chisquare', ChiSquareStatistic, nu)


%Problem 3:


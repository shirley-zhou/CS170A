function [spike_freq,spike_power] = top_spike(frequency_values,power_values)

%ignore spikes from frequencies below 100Hz:
frequency_values = frequency_values(frequency_values >= 100);

%convert from frequency to index
ratio = 22050/705600;
%frequency = 1 + ratio*(index-1);
indices = (frequency_values-1)./ratio + 1;

[spike_power, i] = max(power_values(indices));
spike_freq = frequency_values(i);
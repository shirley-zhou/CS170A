function scree_plot( sigma, percent )
   if percent <= 0, percent = 0.01, end;
   if percent >  1, percent = 0.99, end;
   plot( sigma, 'b.' )
   hold on
   k = max(size(sigma));
   plot( [0 k], [percent percent] * sum(sigma), 'r-' )
   title('a "scree plot":  singular values of the face matrix X')
   xlabel(sprintf('the red line is 1 percent of the total of all singular values',round(percent*100)))
   hold off
end

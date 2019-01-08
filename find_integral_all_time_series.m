function amp_vector = find_integral_all_time_series(R, RT_tp)
amp_vector = zeros(1,size(R,1));

for i = 1:size(R,1)
   if RT_tp(i) > 0 
       amp_vector(i) = find_integral_tw(R(i,:), RT_tp(i), 60); 
   else
       warning ('no good data!')
   end
end
amp_vector
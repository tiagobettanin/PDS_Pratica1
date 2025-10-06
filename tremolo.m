function y = tremolo(x, fs, fm, m)
    x = x(:)';
    
    N = length(x);  

    t = (0:N-1) / fs;
  
    envelope = 1 + m * sin(2 * pi * fm * t);
    y = x .* envelope;
end

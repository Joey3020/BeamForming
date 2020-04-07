function volume = GetVolume( spherematrix, num )

volume = 0;

for i = 1:1:num
    for j= 1:1:num
        if spherematrix(i,j) > 0
            volume = volume + 1/3 * pi() * pi() / (num*num) * spherematrix(i,j).^3 * sin(pi()/2 * i / num);
    end
end

end

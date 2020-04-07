function maximum = findmax(a, b, num, D)
    maximum = max( max( D( 1 + (a-1)*num : a*num , 1 + (b-1)*num : b*num ) ) );
end
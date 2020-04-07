function [a, b, c, k, lamda, Num] = get_input()

    lamda = input('enter wavelength: ');
    x_length = input('enter length of aperture in wavelengths(x axis) :');
    y_length = input('enter width of aperture in wavelengths(y axis) :');
    z_length = input('enter height of aperture in wavelengths(z axis) :');
    Num=input('order of your square matrix for aperture field: ');

    a= x_length*lamda;
    b= y_length*lamda;
    c= z_length*lamda;
    k=2*pi()/lamda;

end
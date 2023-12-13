clear all
close all
clc

x = 0.1:(1/22):1;
w11_1=randn(1);
w21_1=randn(1);
w31_1=randn(1);
w41_1=randn(1);
b1_1=randn(1);
b2_1=randn(1);
b3_1=randn(1);
b4_1=randn(1);
w11_2=randn(1);
w12_2=randn(1);
w13_2=randn(1);
w14_2=randn(1);
b1_2=randn(1);

eta=0.0105; %mokymo zingsnis
d =(1+0.6*sin(2*pi*x/0.7))+0.3*sin(2*pi*x)/2; %funkcija kuria aproksimuosiu
plot(x,d,'b-o')%vaizduoju funkcija
title('duota f-ja')

for j = 1:100000
    for i = 1:length(x)
        % 1st layer
        v1 = x(i)*w11_1+b1_1;
        v2 = x(i)*w21_1+b2_1;
        v3 = x(i)*w31_1+b3_1;
        v4 = x(i)*w41_1+b4_1;
        y1_1=tanh(v1);
        y1_2=tanh(v2);
        y1_3=tanh(v3);
        y1_4=tanh(v4);

        % 2nd layer
        v1_2=y1_1*w11_2+y1_2*w12_2+y1_3*w13_2+y1_4*w14_2+b1_2;
        y2=v1_2; %tiesine aktyvacijos funkcija

        % Output layer
        e=d(i)-y2;
        delta1_2=e; %klaidos gradientas
        delta1_1=(1-tanh(y1_1)^2)*delta1_2*w11_2;
        delta2_1=(1-tanh(y1_2)^2)*delta1_2*w12_2;
        delta3_1=(1-tanh(y1_3)^2)*delta1_2*w13_2;
        delta4_1=(1-tanh(y1_4)^2)*delta1_2*w14_2;

      
        %atnaujinu rysio svorius ir bias isejimos sluoksniui
        w11_2=w11_2+eta*delta1_2*y1_1;
        w12_2=w12_2+eta*delta1_2*y1_2;
        w13_2=w13_2+eta*delta1_2*y1_3;
        w14_2=w14_2+eta*delta1_2*y1_4;
        b1_2=b1_2+eta*delta1_2;

        
        %atnaujinu svorius ir bias pasleptajam sluoksniui
        w11_1=w11_1+eta*delta1_1*x(i);
        w21_1=w21_1+eta*delta2_1*x(i);
        w31_1=w31_1+eta*delta3_1*x(i);
        w41_1=w41_1+eta*delta4_1*x(i);
        b1_1=b1_1+eta*delta1_1;
        b2_1=b2_1+eta*delta2_1;
        b3_1=b3_1+eta*delta3_1;
        b4_1=b4_1+eta*delta4_1;
    end
end


%tikrinu neurono tinklo aproksimavima
 y_approximated=zeros(size(x));
 for i=1:length(x)
   
     v1=x(i)*w11_1+b1_1;
     v2=x(i)*w21_1+b2_1;
     v3=x(i)*w31_1+b3_1;
     v4=x(i)*w41_1+b4_1;
     y1_1=tanh(v1);
     y1_2=tanh(v2);
     y1_3=tanh(v3);
     y1_4=tanh(v4);
 
     v1_2=y1_1*w11_2+y1_2*w12_2+y1_3*w13_2+y1_4*w14_2+b1_2;
     y_approximated(i)=v1_2; %tiesine aktyvacijos f-ja
 end


figure;
plot(x,d,'b-o');
hold on;
plot(x, y_approximated, 'r--o');
legend('pradine f-ja','aproksimuota f-ja')
title('Aproksimacija neuronu tinklu');
grid on;


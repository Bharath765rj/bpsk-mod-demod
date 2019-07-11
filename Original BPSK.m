%Binary Phase Shift Keying. 
 
clc;
clear vars;
close all;
t=0.01:0.01:1;
fc=10;
a=round(rand(1,10))
b=(2*a)-1;
c=repmat(b,1,10);
                      %To get finite energy width.
d=reshape(c,10,10);   %First 10 samples in first row.
e=d';
f=e(:)';              %Every bit into a sequence (row format).
g=sin(2*pi*fc*t);
h=f.*g;               %Element by element multiplication.
g1=sin(2*pi*fc*t+pi)
figure(6)
plot(angle(g))
 
figure(1);
subplot(3,1,1);
plot(t,f);
grid on;
axis([0 1 -2 2]);
xlabel('Time');
ylabel('Amplitude');
title('Binary Stream');
subplot(3,1,2);
plot(t,g);
grid on;
axis([0 1 -2 2]);
xlabel('Time');
ylabel('Amplitude');
title('Carrier Wave');
subplot(3,1,3);
plot(t,h);
grid on;
xlabel('Time');
ylabel('Amplitude');
title('BPSK Wave');
axis([0 1 -2 2]);
 
k=1; 
 
for i=-10:5:5 
    n(k,:)=awgn(h,i,'measured'); %Addition of noise to the input signal
    k=k+1;                       %measured is used so as to measure the power 
end                              %of the input signal and add noise accordingly   
 
figure(2);
subplot(5,1,1);
plot(t,h);
grid on;
title('Original Signal');
axis([0 1 -2 2]);
str={'Signal with SNR @-10dB' 'Signal with SNR @-5dB' 'Signal with SNR @0dB' 'Signal with SNR @5dB'};
xlabel('Time');
ylabel('Amplitude');
 
for i=1:4 
    subplot(5,1,i+1);
    plot(t,n(i,:));
    grid on;
    title(str(i));
    axis([0 1 -2 2]);
    xlabel('Time');
    ylabel('Amplitude');
end
h_1=h.*g;
 
figure(3);
k_1=2;
subplot(5,1,1);
plot(t,h_1);
grid on;
axis([0 1 -2 2]);
title('Correlated Signal without noise'); 



%Matched Filtering - can get the 
%original signal even if it is corrupted with awgn
%Filter has impulse response that
%replicates the transmitted sinal
            
 %Correlation studies similarity of the signal
                                          
                                          
str={'Correlated Signal with SNR @-10dB' 'Correlated Signal with SNR @-5dB' 'Correlated Signal with SNR @0dB' 'Correlated Signal with SNR @5dB'}; 
 
for i=1:4     
    r(i,:)=(n(i,:).*g);
    subplot(5,1,k_1);
    plot(t,r(i,:));
    grid on;
    title(str(i)); 
 
axis([0 1 -2 2]);
xlabel('Time');
ylabel('Amplitude');
k_1=k_1+1;
end  
 
str={'Signal Integrated over bit duration for SNR @-10dB' 'Signal Integrated over bit duration for SNR @-5dB' 'Signal Integrated over bit duration for SNR @0dB' 'Signal Integrated over bit duration for SNR @5dB'};
x_1=zeros(1,length(t));
y_1=x_1; 
 
figure(4);
k=1;     
for i=1:4
    x_1=r(i,:);
    for p=1:10:100
        y_1(p:p+9)=cumsum(x_1(p:p+9)); %Integration
        z(k)=y_1(p+9);
        k=k+1;
    end
    s_1(i,:)=y_1;
    subplot(4,1,i);
    plot(t,s_1(i,:));
    grid on;
    title(str(i));
    axis([0 1 -10 10]);
    xlabel('Time');
    ylabel('Amplitude');
    x_1=zeros(1,length(t));
    y_1=x_1; 
end
v=[];
v1=0;
o=1;
 
    for i=1:40
        if z(i)>0
            v1=ones(1,10);
        else
            v1=-ones(1,10); 
        end
        v=[v v1];
    end
 
    u=reshape(v,100,4); 
 
figure(5);
subplot(5,1,1);
plot(t,f);
grid on;
title('Original Data Stream');
xlabel('Time');
ylabel('Amplitude');
axis([0 1 -2 2]);
k=2;
str={'Retreived Binary Stream for SNR @-10dB' 'Retreived Binary Stream for SNR @-5dB' 'Retreived Binary Stream for SNR @0dB' 'Retreived Binary Stream for SNR @5dB'}; 
 
    for i=1:4
        subplot(5,1,k);
        plot(t,u(:,i));
        grid on;
        axis([0 1 -2 2]);
        title(str(i));
        xlabel('Time');
        ylabel('Amplitude');
        k=k+1;
        
    end
    





%Bit Error rate plot

% Splitting the retrived SNR as we took 4 different SNR values
    g1=u(:,1);
    g2=u(:,2);
    g3=u(:,3);
    g4=u(:,4);
    
        cnt1=0;
        
        cnt2=0;
        
        cnt3=0;
        
        cnt4=0;
    for i=1:100
        
      if g1(i)~=f(i)           %Comparing the input bits with that of the received bits
          if g1(i)~=1
              g1(i)=g1(i)+2;
              cnt1=cnt1+1;     %Incrementing count if any error has been detected.
          end
          if g1(i)~=-1
              g1(i)=g1(i)-2;
             cnt1=cnt1+1;
          end
      end
      if g2(i)~=f(i)
          if g2(i)~=1
              g2(i)=g2(i)+2;
              cnt2=cnt2+1;
          end
          if g2(i)~=-1
              g2(i)=g2(i)-2;
              cnt2=cnt2+1
          end
      end
      if g3(i)~=f(i)
          if g3(i)~=1
              g3(i)=g3(i)+2;
              cnt3=cnt3+1
          end
          if g3(i)~=-1
              g3(i)=g3(i)-2;
             cnt3=cnt3+1
          end
      end
      if g4(i)~=f(i)
          if g4(i)~=1
              g4(i)=g4(i)+2;
              cnt4=cnt4+1
              
          end
          if g4(i)~=-1
              g4(i)=g4(i)-2;
              cnt4=cnt4+1
          end
      end
    end
    
    



%Correction of the error that was detected in the previous loop.
%Plotting the error free signal







figure(6);
subplot(5,1,1);
plot(t,f);
grid on;
title('Original Data Stream');
xlabel('Time');
ylabel('Amplitude');
axis([0 1 -2 2]);
 
        subplot(5,1,2);
        plot(t,g1);
        grid on;
        axis([0 1 -2 2]);
        title('ERROR FREE : Retreived Binary Stream for SNR @-30dB');
        xlabel('Time');
        ylabel('Amplitude');
        
        subplot(5,1,3);
        plot(t,g2);
        grid on;
        axis([0 1 -2 2]);
        title('ERROR FREE : Retreived Binary Stream for SNR @-25dB');
        xlabel('Time');
        ylabel('Amplitude');
        
        subplot(5,1,4);
        plot(t,g3);
        grid on;
        axis([0 1 -2 2]);
        title('ERROR FREE : Retreived Binary Stream for SNR @-20dB');
        xlabel('Time');
        ylabel('Amplitude');
        
        subplot(5,1,5);
        plot(t,g4);
        grid on;
        axis([0 1 -2 2]);
        title('ERROR FREE : Retreived Binary Stream for SNR @-15dB');
        xlabel('Time');
        ylabel('Amplitude');
    
        






%Plotting the Bit Error Rate vs SNR curve


format long;
BER1 = cnt1/100;
format long;
BER2 = cnt2/100;
format long;
BER3 = cnt3/100;
format long;
BER4 = cnt4/100;
snraxis = [-30 -25 -20 -15]
beraxis = [BER1 BER2 BER3 BER4];
figure(7);
semilogx(snraxis,beraxis);
grid on;
%{
scatter(-30,BER1);
hold on;
scatter(-25,BER2);
hold on;
scatter(-20,BER3);
hold on;
scatter(-15,BER4);
hold on;
grid on;
%}
title('BIT ERROR RATE FOR DIFFERENT SNR');
        xlabel('SNR -->');
        ylabel('BIT ERROR RATE -->');
 
%TO plot Constellation graph. 
%{
x1=real(exp(j*1*(pi/2)));
x2=imag(exp(j*1*(pi/2)));
x3=real(exp(j*-1*(pi/2)));
x4=imag(exp(j*-1*(pi/2)));
q1=[x1 x3];
q2=[x2 x4];
figure(8); 
for i=1:4
    stem(q2,q1);
end
title('CONSTELLATION PLOT');
xlabel('Inphase Component-->');
ylabel('Quadrature Component-->');
%}
    o=sin(2*pi*fc*1);
    angle(o)
    p=sin(2*pi*fc*-1);
    angle(p)
    figure (8);
    scatter(angle(o),0)
    hold on;
    scatter(angle(p),0)
    title('CONSTELLATION DIAGRAM')
    xlabel('Phase---> (\theta)')
    ylabel('Magnitude---> ')
    
%}


%Frequency Spectrum plot of BPSK Signal 
figure
fft_bpsk=fft(h);
len=length(h);
f=[-len/2:len/2-1];
plot(f,abs(fftshift(fft(h))))

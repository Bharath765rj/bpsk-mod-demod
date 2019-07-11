%Binary Phase Shift Keying. 
 
clc;
clear vars;
close all;
count=100;
t_1=(1/(count^2)):(1/(count)):1; 
t=(1/(count^2)):(1/(count^2)):1; 
fc=10;
a=round(rand(1,count))
                                                   %DPSK Modulation of the input sequence
c_1(1)=0
for i=1:100
    c_1(i+1)=xor(c_1(i),a(i))
    d_1(i+1)=~c_1(i+1)
end
for i=1:100
    d_3(i)=d_1(i+1)
end
b=(2*d_3)-1;
c=repmat(b,1,count);
d=reshape(c,count,count);                          %First 10 samples in first row.
e=d';
w1= e(:)';   
            

                                                   %Every bit into a sequence (row format).
g=sin(2*pi*fc*t);
h=w1.*g;   
                                                   %Element by element multiplication.
figure(1);
subplot(2,1,1);
plot(t_1,a);
grid on;
xlabel('Time');
ylabel('Amplitude');
title('Input Bit sequence');
axis([0 1 -2 2]);


subplot(2,1,2);
plot(t_1,d_3);
grid on;
xlabel('Time');
ylabel('Amplitude');
title('DPSK Wave');
axis([0 1 -2 2]);


figure(2);
subplot(3,1,1);
plot(t,w1);
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
 
for i=-35:20:45
    n(k,:)=awgn(h,i,'measured');      %Addition of noise to the input signal
    k=k+1;                            %measured is used so as to measure the power 
end                                   %of the input signal and add noise accordingly   
 
figure(3);
subplot(6,1,1);
plot(t,h);
grid on;
title('Original Signal');
axis([0 1 -2 2]);
str={'Signal with SNR @-35dB' 'Signal with SNR @-15dB' 'Signal with SNR @5dB' 'Signal with SNR @25dB' 'Signal with SNR @45dB'  };
xlabel('Time');
ylabel('Amplitude');

for i=1:5
    subplot(6,1,i+1);
    plot(t,n(i,:));
    grid on;
    title(str(i));
    axis([0 1 -2 2]);
    xlabel('Time');
    ylabel('Amplitude');
end
h_1=h.*g;
 
figure(4);
k_1=2;
subplot(6,1,1);
plot(t,h_1);
grid on;
axis([0 1 -2 2]);
title('Correlated Signal without noise'); %Matched Filtering - can get the 
                                          %original signal even if it is corrupted with awgn
                                          %Filter has impulse response that
                                          %replicates the transmitted
                                          %signal.
                                          %Correlation studies similarity
                                          %of the signal
                                          
str={'Correlated Signal with SNR @-35dB' 'Correlated Signal with SNR @-15dB' 'Correlated Signal with SNR @5dB' 'Correlated Signal with SNR @25dB' 'Correlated Signal with SNR @45dB'}; 
 
for i=1:5     
    r(i,:)=(n(i,:).*g);
    subplot(6,1,k_1);
    plot(t,r(i,:));
    grid on;
    title(str(i)); 
 
axis([0 1 -2 2]);
xlabel('Time');
ylabel('Amplitude');
k_1=k_1+1;
end  
 
str={'Signal Integrated over bit duration for SNR @-35dB' 'Signal Integrated over bit duration for SNR @-15dB' 'Signal Integrated over bit duration for SNR @5dB' 'Signal Integrated over bit duration for SNR @25dB' 'Signal Integrated over bit duration for SNR @45dB'};
x_1=zeros(1,length(t));
y_1=x_1; 
 
figure(5);
k=1;     
for i=1:5
    x_1=r(i,:);
    for p=1:count:count*count
        y_1(p:p+(count-1))=cumsum(x_1(p:p+(count-1))); %Integration
        z(k)=y_1(p+(count-1));
        k=k+1;
    end
    s_1(i,:)=y_1;
    subplot(5,1,i);
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
 
    for i=1:5*count
        if z(i)>0
            v1=ones(1,count);
        else
            v1=-ones(1,count); 
        end
        v=[v v1];
    end
 f2=[];
    f1=0;
    bitval=[];
 for i=1:5*count                           %contains the four realizations (sigansl corrupted by four diff values of noise), each reralization has 10 values so 4 signalks have 40                
        if z(i)>=0                         %z is the variable that acts as a decision maker. depending on if it is +ve or -ve                 
            f1=1;             
        else
            f1=0;             
        end
        dec(i)=f1;
    end
 dec1=reshape(dec,count,5)';
 k=1; 
 berval=[];
 for snr=-35:20:45
     [noe ber]= biterr(a,dec1(k,:));
     berval=[berval ber];
     k=k+1;
 end
     
 u=reshape(v,count*count,5);               % we use this fn to recover the 4 realizATIONS, 400 Bits are created. we have 4 such columns each with 100 rows.
 
figure(5); 
subplot(6,1,1); 
plot(t,w1); 
grid on; 
title('Original Data Stream'); 
xlabel('Time'); ylabel('Amplitude'); 
axis([0 1 -2 2]);
k=2; 
str={'Retreived Binary Stream for SNR @-35dB' 'Retreived Binary Stream for SNR @-5dB' 'Retreived Binary Stream for SNR @15dB' 'Retreived Binary Stream for SNR @25dB' 'Retreived Binary Stream for SNR @45dB'}; 
 
    for i=1:5                 
        subplot(6,1,k); plot(t,u(:,i)); 
        grid on;         
        axis([0 1 -2 2]);        
        title(str(i)); 
        xlabel('Time'); 
        ylabel('Amplitude');         
        k=k+1;     
    end
    figure(6);
    snr=-35:20:45;
    semilogy(snr,berval,'b*-','linewidth',2); 
    grid on;
    title('Practical BER vs SNR')
    xlabel('SNR')
    ylabel('BER')

    bitval=[];
    i=1; 
for snr=-35:20:45
y(i,:)=awgn(b,snr,'measured');
i=i+1;
end
y1=reshape(y',1,[]);
for i=1:length(y1)
    if y1(i)>=0
        det(i)=1;
    else det(i)=0;
    end
end
det1=reshape(det,[],5)';
for i=1:length(b)
    if b(i)==1
        b1(i)=1;
    else
        b1(i)=0;
    end
end
k=1; 
berval=[];
 for snr=-35:20:45;
     [noe ber]= biterr(b1(:)',det1(k,:));
     berval=[berval ber];    
     k=k+1;
end
     
figure(7);
    snr=-35:20:45
    semilogy(snr,berval,'b*-','linewidth',2); 
    grid on;
    title('Theoretical BER vs SNR')
    xlabel('SNR')
    ylabel('BER')
   
%Frequency Spectrum of BPSK Sigal 
figure(8)
fft_bpsk=fft(h);
len=length(h);
w=[-len/2:len/2-1];
plot(w,abs(fftshift(fft(h))))
title('Frequency Spectrum')
    xlabel('Frequency')
    ylabel('Magnitude---> ')

%Constellation
num=1e4;
int=randi([1,2],1,num)
bpsk=zeros(size(int));
bpsk(int==1)=1;
bpsk(int==2)=-1;
figure(9)
plot(real(bpsk),imag(bpsk),'.');
xlim([-2 2]);
ylim([-2 2]);
title('BPSK Constellation');
xlabel('real part');
ylabel('imaginary part');
grid on;


%Decoding of DPSK 
g1=u(:,1)';
g2=u(:,2)';
g3=u(:,3)';
g4=u(:,4)';
g5=u(:,5)';
for i=1:100
    if g1(i)==-1
        g1(i)=0;
    end
    if g2(i)==-1
        g2(i)=0;
    end
    if g3(i)==-1
        g3(i)=0;
    end
    if g4(i)==-1
        g4(i)=0;
    end
    if g5(i)==-1
        g5(i)=0;
    end
end
for i=1:100
    if i==1
        z1(i)=xor(0,g1(i));
        z2(i)=xor(0,g2(i));
        z3(i)=xor(0,g3(i));
        z4(i)=xor(0,g4(i));
        z5(i)=xor(0,g5(i));
    else
        z1(i)=xor(g1(i),g1(i-1));
        z2(i)=xor(g2(i),g2(i-1));
        z3(i)=xor(g2(i),g3(i-1));
        z4(i)=xor(g2(i),g4(i-1));
        z5(i)=xor(g2(i),g5(i-1));
    end
end
figure(10) 
subplot(5,1,1)
plot(t_1,z1);
subplot(5,1,2)
plot(t_1,z2);
subplot(5,1,3)
plot(t_1,z3);
subplot(5,1,4)
plot(t_1,z4);
subplot(5,1,5)
plot(t_1,z5);
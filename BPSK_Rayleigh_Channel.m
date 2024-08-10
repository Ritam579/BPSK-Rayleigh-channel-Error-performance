%Error perfromance in BPSK-Rayleigh channel

%Generation of Bits
N = 10^6; %No. of samples
d = randi([0 1],1,N); %Binary data
EbN0dB = 0:2:16;
EbN0 = 10.^(EbN0dB/10);

% BPSK Modulation
for i = 1:N
    if d(i) ==1
        x(i) = -1 +0i;
    else
        x(i) = 1 + 0i;
    end
end

%Rayleigh Channel
for loop1 = 1:length(EbN0)
    n = randn(1,N) + 1i*rand(1,N);
    h = 1/sqrt(2)*(randn(1,N)+1i*randn(1,N));
    sigma = 1/sqrt(2*EbN0(loop1));
    noise = sigma*n;
    y = x.*h+noise;

    %BPSK Demodulation
    for i = 1:N
        if y(i) > 0
            s1(i) = 0;
        else
            s1(i) = 1;
        end
    end

    %Calculate and plot BER
    err(loop1) = sum(d~=s1)/length(d);
end

%Calculate and plot theoritical BER
err_t = 0.5*(1-sqrt(EbN0./(1+EbN0)));
semilogy(EbN0dB,err); %Simulated
xlabel('Eb/N0');
ylabel('Bit Error Rate');
hold on
semilogy(EbN0dB,err_t,'ro--'); %Theoritical
grid on
ylim([10^(-6) 1]);
legend('Simulated','Theoritical');



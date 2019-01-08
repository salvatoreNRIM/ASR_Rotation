function R = sound_delivery_with_TTL(nPulses)
%Identify the device
devices = daq.getDevices;
st = daq.createSession('ni');
addAnalogOutputChannel(st,'Dev1','ao0','Voltage');
outputSignal = 0;


%--------------------------------------------------------------------------
% Generate white noise
% set general variables
sf = 44100;  % sample frequency
nf = sf / 2; % nyquist frequency
d = 0.05;     % duration (time)
n = sf * d;  % number of samples
nh = n / 2;  % half number of samples

% set variables for filter
lf = 1;   % lowest frequency
hf = 20000;   % highest frequency
lp = lf * d; % ls point in frequency domain    
hp = hf * d; % hf point in frequency domain
% design filter
%clc;
a = ['BANDPASS'];
filter = zeros(1, n);           % initializaiton by 0
filter(1, lp : hp) = 1;         % filter design in real number
filter(1, n - hp : n - lp) = 1; % filter design in imaginary number

% make noise
rand('state',sum(100 * clock));  % initialize random seed
noise = randn(1, n);             % Gausian noise
noise = noise / max(abs(noise)); % -1 to 1 normalization
% do filter
s = fft(noise);                  % FFT
s = s .* filter;                 % filtering
s = ifft(s);                     % inverse FFT
s = real(s);


%--------------------------------------------------------------------------
%Generate n random number between t_max and t_min
t_min = 35;
t_max = 65;
times = t_min + rand(1,nPulses)*(t_max);
t_out = 0:0.1:1; % 10 Hz sample freq for 1 s
d = 0:1; % 1Hz repetition frequency

  outputSignal = [pulstran(t_out,d,'rectpuls') 0];

  for t = times
    pause(t); %// Pause for t seconds   
    sound(s, sf);
    %tic
    %send signal to MoCap system
  

    %toc
    queueOutputData(st,outputSignal.') 
    startForeground(st); 
%    data1 = repmat(0.01, 1000);
%    data = [data1 data1];
%    queueOutputData(s,data)        % Queue the output data again
%    s.startForeground();           % start the output

  end 

release(st);
R = 1;
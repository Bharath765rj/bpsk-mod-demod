# bpsk-mod-demod
BPSK modulation and demodulation for 10k input bits along with constellation and BER vs SNR plot.

A pseudo randomly generated 10k input bits are BPSK modulated and demodulated and their variations with respect to the Signal to the Noise Ratio (SNR) and the maximum error in the bits Bit Error Rate (BER) are analyzed.

Frequency Spectrum is analyzed to understand the efficiency of data transmission.

-----------------------------------------------------------------------------------

AWGN (Additive White Gaussian Noise ) is added so as to model a noisy channel and make analysis from the BER plot.

-----------------------------------------------------------------------------------

A Simplified BPSK Modulation- Demodulation Model:




                                                         AWGN Noisy Channel Model
INPUT BITS  -----> Differential Pulse Encoding ------> *--------------------------> Correlation    ------> Integration        -------->
(10k bits)                                             ^                             of modulated Signal       over bit duration
                                                       ^
                                                       Carrier Signal
                                                       
  --------> Setting up Threshold   --------> Resulting bit pattern
             for detection of bits.             at the receiver end.

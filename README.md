# Brief

This is a simple UART implementation as a final project for my NTI internship in Digital Design Using FPGA. I hope you enjoy it.
UART is an asynchronous protocol, so the TX & RX have to agree on a baud rate (the rate at which data is sent).


### Assumption 

This project assumes that the UART module is embedded in a bigger system (SoC, for example), so the input signals come from the Bus interface. For now, I'll simulate this through the testbench.


### Implementation keys 

1) To derive the baud rate from the system clock was tricky at first, but with counters and some conditionals, it's a piece of cake.
2) To debug the code without automation is painful , so using just one script to automate the commands and pop out the waveform saves a lot of time for me

### Transmitter Architecture

<img width="806" height="432" alt="image" src="https://github.com/user-attachments/assets/0e57a5c9-f742-4e57-89c4-248529a265d0" />

* The Transmitter

  * Sends only one byte at a time
  * Appends start and stop bits
  * Handles sending data with right bit times based on baud rate
  * Asserts done after finishing sending the loaded byte
  * Asserts busy while sending the loaded byte

### Receiver Architecture 

<img width="1514" height="668" alt="image" src="https://github.com/user-attachments/assets/2f53f286-15bd-4aa6-bf11-0b346623f778" />

* The Receiver

  * Only receives one byte at a time.
  * Waits for a falling edge (start bit).
  * Samples the data bits in the middle of each bit period.
  * Validates stop bit(s).
  * Asserts busy when a byte is being received.
  * Asserts done when a byte is received.




  ## Conclusion

  The UART project was implemented and tested successfully. It showed how serial data can be transmitted and received reliably. This work gave practical insight into baud rate control and digital communication.

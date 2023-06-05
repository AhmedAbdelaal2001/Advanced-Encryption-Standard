# Advanced-Encryption-Standard
## Overview
A full hardware implementation of the Advanced Encryption Standard (AES) using Verilog, supporting SPI communication between all modules.
## AES Modules
The two central modules in this project are **Cipher** and **Decipher**, which are responsible for the encryption and decryption processes following the AES, respectively. Both of these modules use the output of the **KeyExpansion** module to execute their computation. Encryption, decryption, and key expansion are all implemented in a sequential manner, balancing the tradeoff between speed and hardware usage. Furthermore, the modules support AES-128, AES-192, and AES-256.
## SPI Modules
The **SPImaster** module stores the key and the data to be encrypted/decrypted, and **SPIslave** modules communicate directly with the Cipher/Decipher/KeyExpansion modules. The encryption process is as follows:
1. The SPImaster sends the key to the keyExpansion module, which generates the key schedule (to be used in encryption/decryption).
2. After the keyExpansion module finishes its task, the SPImaster sends the 128-bits block of data to the Cipher module over 128 clock cycles.
3. Once the encryption process is over, the SPImaster receives the 128-bits long ciphertext over multiple clock cycles, and stores this result.
4. Steps 2 & 3 are then continuously repeated until the input data is completely encrypted, in blocks of 128-bits.
The Decryption process is identical.
## Notes
* The **SelfCheckingTB** module is the final wrapper that is ready to be directly uploaded to the FPGA board (5CSEMA5F31C6N). If all operations are successful, LEDS 0-7 will all light up.
* For every module, there is a corresponding testbench. Simulating those tesbenches requires ModelSim-Altera.

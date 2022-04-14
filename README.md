## Why does this repo exist?

In Semester 1, 2022, it was noted that in the rare scenario a student wrote poor/buggy code that interacted with and modified a particular set of GPIO pins on port 0, the communication between the target MCU and the interface chip would be destroyed. This would result in the loss of the MICROBIT drive as the microbit would no longer identify itself as a USB device to computers. This would mean you couldn't upload new code to wipe the old, nefarious code!

## The solution

After getting in contact with Carlos, a software engineer at the Microbit organisation via the DAPLink/PyOCD slack, a solution was developped: A custom interface firmware hex that simply initialises the device MCU then wipes the target flash. This would allow us to flash custom interface firmware to wipe the target flash, then reflash the actual interface firmware over the top and have a functioning micro:bit again!

---

## Instructions

Step 0: Download the two `.hex` files in this repo. (`0255_kl27z_microbit_0x8000.hex` and `kl27z_microbit_if_crc-erase_target.hex`). This can be done by clicking on the file to view its contents, then click on the download button (the Down arrow pointing into a tray icon) in the top right of the file viewer. Do this for both files.

![Screenshot of the download button location for files in gitlab.](https://gitlab.cecs.anu.edu.au/u7115734/microbit-firmware-flash-wipe-hex/-/blob/main/assets/readme_download.png "Download button on a gitlab file.")

Step 1: Unplug the micro:bit, then, while holding the RESET button, plug it back in to enter MAINTENANCE mode. (You should see a 'MAINTENANCE' USB device appear.)

Step 2: Drag the `kl27z_microbit_if_crc-erase_target.hex` file into the MAINTENANCE drive. You should see the activity via the yellow activity indicator LED on the microbit, then the device should disconnect and reconnect. You should see the microbit simply alternate between flashing the red and yellow LEDs.

Step 3: Unplug and reconnect the microbit whilst holding the RESET button to enter MAINTENANCE mode again. Now drag the `0255_kl27z_microbit_0x8000.hex` file into the drive to reflash the complete interface firmware back onto the microbit.

Step 4: Profit! The microbit should disconnect and reconnect as MICROBIT, the indication that the interface + target MCU are now working in harmony correctly again!

---

### In this repo

Included in this repo is the original source code responsible for the first instance of this problem for research and education purposes ONLY. Do NOT flash your board with this software in ANY scenario, as it will result in you having to use the above solution to fix it! No guarentees either! Again, this is for EDUCATION and RESEARCH purposes only! Do not venture into the `src/` folder if you are not intricately familiar with what you are doing!

`src/` -> `bad_source.S`  
`src/` -> `bad_source_compiled.o`  
`src/` -> `bad_program.elf`  
`src/` -> `bad_hex.hex` (this is the file that will brick your microbit if flashed to it outside of MAINTENANCE mode)  

---

## Sources

[Here](https://github.com/microbit-foundation/DAPLink/commit/d68bcc34863a95b0ef452bb434c8d04b0273b35c) is the DAPLink commit written by Carlos detailing the target-wipe debug firmware. Links to the DAPLink slack are also contained within this github repo.

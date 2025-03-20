# Stopper
The system is to work as a stopwatch measuring time with an accuracy of hundredths of a second (SS.DD). It is operated using two buttons:

BTNC (start_stop_button_i) – Start and stop the stopwatch
BTNR (rst_i) – Reset the stopwatch (sets the time to "00.00" and stops)

Additionally:

If the time exceeds 59.99 s, the display should show an overflow message, e.g. "--.--".
BTNC button must be protected from contact vibrations (~50 ms).
The clock frequency is 100 MHz.

Each press of the BTNC button causes a transition between three states:

State 1: Waiting (stopped, shows last measured time or 00.00)
State 2: Timing (increments value by 10 ms)
State 3: Overflow (displays "--.--")
The BTNR (reset) button always sets the time to "00.00" and returns to the waiting state.


Overview for every part of the stopper:

1. Frequency Divider
Purpose: A frequency divider generates a new clock signal with a lower frequency based on the input clock (clk_i).
The input clock has a very high frequency (e.g. 100 MHz). For the counter in the stopwatch to work properly, a slower clock is needed. A frequency divider reduces the frequency of the input signal by dividing the number of cycles.

Given a division factor of 10  and if the input clock is 100 MHz:

The output clock will be 100 MHz / 10 = 10 MHz.


2. Debouncer (Button Contact Vibration Filter)
Purpose: A mechanical button does not change state perfectly - when pressed for a short moment it generates vibrations (changes state several times within a few dozen milliseconds).
Debouncer eliminates these vibrations, providing a stable logical signal.

When the button is not pressed, the counter counter stores the maximum value.
When the button is pressed, the counter starts counting down to zero.
If the counter reaches zero, the output signal becomes '1' and stabilizes.
If the button is released before the countdown ends, the counter resets to the maximum value.


3. Counter
Purpose: The counter module is a master stopwatch counter that:

Counts time in 10 ms intervals (i.e. 100 times per second, since 1 s = 100 × 10 ms).

Can be stopped by inhibit_i signal.
Can be reset by rst_i.
Uses FrequencyDivider to achieve slower clock speed.


4. Encoder (Encoding numeric values ​​to a 7-segment display)
Purpose:
The Encoder module is designed to:

Convert a 16-bit number (digit_in) to a format that can be displayed on four 7-segment displays.
Encode the digits to the appropriate display segments.
Handle numbers from 0 to 65535, but in practice only displays the last four digits.

5. Display (Displaying Values ​​on a 4-Digit 7-Segment Display)
Purpose

The Display module is responsible for multiplexing four digits and displaying them on a 7-segment LED screen.

Each digit is displayed for a specified time.
The rapid switching between digits causes the human eye to see the full number (persistence of vision phenomenon).
The division timer controls the speed of switching digits.


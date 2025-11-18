/*****************************************************************//**
 * @file main_vanilla_test.cpp
 *
 * @brief Basic test of 4 basic i/o cores
 *
 * @author p chu
 * @version v1.0: initial release
 *********************************************************************/

//#define _DEBUG
#include "chu_init.h"
#include "gpio_cores.h"
#include "sseg_core.h"
#include "i2c_core.h"

/**
 * leds flash according to switch positions.
 * @param led_p pointer to led instance
 * @param sw_p pointer to switch instance
 */
int sw_check(GpiCore *sw_p) {
   int s;
   s = sw_p->read(0);
   return s;
}

/**
 * Test pattern in 7-segment LEDs
 * @param sseg_p pointer to 7-seg LED instance
 */
void sseg_check(SsegCore *sseg_p, float temperature, char unit) {

   // Number
   int tens, ones, tenths, hundredths;
   tens = (int)temperature / 10;
   ones = (int)temperature % 10;
   tenths = ((int) (temperature * 10) % 100) % 10;
   hundredths = (((int) (temperature * 100) % 1000) % 100) % 10;

   // Unit
   int unit_hex;
   if (unit == 'f') {
       unit_hex = sseg_p->h2s(15);
   }
   else {
       unit_hex = sseg_p->h2s(12);
   }

   // Right Side
   sseg_p->write_1ptn(0xff, 0);
   sseg_p->write_1ptn(0xff, 1);
   sseg_p->write_1ptn(0xff, 2);
   sseg_p->write_1ptn(unit_hex, 3);

   // Left Side
   sseg_p->write_1ptn(sseg_p->h2s(hundredths), 4);
   sseg_p->write_1ptn(sseg_p->h2s(tenths), 5);
   sseg_p->write_1ptn(sseg_p->h2s(ones), 6);
   sseg_p->write_1ptn(sseg_p->h2s(tens), 7);

   // Always use 2 decimal points, therefore here
   sseg_p->set_dp(0x40);
   sleep_ms(50);
}

/*
 * read temperature from adt7420
 * @param adt7420_p pointer to adt7420 instance
 */
float adt7420_check(I2cCore *adt7420_p) {
   const uint8_t DEV_ADDR = 0x4b;
   uint8_t wbytes[2], bytes[2];
   //int ack;
   uint16_t tmp;
   float tmpC;

   // read adt7420 id register to verify device existence
   // ack = adt7420_p->read_dev_reg_byte(DEV_ADDR, 0x0b, &id);

   wbytes[0] = 0x0b;
   adt7420_p->write_transaction(DEV_ADDR, wbytes, 1, 1);
   adt7420_p->read_transaction(DEV_ADDR, bytes, 1, 0);
   uart.disp("read ADT7420 id (should be 0xcb): ");
   uart.disp(bytes[0], 16);
   uart.disp("\n\r");
   //debug("ADT check ack/id: ", ack, bytes[0]);
   // read 2 bytes
   //ack = adt7420_p->read_dev_reg_bytes(DEV_ADDR, 0x0, bytes, 2);
   wbytes[0] = 0x00;
   adt7420_p->write_transaction(DEV_ADDR, wbytes, 1, 1);
   adt7420_p->read_transaction(DEV_ADDR, bytes, 2, 0);

   // conversion
   tmp = (uint16_t) bytes[0];
   tmp = (tmp << 8) + (uint16_t) bytes[1];
   if (tmp & 0x8000) {
      tmp = tmp >> 3;
      tmpC = (float) ((int) tmp - 8192) / 16;
   } else {
      tmp = tmp >> 3;
      tmpC = (float) tmp / 16;
   }
   uart.disp("temperature (C): ");
   uart.disp(tmpC);
   uart.disp("\n\r");

   sleep_ms(50);

   return tmpC;
}

float celsius_to_fahrenheit(float temperature) {
    return (temperature * (9.0/5.0)) + 32;
}

// instantiate switch, led
GpiCore sw(get_slot_addr(BRIDGE_BASE, S3_SW));
SsegCore sseg(get_slot_addr(BRIDGE_BASE, S8_SSEG));
I2cCore adt7420(get_slot_addr(BRIDGE_BASE, S10_I2C));

int main() {
   float temperature;
   char unit = 'c';
   int sw_val;

   while (1) {
      // Get temp from sensor
      temperature = adt7420_check(&adt7420);      

      // Switch C or F
      sw_val = sw_check(&sw);
      if (sw_val == 1) {
          temperature = celsius_to_fahrenheit(temperature);
          unit = 'f';
      }
      else {
          unit = 'c';
      }

      // Display Temp
      sseg_check(&sseg, temperature, unit);
   } //while
} //main


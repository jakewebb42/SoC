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
#include <cstdlib>

/**
 * check pwm output on JA_top3
 */

void pwm_check(PwmCore *pwm_p) {
   pwm_p->set_freq(50);

   for (int i = 0; i < 10; i++) {

     pwm_p->set_duty(0.05+(i/100.0), 0);
     pwm_p->set_duty(0.05+(i/100.0), 1);
     pwm_p->set_duty(0.05+(i/100.0), 2);
     pwm_p->set_duty(0.05+(i/100.0), 3);
     pwm_p->set_duty(0.05+(i/100.0), 4);
     sleep_ms(1000);
   }
}

void drive(PwmCore *pwm_p, int direction) {
   
   /* Init */
   const double PULSE_REVERSE_MS = 2.0;   
   const double PULSE_STOP_MS    = 1.5;
   const double PULSE_FORWARD_MS = 1.0;
   const double TOTAL_PULSE_MS   = 20.0;

   if (direction==0) {
     // Forward
     pwm_p->set_duty_wheels(PULSE_FORWARD_MS/TOTAL_PULSE_MS);      
   }
   else if (direction==1) { 
     // Stop
     pwm_p->set_duty_wheels(PULSE_STOP_MS/TOTAL_PULSE_MS);  
   }
   else if (direction==2) {
     // Reverse 
     pwm_p->set_duty_wheels(PULSE_REVERSE_MS/TOTAL_PULSE_MS); 
   }
}

void steer(PwmCore *pwm_p, int direction) {
   
   /* Init */
   const double PULSE_RIGHT_MS  = 2.0;   
   const double PULSE_CENTER_MS = 1.5;
   const double PULSE_LEFT_MS   = 1.0;
   const double TOTAL_PULSE_MS  = 20.0;
   const int STEER_CHANNEL = 4;

   if (direction==0) {
     // Left
     pwm_p->set_duty(PULSE_LEFT_MS/TOTAL_PULSE_MS, STEER_CHANNEL);      
   }
   else if (direction==1) { 
     // Center
     pwm_p->set_duty(PULSE_CENTER_MS/TOTAL_PULSE_MS, STEER_CHANNEL);  
   }
   else if (direction==2) {
     // Right
     pwm_p->set_duty(PULSE_RIGHT_MS/TOTAL_PULSE_MS, STEER_CHANNEL); 
   }
   sleep_ms(1000);
}

// instantiate pwm
PwmCore pwm(get_slot_addr(BRIDGE_BASE, S6_PWM));

int main() {

   while (1) {
      //pwm_check(&pwm);           
      drive(&pwm,0); // Forward
      steer(&pwm,0); // Left

      drive(&pwm, 1); // Stopped, aka motors not running
      steer(&pwm, 1); // Center, aka driving forward

      drive(&pwm, 2); // Backward
      steer(&pwm, 2); // Right

   } //while
} //main

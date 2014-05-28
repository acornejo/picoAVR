#include <avr/io.h>
#include <util/delay.h>

void led_setup() {
    DDRB |= (1<<PB5);
}

void led_on() {
    PORTB |= (1<<PB5);
}

void led_off() {
    PORTB &= ~(1<<PB5);
}

int main() {
    uint8_t led = 0;
    led_setup();
    while (1) {
        _delay_ms(1000);
        led = !led;
        if (led)
            led_on();
        else
            led_off();
    }

    return 0;
}

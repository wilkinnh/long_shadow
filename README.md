# long_shadow

Flutter widget that implements the [long shadow design pattern](https://designmodo.com/long-shadows-design/).

Tested with an iPhone 8, but should work with Android as well.

## Demo

Sample app is hooked up to the device's gyro sensors, allowing you to change the shadow angle by tilting the phone left and right.

![GIF of demo app](/images/demo.gif)

## Getting Started

The `LongShadow` widget has 3 parameters:

- text: `Text` widget that should contain text string, font size and color.
- angle: float value between -1 and 1. -1 will create a shadow to the bottom right, 1 will create a shadow to the bottom left.
- color: starting shadow color. This will automatically fade to an opacity of 0 at the bottom of the shadow.

## Other Examples

### Playground

Test out long shadows with different text, font size, and shadow angles. This also includes gyro support.

https://github.com/wilkinnh/long_shadow_playground

<img src="/images/playground.png" width="320">

### Periodic Table

Example app using long shadows with the periodic table.

https://github.com/wilkinnh/periodic_table_long_shadow

<img src="/images/periodic-table.gif" width="360">

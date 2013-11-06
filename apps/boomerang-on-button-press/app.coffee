class BoomerangDemo
  constructor: ->
    clearInterval()

  useSeconds: 1000

  running: false

  main: =>
    led.write 0  for key, led of @leds
    setWatch @handleClick, BTN, repeat: true, edge:'rising'
    setTimeout ->
      @handleClick()
    , 100

  easeLed: (led, i) =>
    setTimeout ->
      led.write 1
      setTimeout ->
        led.write 0
      , 100
    , 100 * i

  handleClick: =>
    return if @running
    i = 0
    @easeLed led, i++ for key, led of @leds

class App
  constructor: ->
    demo = new BoomerangDemo()
    demo.leds = {
      LED1
      LED3
      LED5
      LED7
      LED8
      LED6
      LED4
      LED2
    }
    demo.main()

new App()

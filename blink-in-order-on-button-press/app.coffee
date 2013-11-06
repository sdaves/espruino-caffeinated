class BlinkInOrderDemo
  constructor: ->
    clearInterval()
    setWatch @handleClick, BTN, repeat: true, edge:'rising'

  useSeconds: 1000

  currentLedsIndex: -1

  leds: []

  ledsKeys: []

  handleClick: =>
    if not @ledsKeys.length then @ledsKeys = Object.keys @leds

    if not @ledsKeys.length then return

    if @currentLedsIndex > -1
      @leds[@ledsKeys[@currentLedsIndex]].write(0)
      @currentLedsIndex++

    if @currentLedsIndex in [@ledsKeys.length, -1]
      @currentLedsIndex = 0

    @leds[@ledsKeys[@currentLedsIndex]].write(1)

class App
  constructor: ->
    demo = new BlinkInOrderDemo()
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

new App()

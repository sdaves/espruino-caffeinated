class BlinkInOrderDemo
  constructor: ->
    clearInterval()

  useSeconds: 1000

  currentLedsIndex: -1

  leds: []

  ledsKeys: []

  handleClick: =>
    if not @ledsKeys.length then return

    if @currentLedsIndex > -1
      @leds[@ledsKeys[@currentLedsIndex]].write 0
      @currentLedsIndex++

    if @currentLedsIndex in [@ledsKeys.length, -1]
      @currentLedsIndex = 0

    @leds[@ledsKeys[@currentLedsIndex]].write 1

  main: =>
    if not @ledsKeys.length then @ledsKeys = Object.keys @leds
    if @ledsKeys.length
      setWatch @handleClick, BTN, repeat: true, edge:'rising'
      setTimeout ->
        @leds[@ledsKeys[0]].write 1
        @currentLedsIndex = 0
      , 100

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
    demo.main()

new App()

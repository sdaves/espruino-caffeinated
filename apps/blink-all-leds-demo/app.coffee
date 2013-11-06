class BlinkAllLedsDemo
  constructor: ->
    clearInterval()

  useSeconds: 1000

  writeLedRandom: (led, noWait) ->
    noWait = if noWait then 0 else 1
    rand = @random()
    setTimeout =>
      booleanSeed = @random() > 0.8
      led.write booleanSeed
      @writeLedRandom(led)
    , rand * @useSeconds * noWait

  random: ->
    randNums = Math.sin(getTime()).toString().substring(6)
    parseFloat '0.' + randNums

  main: =>
    for key, led of @leds
      led.write(0)
      @writeLedRandom led, true

class App
  constructor: ->
    demo = new BlinkAllLedsDemo()
    demo.leds = {
      LED1
      LED2
      LED3
      LED4
      LED5
      LED6
      LED7
      LED8
    }

    demo.main()

new App()

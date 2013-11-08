class RgbLedSmoothTransition
  constructor: ->
    reset()
    clearInterval()

  interval: 1000

  lastUseColor: {}

  useColor: {}

  getRandomColor: =>
    getLet = -> @random() * 255
    r: getLet(), g: getLet(), b: getLet()

  random: ->
    parseFloat '0.' + Math.sin(getTime()).toString().substring(6)

  buttonPressed: =>
    @useColor = r:0, g:0, b:0
    clearInterval()
    @doLights()

  code: (codes) ->
    out = ""
    for key, val of codes
      out += String.fromCharCode val
    out

  transitionToColor: =>
    steps = @interval / 50.0

    rDiff = @useColor.r - @lastUseColor.r
    gDiff = @useColor.g - @lastUseColor.g
    bDiff = @useColor.b - @lastUseColor.b

    ledArray = [0..@numLeds]
    stepsArray = [0..steps]

    stepsArray.forEach (item) =>
      currentColor = @code
        r: @lastUseColor.r + rDiff / steps * item
        g: @lastUseColor.g + gDiff / steps * item
        b: @lastUseColor.b + bDiff / steps * item

      out = ""

      ledArray.forEach ->
        out += currentColor

      @sendWithSpi out

    @lastUseColor = @useColor
    @useColor = @getRandomColor()

  sendWithSpi: (out) ->
    SPI1.send4bit out, 0b0001, 0b0011

  setupSpi: (pin) ->
    SPI1.setup baud: 3200000, mosi: pin

  doLights: =>
    setInterval @transitionToColor, @interval
    setTimeout @transitionToColor, 1

  main: =>
    @useColor = r:20, g:10, b:15
    setWatch @buttonPressed, BTN, repeat: true, edge:'rising'
    @setupSpi B5
    @doLights()

class App
  constructor: ->
    @demo.numLeds = 50
    @demo.main()

  demo: new RgbLedSmoothTransition()

app = new App()


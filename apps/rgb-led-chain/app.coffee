class RgbLedChain
  constructor: ->
    reset()
    clearInterval()

  interval: 40

  curLight: 0

  forward: true

  useColor: ""

  getRandomColor: =>
    getLet = ->
      String.fromCharCode Math.floor @random() * 255
    getLet() + getLet() + getLet()

  random: ->
    randNums = Math.sin(getTime()).toString().substring(6)
    parseFloat '0.' + randNums

  buttonPressed: =>
    @useColor = @getRandomColor()

  code: (codes) ->
    out = ""
    for key, val of codes
      out += String.fromCharCode val
    out

  writeOnlyColor: (num, code=false) =>
    out = ""
    i = -1

    while i < @numLeds - 1
      i++
      if i is num
        out += if code then code else @useColor
      else
        out += @black

    SPI1.send4bit out, 0b0001, 0b0011
    if @forward
      @curLight += 1
    else
      @curLight -= 1

  setupSpi: (pin) ->
    SPI1.setup baud: 3200000, mosi: pin

  doLights: =>
    setInterval ->

      if @curLight is @numLeds + 1
        @forward = false
        @curLight -= 1
      else if @curLight < 0
        @forward = true
        @curLight += 1
      else
        @writeOnlyColor @curLight

    , @interval

  main: =>
    @useColor = @code {r:20, g:10, b:15}
    num = String.fromCharCode 0
    @black = num + num + num
    setWatch @buttonPressed, BTN, repeat: true, edge:'rising'
    @setupSpi B5
    @doLights()

class App
  constructor: ->
    @demo.numLeds = 50
    @demo.main()

  demo: new RgbLedChain()

app = new App()

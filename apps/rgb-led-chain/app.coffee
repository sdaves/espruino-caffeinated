class RgbLedChain
  constructor: ->
    reset()
    clearInterval()

  interval: 20

  curLight: 0

  restartLights: =>
    console.log 'button pressed'
    @curLight = 0

  code: (codes) ->
    out = ""
    for key, val of codes
      out += String.fromCharCode val
    out

  writeOnlyColor: (num, code) =>
    out = ""
    i = -1

    while i < @numLeds - 1
      i++
      if i is num
        out += code
      else
        out += @black

    SPI1.send4bit out, 0b0001, 0b0011
    @curLight += 1

  setupSpi: (pin) ->
    SPI1.setup baud: 3200000, mosi: pin

  doLights: =>
    setInterval ->
      if @curLight < @numLeds
        @writeOnlyColor @curLight, @code {r:20, g:10, b:15}
      else
        @writeOnlyColor @curLight, @black
    , @interval

  main: =>
    num = String.fromCharCode 0
    @black = num + num + num
    setWatch @restartLights, BTN, repeat: true, edge:'rising'
    @setupSpi B5
    @doLights()

class App
  constructor: ->
    @demo = new RgbLedChain()
    @demo.numLeds = 50
    @demo.main()

app = new App()

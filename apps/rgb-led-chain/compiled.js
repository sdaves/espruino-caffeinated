// Generated by CoffeeScript 1.6.3
var App, RgbLedChain, app,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

RgbLedChain = (function() {
  function RgbLedChain() {
    this.main = __bind(this.main, this);
    this.doLights = __bind(this.doLights, this);
    this.writeOnlyColor = __bind(this.writeOnlyColor, this);
    this.buttonPressed = __bind(this.buttonPressed, this);
    this.getRandomColor = __bind(this.getRandomColor, this);
    reset();
    clearInterval();
  }

  RgbLedChain.prototype.interval = 40;

  RgbLedChain.prototype.curLight = 0;

  RgbLedChain.prototype.forward = true;

  RgbLedChain.prototype.useColor = "";

  RgbLedChain.prototype.getRandomColor = function() {
    var getLet;
    getLet = function() {
      return String.fromCharCode(Math.floor(this.random() * 255));
    };
    return getLet() + getLet() + getLet();
  };

  RgbLedChain.prototype.random = function() {
    var randNums;
    randNums = Math.sin(getTime()).toString().substring(6);
    return parseFloat('0.' + randNums);
  };

  RgbLedChain.prototype.buttonPressed = function() {
    return this.useColor = this.getRandomColor();
  };

  RgbLedChain.prototype.code = function(codes) {
    var key, out, val;
    out = "";
    for (key in codes) {
      val = codes[key];
      out += String.fromCharCode(val);
    }
    return out;
  };

  RgbLedChain.prototype.writeOnlyColor = function(num, code) {
    var i, out;
    if (code == null) {
      code = false;
    }
    out = "";
    i = -1;
    while (i < this.numLeds - 1) {
      i++;
      if (i === num) {
        out += code ? code : this.useColor;
      } else {
        out += this.black;
      }
    }
    SPI1.send4bit(out, 0x1, 0x3);
    if (this.forward) {
      return this.curLight += 1;
    } else {
      return this.curLight -= 1;
    }
  };

  RgbLedChain.prototype.setupSpi = function(pin) {
    return SPI1.setup({
      baud: 3200000,
      mosi: pin
    });
  };

  RgbLedChain.prototype.doLights = function() {
    return setInterval(function() {
      if (this.curLight === this.numLeds + 1) {
        this.forward = false;
        return this.curLight -= 1;
      } else if (this.curLight < 0) {
        this.forward = true;
        return this.curLight += 1;
      } else {
        return this.writeOnlyColor(this.curLight);
      }
    }, this.interval);
  };

  RgbLedChain.prototype.main = function() {
    var num;
    this.useColor = this.code({
      r: 20,
      g: 10,
      b: 15
    });
    num = String.fromCharCode(0);
    this.black = num + num + num;
    setWatch(this.buttonPressed, BTN, {
      repeat: true,
      edge: 'rising'
    });
    this.setupSpi(B5);
    return this.doLights();
  };

  return RgbLedChain;

})();

App = (function() {
  function App() {
    this.demo.numLeds = 50;
    this.demo.main();
  }

  App.prototype.demo = new RgbLedChain();

  return App;

})();

app = new App();

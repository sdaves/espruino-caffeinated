// Generated by CoffeeScript 1.6.3
var App, RgbLedSmoothTransition, app,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

RgbLedSmoothTransition = (function() {
  function RgbLedSmoothTransition() {
    this.main = __bind(this.main, this);
    this.doLights = __bind(this.doLights, this);
    this.transitionToColor = __bind(this.transitionToColor, this);
    this.buttonPressed = __bind(this.buttonPressed, this);
    this.getRandomColor = __bind(this.getRandomColor, this);
    reset();
    clearInterval();
  }

  RgbLedSmoothTransition.prototype.interval = 1000;

  RgbLedSmoothTransition.prototype.lastUseColor = {};

  RgbLedSmoothTransition.prototype.useColor = {};

  RgbLedSmoothTransition.prototype.getRandomColor = function() {
    var getLet;
    getLet = function() {
      return this.random() * 255;
    };
    return {
      r: getLet(),
      g: getLet(),
      b: getLet()
    };
  };

  RgbLedSmoothTransition.prototype.random = function() {
    return parseFloat('0.' + Math.sin(analogRead(A1)).toString().substring(6));
  };

  RgbLedSmoothTransition.prototype.buttonPressed = function() {
    this.useColor = {
      r: 0,
      g: 0,
      b: 0
    };
    clearInterval();
    return this.doLights();
  };

  RgbLedSmoothTransition.prototype.code = function(codes) {
    var key, out, val;
    out = "";
    for (key in codes) {
      val = codes[key];
      out += String.fromCharCode(val);
    }
    return out;
  };

  RgbLedSmoothTransition.prototype.transitionToColor = function() {
    var bDiff, gDiff, ledArray, rDiff, steps, stepsArray, _i, _j, _ref, _results, _results1,
      _this = this;
    steps = this.interval / 50.0;
    rDiff = this.useColor.r - this.lastUseColor.r;
    gDiff = this.useColor.g - this.lastUseColor.g;
    bDiff = this.useColor.b - this.lastUseColor.b;
    ledArray = (function() {
      _results = [];
      for (var _i = 0, _ref = this.numLeds; 0 <= _ref ? _i <= _ref : _i >= _ref; 0 <= _ref ? _i++ : _i--){ _results.push(_i); }
      return _results;
    }).apply(this);
    stepsArray = (function() {
      _results1 = [];
      for (var _j = 0; 0 <= steps ? _j <= steps : _j >= steps; 0 <= steps ? _j++ : _j--){ _results1.push(_j); }
      return _results1;
    }).apply(this);
    stepsArray.forEach(function(item) {
      var currentColor, out;
      currentColor = _this.code({
        r: _this.lastUseColor.r + rDiff / steps * item,
        g: _this.lastUseColor.g + gDiff / steps * item,
        b: _this.lastUseColor.b + bDiff / steps * item
      });
      out = "";
      ledArray.forEach(function() {
        return out += currentColor;
      });
      return _this.sendWithSpi(out);
    });
    this.lastUseColor = this.useColor;
    return this.useColor = this.getRandomColor();
  };

  RgbLedSmoothTransition.prototype.sendWithSpi = function(out) {
    return SPI1.send4bit(out, 0x1, 0x3);
  };

  RgbLedSmoothTransition.prototype.setupSpi = function(pin) {
    return SPI1.setup({
      baud: 3200000,
      mosi: pin
    });
  };

  RgbLedSmoothTransition.prototype.doLights = function() {
    setInterval(this.transitionToColor, this.interval);
    return setTimeout(this.transitionToColor, this.random() * 10);
  };

  RgbLedSmoothTransition.prototype.main = function() {
    this.useColor = {
      r: 20,
      g: 10,
      b: 15
    };
    setWatch(this.buttonPressed, BTN, {
      repeat: true,
      edge: 'rising'
    });
    this.setupSpi(B5);
    return this.doLights();
  };

  return RgbLedSmoothTransition;

})();

App = (function() {
  function App() {
    this.demo.numLeds = 50;
    this.demo.main();
  }

  App.prototype.demo = new RgbLedSmoothTransition();

  return App;

})();

app = new App();
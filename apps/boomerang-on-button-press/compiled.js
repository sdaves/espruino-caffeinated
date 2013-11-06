// Generated by CoffeeScript 1.6.3
(function() {
  var App, BoomerangDemo,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  BoomerangDemo = (function() {
    function BoomerangDemo() {
      this.handleClick = __bind(this.handleClick, this);
      this.easeLed = __bind(this.easeLed, this);
      this.main = __bind(this.main, this);
      clearInterval();
    }

    BoomerangDemo.prototype.useSeconds = 1000;

    BoomerangDemo.prototype.running = false;

    BoomerangDemo.prototype.main = function() {
      var key, led, _ref;
      _ref = this.leds;
      for (key in _ref) {
        led = _ref[key];
        led.write(0);
      }
      setWatch(this.handleClick, BTN, {
        repeat: true,
        edge: 'rising'
      });
      return setTimeout(function() {
        return this.handleClick();
      }, 100);
    };

    BoomerangDemo.prototype.easeLed = function(led, i) {
      return setTimeout(function() {
        led.write(1);
        return setTimeout(function() {
          return led.write(0);
        }, 100);
      }, 100 * i);
    };

    BoomerangDemo.prototype.handleClick = function() {
      var i, key, led, _ref, _results;
      if (this.running) {
        return;
      }
      i = 0;
      _ref = this.leds;
      _results = [];
      for (key in _ref) {
        led = _ref[key];
        _results.push(this.easeLed(led, i++));
      }
      return _results;
    };

    return BoomerangDemo;

  })();

  App = (function() {
    function App() {
      var demo;
      demo = new BoomerangDemo();
      demo.leds = {
        LED1: LED1,
        LED3: LED3,
        LED5: LED5,
        LED7: LED7,
        LED8: LED8,
        LED6: LED6,
        LED4: LED4,
        LED2: LED2
      };
      demo.main();
    }

    return App;

  })();

  new App();

}).call(this);
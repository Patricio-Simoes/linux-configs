"""Multiwidget CPU module

Can display any combination of:

    * max CPU frequency
    * total CPU load in percents (integer value)
    * per-core CPU load as graph - either mono or colored
    * CPU temperature (in Celsius degrees)
    * CPU fan speed

Requirements:

    * the psutil Python module for the first three items from the list above
    * sensors executable for the rest

Parameters:
    * cpu3.layout: Space-separated list of widgets to add.
      Possible widgets are:

         * cpu3.maxfreq
         * cpu3.cpuload
         * cpu3.coresload
         * cpu3.temp
         * cpu3.fanspeed
    * cpu3.colored: 1 for colored per core load graph, 0 for mono (default)
    * cpu3.temp_json: json path to look for in the output of 'sensors -j';
      required if cpu3.temp widget is used
    * cpu3.fan_json: json path to look for in the output of 'sensors -j';
      required if cpu3.fanspeed widget is used

Note: if you are getting 'n/a' for CPU temperature / fan speed, then you're
lacking the aforementioned json path settings or they have wrong values.

Example json paths:
  * `cpu3.temp_json="coretemp-isa-0000.Package id 0.temp1_input"`
  * `cpu3.fan_json="thinkpad-isa-0000.fan1.fan1_input"`

contributed by `SuperQ <https://github.com/SuperQ>`
based on cpu2 by `<somospocos <https://github.com/somospocos>`
"""

import json
import psutil

import core.module

import util.cli
import util.graph
import util.format


class Module(core.module.Module):
    def __init__(self, config, theme):
        super().__init__(config, theme, [])

        self.__layout = self.parameter(
            "layout", "cpu3.maxfreq cpu3.cpuload cpu3.coresload cpu3.temp cpu3.fanspeed"
        )
        self.__widget_names = self.__layout.split()
        self.__colored = util.format.asbool(self.parameter("colored", False))
        for widget_name in self.__widget_names:
            if widget_name == "cpu3.maxfreq":
                widget = self.add_widget(name=widget_name, full_text=self.maxfreq)
                widget.set("type", "freq")
            elif widget_name == "cpu3.cpuload":
                widget = self.add_widget(name=widget_name, full_text=self.cpuload)
                widget.set("type", "load")
            elif widget_name == "cpu3.coresload":
                widget = self.add_widget(name=widget_name, full_text=self.coresload)
                widget.set("type", "loads")
            elif widget_name == "cpu3.temp":
                widget = self.add_widget(name=widget_name, full_text=self.temp)
                widget.set("type", "temp")
            elif widget_name == "cpu3.fanspeed":
                widget = self.add_widget(name=widget_name, full_text=self.fanspeed)
                widget.set("type", "fan")
            if self.__colored:
                widget.set("pango", True)
        self.__temp_json = self.parameter("temp_json")
        if self.__temp_json is None:
            self.__temp = "n/a"
        self.__fan_json = self.parameter("fan_json")
        if self.__fan_json is None:
            self.__fan = "n/a"
        # maxfreq is loaded only once at startup
        if "cpu3.maxfreq" in self.__widget_names:
            self.__maxfreq = psutil.cpu_freq().max / 1000

    def maxfreq(self, _):
        return "{:.2f}GHz".format(self.__maxfreq)

    def cpuload(self, _):
        return "{:>3}%".format(self.__cpuload)

    def add_color(self, bar):
        """add color as pango markup to a bar"""
        if bar in ["▁", "▂"]:
            color = self.theme.color("green", "green")
        elif bar in ["▃", "▄"]:
            color = self.theme.color("yellow", "yellow")
        elif bar in ["▅", "▆"]:
            color = self.theme.color("orange", "orange")
        elif bar in ["▇", "█"]:
            color = self.theme.color("red", "red")
        colored_bar = '<span foreground="{}">{}</span>'.format(color, bar)
        return colored_bar

    def coresload(self, _):
        mono_bars = [util.graph.hbar(x) for x in self.__coresload]
        if not self.__colored:
            return "".join(mono_bars)
        colored_bars = [self.add_color(x) for x in mono_bars]
        return "".join(colored_bars)

    def temp(self, _):
        if self.__temp == "n/a" or self.__temp == 0:
            return "n/a"
        return "{}°C".format(self.__temp)

    def fanspeed(self, _):
        if self.__fanspeed == "n/a":
            return "n/a"
        return "{}RPM".format(self.__fanspeed)

    def _parse_sensors_output(self):
        output = util.cli.execute("sensors -j")
        json_data = json.loads(output)

        temp = "n/a"
        fan = "n/a"
        temp_json = json_data
        fan_json = json_data
        for path in self.__temp_json.split('.'):
            temp_json = temp_json[path]
        for path in self.__fan_json.split('.'):
            fan_json = fan_json[path]
        if temp_json is not None:
            temp = float(temp_json)
        if fan_json is not None:
            fan = int(fan_json)
        return temp, fan

    def update(self):
        if "cpu3.maxfreq" in self.__widget_names:
            self.__maxfreq = psutil.cpu_freq().max / 1000
        if "cpu3.cpuload" in self.__widget_names:
            self.__cpuload = round(psutil.cpu_percent(percpu=False))
        if "cpu3.coresload" in self.__widget_names:
            self.__coresload = psutil.cpu_percent(percpu=True)
        if "cpu3.temp" in self.__widget_names or "cpu3.fanspeed" in self.__widget_names:
            self.__temp, self.__fanspeed = self._parse_sensors_output()

    def state(self, widget):
        """for having per-widget icons"""
        return [widget.get("type", "")]


# vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4

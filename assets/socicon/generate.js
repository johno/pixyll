
    \#!/usr/bin/env node

    var icons = require('./icons.json');

    for (var i = 0; i < icons.length; i++) {
        var icon = icons[i];
        console.log("." + icon.id + " { color: " + icon.color + "; }");
    };
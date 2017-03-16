(function() {
    'use strict';

    // inject elm
    var Elm = require('./Main');
    Elm.Main.embed(document.getElementById('app'), { apiUrl: process.env.API_URL });
})();

cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/cordova-plugin-voiceit/www/VoiceItCordova.js",
        "id": "cordova-plugin-voiceit.VoiceItCordova",
        "clobbers": [
            "window.plugins.VoiceItCordova"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "cordova-plugin-voiceit": "1.3.2"
};
// BOTTOM OF METADATA
});
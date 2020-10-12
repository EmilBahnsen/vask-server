// Language
function localize(language) {
    language = language.substr(0,2)
    if (['en', 'da'].includes(language)) {
        let lang = ':lang(' + language + ')';
        let hide = '[lang]:not(' + lang + ')';
        document.querySelectorAll(hide).forEach(function (node) {
            node.style.display = 'none';
        });
        let show = '[lang]' + lang;
        document.querySelectorAll(show).forEach(function (node) {
            node.style.display = 'unset';
        });
    }
}


// Accepts a string; returns the string with regex metacharacters escaped. The returned string
// can safely be used at any point within a regex to match the provided literal string. Escaped
// characters are [ ] { } ( ) * + ? - . , \ ^ $ | # and whitespace
RegExp.escape = function (str) {
    return str.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&");
};

/**
 * @return {int} bytes length of the string
 */
String.len = function(s) {
    return String(s).replace(/[^\x20-\x7e]/g, '**').length; // make full-width characters count twice
}

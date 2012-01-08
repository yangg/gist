/**
 * Create a namespace
 * @param {String} names
 * @return {Object} A reference to the last namespace object created
 */
function namespace(names) {
    var parts = names.split('.'),
        root = window, i = 0, len = parts.length,
        currentPart;
    while(i < len) {
        currentPart = parts[i++];
        root[currentPart] = root[currentPart] || {};
        root = root[currentPart];
    }
    return root;
}

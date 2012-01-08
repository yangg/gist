function ellipsis(str, len) {
    var i = 0, j = 0, tmp = '', ch;
    while(i < str.length) {
        ch = str.charAt(i++);
        j += (/[^\x20-\x7e]/.test(ch)) ? 2 : 1;
        if(j > len) { break; }
        tmp += ch;
    }
    return tmp + (tmp.length == str.length ? '' : '...'); // &hellip;
}

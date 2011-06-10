package de.viaboxx.flexboxx {
import mx.utils.StringUtil;

public function formatHex(color:uint):String {
    const colorString:String =
            color.toString(16).toUpperCase();
    return "0x" + StringUtil.repeat("0", 6 - colorString.length) + colorString;
}
}
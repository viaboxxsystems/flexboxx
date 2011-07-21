package de.viaboxx.flexboxx {
import mx.formatters.NumberFormatter;
import mx.graphics.GradientEntry;
import mx.utils.StringUtil;

public class FilterSourceGenerator {
    private var formatter:NumberFormatter;

    public function FilterSourceGenerator() {
        formatter = new NumberFormatter();
        formatter.decimalSeparatorTo = ".";
        formatter.precision = 2;
    }

    public function sourceForFilter(filter:*, id:String=null, namespacePrefix:String = "s"):String {
        var filterDescription:FilterDescription = FilterDescription.forFilter(filter);
        var source:String = "<" + namespacePrefix + ":" + filterDescription.className;
        if(id){
            source+=StringUtil.substitute('\nid="{0}"',id);
        }
        var fistAttribute:Boolean = true;
        filterDescription.forEachProperty(function(property:Property):void {
            if (fistAttribute) {
                source += "\n";
                fistAttribute = false;
            }
            source += property.name + '="' + format(filter[property.name], property) + '"\n';
        });
        source += "/>";
        return source;
    }


    private function format(value:*, property:Property):String {
        const dataType:Class = property.dataType;
        switch (dataType) {
            case Array:
                if (property.arrayType == GradientEntry) {
                    var returnString:String ="{[";
                    value.forEach(function(item:GradientEntry, index:int, array:Array):void {
                        returnString +=  "new GradientEntry(";
                        returnString += formatHex(item.color);
                        returnString += ",";
                        returnString += formatter.format(item.ratio);
                        returnString += ",";
                        returnString += formatter.format(item.alpha);
                        returnString +=")";
                        if(index == array.length -2){
                            returnString +=",";
                        }
                    });
                }
                return returnString+"]}";
                break;
            case Number:
                return formatter.format(value);
            case uint:
                return formatHex(value);
            default:
                return value==null? "null": value.toString();
        }
    }
}
}
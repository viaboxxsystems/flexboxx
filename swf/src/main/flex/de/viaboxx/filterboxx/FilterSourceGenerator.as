package de.viaboxx.filterboxx {
import mx.filters.IBitmapFilter;
import mx.formatters.NumberFormatter;

public class FilterSourceGenerator {

    public function FilterSourceGenerator() {
        //empty constructor
    }

    public function sourceForFilter(filter:IBitmapFilter, namespacePrefix:String = "s"):String {
        var filterDescription:FilterDescription = FilterDescription.forFilter(filter);
        var source:String = "<" + namespacePrefix + ":" + filterDescription.className;
        var fistAttribute:Boolean = true;
        filterDescription.forEachProperty(function(property:FilterProperty):void {
            if (fistAttribute) {
                source += "\n";
                fistAttribute = false;
            }
            source += property.name + '="' + format(filter[property.name], property.dataType) + '"\n';
        });
        source += "/>";
        return source;
    }

    private function format(value:*, dataType:Class):String {
        switch (dataType) {
            case Number:
                var formatter:NumberFormatter = new NumberFormatter();
                formatter.decimalSeparatorTo = ".";
                formatter.precision = 2;
                return formatter.format(value);
            case uint:
                return formatHex(value);
            default:
                return value.toString();
        }
    }
}
}
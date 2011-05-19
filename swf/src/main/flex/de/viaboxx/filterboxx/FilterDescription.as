package de.viaboxx.filterboxx {
import flash.utils.Dictionary;
import flash.utils.describeType;
import flash.utils.getDefinitionByName;

import mx.filters.IBitmapFilter;

public class FilterDescription {

    public var filter:IBitmapFilter;
    private const propertiesByName:Dictionary = new Dictionary();


    public function FilterDescription() {
    }

    private function setPropertyAttribute(attribute:String, inspectable:XML):Number {
        // TODO fhd: Inefficient!
        var arg:XML = null;
        for each (var xml:XML in inspectable.arg) {
            if (xml.hasOwnProperty("@key") && xml.@key.toString() == attribute) {
                arg = xml;
            }
        }
        if (arg) {
            var value:Number = parseFloat(arg.@value.toString());
            if (value) {
                return value;
            }
        }
        return null;
    }

    private function analyzeFilter(filter:IBitmapFilter):void {
        var accessor:XML,
                propertyName:String,
                typeName:String,
                property:FilterProperty,
                inspectable:XML;
        const description:XML = describeType(filter);
        this.filter = filter;
        for each (accessor in description.accessor) {
            propertyName = accessor.@name.toString();
            typeName = accessor.@type.toString();
            property = new FilterProperty(propertyName, getDefinitionByName(typeName) as Class);
            for each(inspectable in accessor.metadata.(@name == "Inspectable")) {
                if (inspectable) {
                    property.minValue = setPropertyAttribute("minValue", inspectable);
                    property.maxValue = setPropertyAttribute("maxValue", inspectable);
                }
            }
            propertiesByName[propertyName] = property;
        }
    }

    public static function forFilter(filter:IBitmapFilter):FilterDescription {
        var descriptionForFilter:FilterDescription = new FilterDescription();
        descriptionForFilter.analyzeFilter(filter);
        return descriptionForFilter;
    }

    public function getProperty(propertyName:String):FilterProperty {
        return propertiesByName[propertyName];
    }

    public function forEachProperty(callForEachProperty:Function):void {
        // TODO fhd: Inefficient!
        var sortedProperties:Array = new Array();
        for each (var property:FilterProperty in propertiesByName) {
            sortedProperties.push(property);
        }
        sortedProperties.sort(function(a, b):int {
            if (a.name < b.name) {
                return -1;
            }
            if (a.name > b.name) {
                return 1;
            }
            return 0;
        });
        for each (var property:FilterProperty in sortedProperties) {
            callForEachProperty(property);
        }
    }
}

}
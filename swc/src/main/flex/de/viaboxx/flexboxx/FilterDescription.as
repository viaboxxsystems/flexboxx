package de.viaboxx.flexboxx {
import flash.utils.Dictionary;
import flash.utils.describeType;
import flash.utils.getDefinitionByName;

import mx.filters.IBitmapFilter;

public class FilterDescription {

    public var filter:*;
    private const propertiesByName:Dictionary = new Dictionary();

    public var className:String;

    public function FilterDescription() {
    }

    private function setPropertyAttribute(attribute:String, inspectable:XML, targetType:Class = null):* {
        // TODO fhd: Inefficient!
        if (targetType == null) {
            targetType = Number;
        }
        var arg:XML = null;
        for each (var xml:XML in inspectable.arg) {
            if (xml.hasOwnProperty("@key") && xml.@key.toString() == attribute) {
                arg = xml;
            }
        }
        if (arg) {
            var rawValue:String = arg.@value.toString();
            switch (targetType) {
                case Number:
                    var value:Number = parseFloat(rawValue);
                    if (value) {
                        return value;
                    }
                    break;
                case Class:
                    var clazz:Class = getDefinitionByName(rawValue) as Class;
                    if (clazz) {
                        return clazz;
                    }
                    break;
            }
        }
        return null;
    }

    private function analyzeFilter(filter:*):void {
        var accessor:XML,
                propertyName:String,
                typeName:String,
                property:Property,
                inspectable:XML,
                filterType:String;

        const description:XML = describeType(filter);
        this.filter = filter;
        filterType = description.@name.toString();
        if (filterType.lastIndexOf(":") != -1) {
            className = filterType.substr(filterType.lastIndexOf(":") + 1);
        } else {
            className = filterType;
        }
        //TODO refactor this to 
        for each (accessor in description.accessor) {
            if(accessor.@access != "readwrite"){
                continue;
            }
            propertyName = accessor.@name.toString();
            typeName = accessor.@type.toString();

            property = new Property(propertyName, getDefinitionByName(typeName) as Class);
            for each(inspectable in accessor.metadata.(@name == "Inspectable")) {
                if (inspectable) {
                    property.minValue = setPropertyAttribute("minValue", inspectable);
                    property.maxValue = setPropertyAttribute("maxValue", inspectable);
                    property.arrayType = setPropertyAttribute("arrayType", inspectable, Class);
                }
            }
            propertiesByName[propertyName] = property;
        }
    }

    public static function forFilter(filter:*):FilterDescription {
        var descriptionForFilter:FilterDescription = new FilterDescription();
        descriptionForFilter.analyzeFilter(filter);
        return descriptionForFilter;
    }

    public function getProperty(propertyName:String):Property {
        return propertiesByName[propertyName];
    }

    public function forEachProperty(callForEachProperty:Function):void {
        // TODO fhd: Inefficient!
        var sortedProperties:Array = new Array();
        var property:Property;
        for each (property in propertiesByName) {
            sortedProperties.push(property);
        }
        sortedProperties.sort(function(a:Property, b:Property):int {
            if (a.name < b.name) {
                return -1;
            }
            if (a.name > b.name) {
                return 1;
            }
            return 0;
        });
        for each (property in sortedProperties) {
            callForEachProperty(property);
        }
    }

    public function addProperty(property:Property):void {
        propertiesByName[property.name] = property;
    }
}

}
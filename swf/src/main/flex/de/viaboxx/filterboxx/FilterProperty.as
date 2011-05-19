package de.viaboxx.filterboxx {
public class FilterProperty {
    public var name:String;
    public var dataType:Class;
    public var minValue:Number;
    public var maxValue:Number;

    public function FilterProperty(name:String, dataType:Class) {
        this.name = name;
        this.dataType = dataType;
    }
}
}
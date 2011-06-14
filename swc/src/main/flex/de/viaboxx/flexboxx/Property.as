package de.viaboxx.flexboxx {
public class Property {
    public var name:String;
    public var displayName:String;
    public var dataType:Class;
    public var minValue:Number = 0;
    public var maxValue:Number;
    public var arrayType:Class;

    public function Property(name:String, dataType:Class) {
        this.name = name;
        this.displayName = name;
        this.dataType = dataType;
    }
}
}
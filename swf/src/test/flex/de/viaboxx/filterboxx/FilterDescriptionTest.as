package de.viaboxx.filterboxx {
import org.flexunit.assertThat;
import org.hamcrest.collection.array;
import org.hamcrest.object.equalTo;

import spark.filters.DropShadowFilter;

[RunWith("org.flexunit.runners.Parameterized")]
public class FilterDescriptionTest {

    public function FilterDescriptionTest() {
        //empty constructor
    }

    public static function propertyNames():Array {
        return [
            ["alpha"],
            ["angle"]
        ];
    }

    public static function propertyTypes():Array {
        return [
            ["alpha", Number],
            ["color", uint],
            ["knockout", Boolean]
        ];
    }


    [Test(dataProvider="propertyNames")]
    public function dropShadowDescriptionPropertyNameIsCorrect(propertyName:String):void {
        assertThat(FilterDescription.forFilter(new DropShadowFilter()).getProperty(propertyName).name, equalTo(propertyName));
    }


    [Test(dataProvider="propertyTypes")]
    public function dropShadowDescriptionDatatypeIsCorrect(propertyName:String, expectedType:Class):void {
        assertThat(FilterDescription.forFilter(new DropShadowFilter()).getProperty(propertyName).dataType, equalTo(expectedType));
    }

    [Test]
    public function iteratingOverFilterDescriptionsWorks():void {
        var desc:FilterDescription = FilterDescription.forFilter(new TestFilter()),
                properties:Array = [];
        desc.forEachProperty(function callme(item:FilterProperty) {
            properties.push(item.name);
        });
        assertThat(properties, array(equalTo("a"), equalTo("b"), equalTo("c")));
    }

    [Test]
    public function minMaxValuesFromMetadataAreCorrect():void {
        var desc:FilterDescription = FilterDescription.forFilter(new TestFilter());
        assertThat(desc.getProperty("b").minValue, equalTo(0.1));
        assertThat(desc.getProperty("b").maxValue, equalTo(1.0));

    }

    [Test]
    public function minMaxValuesFromMetadataAreCorrectForInteger():void {
        var desc:FilterDescription = FilterDescription.forFilter(new TestFilter());
        assertThat(desc.getProperty("a").minValue, equalTo(1));
        assertThat(desc.getProperty("a").maxValue, equalTo(100));
    }


}
}

import flash.filters.BitmapFilter;

import mx.filters.IBitmapFilter;

class TestFilter implements IBitmapFilter {

    private var _a:int, _b:Number, _c:Boolean;

    [Inspectable(minValue="1", maxValue="100")]
    public function get a():int {
        return _a;
    }

    public function get c():Boolean {
        return _c;
    }

    [Inspectable(minValue="0.1", maxValue="1.0")]
    [Inspectable]        
    public function get b():Number {
        return _b;
    }

    public function clone():BitmapFilter {
        return null;
    }
}



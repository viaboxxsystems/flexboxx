package de.viaboxx.filterboxx {
import mx.filters.IBitmapFilter;
import mx.formatters.NumberFormatter;

import org.flexunit.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.text.endsWith;
import org.hamcrest.text.startsWith;

import spark.filters.DropShadowFilter;

public class FilterSourceGeneratorTest {

    public function FilterSourceGeneratorTest() {
        //empty constructor
    }

    [Test]
    public function generateRootTag():void {
        var result:String = rootXMLForFilterDescription(new DropShadowFilter());
        var expected:String = "<s:DropShadowFilter";
        assertThat(result, startsWith(expected));
        assertThat(result, endsWith("/>"));
    }

    [Test]
    public function generateIntAttributesWorks():void {
        assertThat(
                rootXMLForFilterDescription(new IntTestFilter()),
                equalTo('<s:IntTestFilter\na="0"\n/>'));
    }

    [Test]
    public function generateFloatAttributesFormattedCorrectly():void {
        assertThat(rootXMLForFilterDescription(new FloatTestFilter()), equalTo('<s:FloatTestFilter\naFloat="0.00"\nanother="12.23"\n/>'))
    }

    [Test]
    public function generateColorAttributesCorrectly():void {
        assertThat(rootXMLForFilterDescription(new ColorTestFilter()), equalTo('<s:ColorTestFilter\nblack="0x000000"\nblue="0x0000FF"\n/>'));
    }

    [Test]
    public function namespacePrefixIsCustomizable():void {
        assertThat(rootXMLForFilterDescription(new IntTestFilter(), "asd"), startsWith("<asd:"));
    }

    private function rootXMLForFilterDescription(filter:IBitmapFilter, namespacePrefix:String = "s"):String {
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

import flash.filters.BitmapFilter;

import mx.filters.IBitmapFilter;

class IntTestFilter implements IBitmapFilter {

    private var _a:int;

    public function get a():int {
        return _a;
    }

    public function clone():BitmapFilter {
        return null;
    }
}

class FloatTestFilter implements IBitmapFilter {

    private var _aFloat:Number = 0;

    private var _another:Number = 12.23;

    public function get aFloat():Number {
        return _aFloat;
    }


    public function get another():Number {
        return _another;
    }

    public function clone():BitmapFilter {
        return null;
    }
}

class ColorTestFilter implements IBitmapFilter {

    private var _black:uint = 0; //0x000000
    private var _blue:uint = 0x0000FF;


    public function get black():uint {
        return _black;
    }

    public function get blue():uint {
        return _blue;
    }

    public function clone():BitmapFilter {
        return null;
    }
}
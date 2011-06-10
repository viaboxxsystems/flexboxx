package de.viaboxx.flexboxx {
import org.flexunit.assertThat;
import org.hamcrest.object.equalTo;
import org.hamcrest.text.endsWith;
import org.hamcrest.text.startsWith;

import spark.filters.DropShadowFilter;

public class FilterSourceGeneratorTest extends FilterSourceGenerator {

    public function FilterSourceGeneratorTest() {
        //empty constructor
    }

    [Test]
    public function generateRootTag():void {
        var result:String = sourceForFilter(new DropShadowFilter());
        var expected:String = "<s:DropShadowFilter";
        assertThat(result, startsWith(expected));
        assertThat(result, endsWith("/>"));
    }

    [Test]
    public function generateIntAttributesWorks():void {
        assertThat(
                sourceForFilter(new IntTestFilter()),
                equalTo('<s:IntTestFilter\na="0"\n/>'));
    }

    [Test]
    public function generateFloatAttributesFormattedCorrectly():void {
        assertThat(sourceForFilter(new FloatTestFilter()), equalTo('<s:FloatTestFilter\naFloat="0.00"\nanother="12.23"\n/>'))
    }

    [Test]
    public function generateColorAttributesCorrectly():void {
        assertThat(sourceForFilter(new ColorTestFilter()), equalTo('<s:ColorTestFilter\nblack="0x000000"\nblue="0x0000FF"\n/>'));
    }

    [Test]
    public function generatesGradientEntriesCorrectly():void {
        assertThat(sourceForFilter(new GradientEntryTestFilter()), equalTo('<s:GradientEntryTestFilter\nentries="{[new GradientEntry(0x000000,0.00,1.00),new GradientEntry(0xFF0000,1.00,0.50)]}"\n/>'));
    }

    [Test]
    public function namespacePrefixIsCustomizable():void {
        assertThat(sourceForFilter(new IntTestFilter(), "asd"), startsWith("<asd:"));
    }

}
}

import flash.filters.BitmapFilter;

import mx.filters.IBitmapFilter;
import mx.graphics.GradientEntry;

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

class GradientEntryTestFilter implements IBitmapFilter {

    private var _entries:Array = [new GradientEntry(0x000000, 0, 1), new GradientEntry(0xff0000, 1, .5)];

    [Inspectable(arrayType="mx.graphics.GradientEntry")]
    public function get entries():Array {
        return _entries;
    }

    public function clone():BitmapFilter {
        return null;
    }
}
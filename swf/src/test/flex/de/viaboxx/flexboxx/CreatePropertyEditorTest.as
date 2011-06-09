package de.viaboxx.flexboxx {
import mx.controls.ColorPicker;
import mx.graphics.GradientEntry;

import org.flexunit.assertThat;
import org.hamcrest.core.isA;
import org.hamcrest.object.notNullValue;

import spark.components.CheckBox;
import spark.components.Group;
import spark.components.HSlider;
import spark.components.Spinner;

public class CreatePropertyEditorTest {
    public function CreatePropertyEditorTest() {
        //empty constructor
    }

    [Test]
    public function checkboxForBoolean():void {
        var object:Object = {};
        var property:Property = new Property("x", Boolean);
        var editor:Group = createPropertyEditor(object, property);
        assertThat(editor, notNullValue());
        assertThat(editor.getElementAt(0), isA(CheckBox));
    }

    [Test]
    public function sliderForNumberWithMaxValue():void {
        var object:Object = {};
        var property:Property = new Property("n", Number);
        property.maxValue = 100;
        var editor:Group = createPropertyEditor(object, property);
        assertThat(editor, notNullValue());
        assertThat(editor.getElementAt(1), isA(HSlider));
    }

    [Test]
    public function sliderAndSpinnerForNumberWithRangeGreater100():void {
        var object:Object = {};
        var property:Property = new Property("n", Number);
        property.minValue = 0;
        property.maxValue = 101;
        var editor:Group = createPropertyEditor(object, property);
        assertThat(editor, notNullValue());
        assertThat(editor.getElementAt(1), isA(HSlider));
        assertThat(editor.getElementAt(2), isA(Spinner));
    }

    [Test]
    public function noSliderForNumberWithoutMaxValue():void {
        var object:Object = {};
        var property:Property = new Property("x", Number);
        var editor:Group = createPropertyEditor(object, property);
        assertThat(editor, notNullValue());
        assertThat(editor.getElementAt(2), isA(Spinner));
    }

    [Test]
    public function colorPickerForUint():void {
        var object:Object = {};
        var property:Property = new Property("x", uint);
        var editor:Group = createPropertyEditor(object, property);
        assertThat(editor, notNullValue());
        assertThat(editor.getElementAt(1), isA(ColorPicker));
    }

    [Test]
    public function gradientEditorForGradientArrays():void {
        var object:Object = {};
        var property:Property = new Property("x", Array);
        property.arrayType = GradientEntry;
        var editor:Group = createPropertyEditor(object, property);
        assertThat(editor, notNullValue());
        // TODO: Improve this test.
    }
}
}
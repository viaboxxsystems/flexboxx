package de.viaboxx.flexboxx {
import de.viaboxx.flexboxx.editors.PropertyEditor;

import mx.controls.ColorPicker;
import mx.graphics.GradientEntry;

import org.flexunit.assertThat;
import org.hamcrest.core.isA;
import org.hamcrest.object.notNullValue;

import spark.components.CheckBox;
import spark.components.Group;
import spark.components.HSlider;
import spark.components.Label;
import spark.components.Spinner;

public class CreatePropertyEditorTest {
    public function CreatePropertyEditorTest() {
        //empty constructor
    }

    [Test]
    public function checkboxForBoolean():void {
        var property:Property = new Property("x", Boolean);
        assertThat(contentOfEditor(property).getElementAt(0), isA(CheckBox));
    }

    private function contentOfEditor(property:Property):Group {
        var editor:PropertyEditor = createPropertyEditor({}, property);
        return editor.getElementAt(0) as Group;
    }

    [Test]
    public function sliderAndLabelForNumberWithMaxValue():void {
        var property:Property = new Property("n", Number);
        property.maxValue = 1;
        assertThat(contentOfEditor(property).getElementAt(0), isA(HSlider));
        assertThat(contentOfEditor(property).getElementAt(1), isA(Label));
    }

    [Test]
    public function sliderAndSpinnerForNumberWithRangeGreater1():void {
        var property:Property = new Property("n", Number);
        property.maxValue = 2;
        assertThat(contentOfEditor(property).getElementAt(0), isA(HSlider));
        assertThat(contentOfEditor(property).getElementAt(1), isA(Spinner));
    }

    [Test]
    public function noSliderForNumberWithoutMaxValue():void {
        var property:Property = new Property("x", Number);
        assertThat(contentOfEditor(property).getElementAt(0), isA(Spinner));
    }

    [Test]
    public function colorPickerForUint():void {
        var property:Property = new Property("x", uint);
        assertThat(contentOfEditor(property).getElementAt(0), isA(ColorPicker));
    }

    [Test]
    public function gradientEditorForGradientArrays():void {
        var object:Object = {};
        var property:Property = new Property("x", Array);
        property.arrayType = GradientEntry;
        var editor:PropertyEditor = createPropertyEditor(object, property);
        assertThat(editor, notNullValue());
        // TODO: Improve this test.
    }
}
}
package de.viaboxx.flexboxx.editors {
import de.viaboxx.flexboxx.Property;
import de.viaboxx.flexboxx.editors.PropertyEditor;

import mx.binding.utils.BindingUtils;
import mx.controls.ColorPicker;

import spark.components.Label;

public class ColorEditor extends PropertyEditor {
    public function ColorEditor(element:*, property:Property) {
        var label:Label = new Label();
        label.text = property.name;
        var colorPicker:ColorPicker = new ColorPicker();
        colorPicker.selectedColor = element[property.name];
        BindingUtils.bindProperty(element, property.name, colorPicker, "selectedColor");
        addElement(label);
        addElement(colorPicker);
    }
}
}
package de.viaboxx.flexboxx.editors {
import de.viaboxx.flexboxx.Property;

import mx.controls.ColorPicker;

public class ColorEditor extends LabeledEditor {
    public function ColorEditor(element:*, property:Property, changeHandler:Function = null) {
        super(property.displayName);

        rightAlignContent();

        var colorPicker:ColorPicker = new ColorPicker();
        bindProperty(element, property.name, colorPicker, "selectedColor", changeHandler);

        content.addElement(colorPicker);
    }
}
}
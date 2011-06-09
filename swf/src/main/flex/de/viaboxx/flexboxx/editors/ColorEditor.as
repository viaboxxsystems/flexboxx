package de.viaboxx.flexboxx.editors {
import de.viaboxx.flexboxx.Property;

import mx.binding.utils.BindingUtils;
import mx.controls.ColorPicker;

public class ColorEditor extends LabeledEditor {
    public function ColorEditor(element:*, property:Property) {
        super(property.displayName);



        rightAlignContent();
        
        var colorPicker:ColorPicker = new ColorPicker();
        colorPicker.selectedColor = element[property.name];
        BindingUtils.bindProperty(element, property.name, colorPicker, "selectedColor");

        content.addElement(colorPicker);
    }

}
}
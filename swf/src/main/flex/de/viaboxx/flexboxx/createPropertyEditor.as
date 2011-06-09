package de.viaboxx.flexboxx {
import de.viaboxx.flexboxx.editors.CheckBoxEditor;
import de.viaboxx.flexboxx.editors.ColorEditor;
import de.viaboxx.flexboxx.editors.GradientEditor;
import de.viaboxx.flexboxx.editors.PropertyEditor;
import de.viaboxx.flexboxx.editors.SliderEditor;
import de.viaboxx.flexboxx.editors.SpinnerEditor;

import mx.graphics.GradientEntry;

public function createPropertyEditor(element:*, property:Property):PropertyEditor {
    switch (property.dataType) {
        case Boolean:
            return new CheckBoxEditor(element, property);
        case int:
        //fall-through
        case Number:
            return (property.maxValue) ? new SliderEditor(element, property) : new SpinnerEditor(element, property);
        case uint:
            return new ColorEditor(element, property);
        case Array:
            if (property.arrayType == GradientEntry) {
                return new GradientEditor(element, property);
            }
        default:
            return null;
    }
}
}
package de.viaboxx.flexboxx.editors {
import de.viaboxx.flexboxx.Property;
import de.viaboxx.flexboxx.editors.PropertyEditor;

import mx.binding.utils.BindingUtils;

import spark.components.CheckBox;

public class CheckBoxEditor extends PropertyEditor {
    public function CheckBoxEditor(element:*, property:Property) {
        var checkbox:CheckBox = new CheckBox();
        checkbox.label = property.name;
        checkbox.selected = element[property.name];
        BindingUtils.bindProperty(element, property.name, checkbox, "selected");
        addElement(checkbox);
    }
}
}
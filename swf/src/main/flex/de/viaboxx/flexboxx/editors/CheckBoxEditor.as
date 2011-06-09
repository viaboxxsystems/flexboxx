package de.viaboxx.flexboxx.editors {
import de.viaboxx.flexboxx.Property;

import mx.binding.utils.BindingUtils;

import spark.components.CheckBox;
import spark.layouts.HorizontalLayout;

public class CheckBoxEditor extends PropertyEditor {
    public function CheckBoxEditor(element:*, property:Property) {
        content.layout = new HorizontalLayout();
        var checkbox:CheckBox = new CheckBox();
        checkbox.label = property.name;
        checkbox.selected = element[property.name];
        BindingUtils.bindProperty(element, property.name, checkbox, "selected");
        content.addElement(checkbox);
    }
}
}
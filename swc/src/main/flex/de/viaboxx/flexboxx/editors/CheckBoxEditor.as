package de.viaboxx.flexboxx.editors {
import de.viaboxx.flexboxx.Property;

import mx.binding.utils.BindingUtils;

import spark.components.CheckBox;
import spark.layouts.HorizontalLayout;

public class CheckBoxEditor extends PropertyEditor {
    public function CheckBoxEditor(element:*, property:Property, changeHandler:Function = null) {
        content.layout = new HorizontalLayout();
        var checkbox:CheckBox = new CheckBox();
        checkbox.label = property.displayName;
        bindProperty(element, property.name, checkbox, "selected", changeHandler);
        content.addElement(checkbox);
    }
}
}
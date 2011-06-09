package de.viaboxx.flexboxx.editors {
import de.viaboxx.flexboxx.Property;
import de.viaboxx.flexboxx.editors.PropertyEditor;

import mx.binding.utils.BindingUtils;

import spark.components.Label;
import spark.components.Spinner;

public class SpinnerEditor extends PropertyEditor {
    public function SpinnerEditor(element:*, property:Property) {
        var label:Label = new Label();
        label.text = property.name;
        var spinner:Spinner = new Spinner();
        spinner.stepSize = 1;
        spinner.value = element[property.name];
        var valueLabel:Label = new Label();
        valueLabel.text = element[property.name];
        BindingUtils.bindProperty(element, property.name, spinner, "value");
        BindingUtils.bindProperty(valueLabel, "text", spinner, "value");
        addElement(label);
        addElement(valueLabel);
        addElement(spinner);
    }
}
}
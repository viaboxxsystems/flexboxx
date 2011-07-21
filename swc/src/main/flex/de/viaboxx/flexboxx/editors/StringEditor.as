package de.viaboxx.flexboxx.editors {
import de.viaboxx.flexboxx.Property;

import spark.components.TextInput;

public class StringEditor extends LabeledEditor {
    public function StringEditor(element:*, property:Property, changeHandler:Function = null) {
        super(property.displayName);
        var textInput:TextInput = new TextInput();
        bindProperty(element,property.name,textInput,"text",changeHandler);
        content.addElement(textInput);
    }

}
}
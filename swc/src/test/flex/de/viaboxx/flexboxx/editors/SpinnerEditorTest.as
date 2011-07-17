package de.viaboxx.flexboxx.editors {
import de.viaboxx.flexboxx.Property;

import org.flexunit.assumeThat;
import org.hamcrest.object.equalTo;

import spark.components.Spinner;

public class SpinnerEditorTest {
    public function SpinnerEditorTest() {
    }

    [Test]
    public function emptyMaxValueTriggersDefaultMaxValue():void {
        var property:Property = new Property("testProperty",Number);
        assumeThat(property.maxValue,equalTo(0));
        var editor:SpinnerEditor = new SpinnerEditor(this,property);
//        var createdSpinner = editor.content.
    }

}
}
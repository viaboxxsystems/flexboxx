package de.viaboxx.flexboxx.editors {
import mx.graphics.SolidColorStroke;

import spark.components.Group;
import spark.primitives.Rect;

public class PropertyEditor extends Group {

    public function PropertyEditor() {
        var rect:Rect = new Rect();
        rect.stroke = new SolidColorStroke(0x333333,1,0.3);
        rect.percentWidth = 100;
        rect.top = 0;
        addElement(rect);
    }
}
}
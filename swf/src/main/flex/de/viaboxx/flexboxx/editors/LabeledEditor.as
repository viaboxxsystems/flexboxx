package de.viaboxx.flexboxx.editors {
import spark.components.Group;
import spark.components.Label;
import spark.layouts.VerticalLayout;

public class LabeledEditor extends PropertyEditor {

    [Bindable]
    public var propertyName:String;

    private var propertyLabel:Label;
    protected var content:Group = new Group();

    public function LabeledEditor(propertyName:String) {
        super();
        percentWidth = 100;
        addPropertyLabel(propertyName);
        addElement(content);
    }

    private function addPropertyLabel(propertyName:String):void {
        this.propertyName = propertyName;
        propertyLabel = new Label();
        propertyLabel.top = 5;
        propertyLabel.left = 0;
        propertyLabel.text = propertyName;
        content.top = propertyLabel.top + 12;//propertyLabel.height/2;
        content.left = propertyLabel.left + 5;//propertyLabel.height/2;
        content.percentWidth = 100;
        addElement(propertyLabel);
    }


    protected function rightAlignContent():void {
        var layout:VerticalLayout = new VerticalLayout();

        layout.horizontalAlign = "right";
        content.layout = layout;
    }
}
}
// Copyright (c) 2015 Ultimaker B.V.
// Cura is released under the terms of the AGPLv3 or higher.

import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1

import UM 1.1 as UM

Column{
    id: base;
    UM.I18nCatalog { id: catalog; name:"cura"}
    property int totalHeightProfileSetup: childrenRect.height
    property Action manageProfilesAction
    spacing: 0

    Rectangle{
        id: variantItem;
        height:  UM.Theme.sizes.sidebar_setup.height
        width: base.width
        visible: UM.MachineManager.hasVariants;

        Rectangle {
            id: variantRow
            width: base.width
            height: parent.heigth

            Label{
                id: variantLabel
                text: catalog.i18nc("@label","Variant:");
                anchors.left: parent.left
                anchors.leftMargin: UM.Theme.sizes.default_margin.width;
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width/100*45
                font: UM.Theme.fonts.default;
            }

            ToolButton {
                id: variantSelection
                text: UM.MachineManager.activeMachineVariant
                width: parent.width/100*55
                height: UM.Theme.sizes.setting_control.height
                tooltip: UM.MachineManager.activeMachineInstance;
                anchors.right: parent.right
                anchors.rightMargin: UM.Theme.sizes.default_margin.width
                anchors.verticalCenter: parent.verticalCenter
                style: UM.Theme.styles.sidebar_header_button

                menu: Menu
                {
                    id: variantsSelectionMenu
                    Instantiator
                    {
                        model: UM.MachineVariantsModel { }
                        MenuItem
                        {
                            text: model.name;
                            checkable: true;
                            checked: model.active;
                            exclusiveGroup: variantSelectionMenuGroup;
                            onTriggered: UM.MachineManager.setActiveMachineVariant(model.getItem(index).name)
                        }
                    }

                    ExclusiveGroup { id: variantSelectionMenuGroup; }
                }
            }
        }
    }

    Rectangle{
        id: globalProfileRow;
        height: UM.Theme.sizes.sidebar_setup.height
        width: base.width

        Label{
            id: globalProfileLabel
            anchors.left: parent.left
            anchors.leftMargin: UM.Theme.sizes.default_margin.width;
            anchors.verticalCenter: parent.verticalCenter
            text: catalog.i18nc("@label","Global Profile:");
            width: parent.width/100*45
            font: UM.Theme.fonts.default;
        }


        ToolButton {
            id: globalProfileSelection
            text: UM.MachineManager.activeProfile
            width: parent.width/100*55
            height: UM.Theme.sizes.setting_control.height
            anchors.right: parent.right
            anchors.rightMargin: UM.Theme.sizes.default_margin.width
            anchors.verticalCenter: parent.verticalCenter
            tooltip: UM.MachineManager.activeProfile
            style: UM.Theme.styles.sidebar_header_button

            menu: Menu
            {
                id: profileSelectionMenu
                Instantiator
                {
                    model: UM.ProfilesModel { }
                    MenuItem
                    {
                        text: model.name
                        checkable: true;
                        checked: model.active;
                        exclusiveGroup: profileSelectionMenuGroup;
                        onTriggered: UM.MachineManager.setActiveProfile(model.name)
                    }
                    onObjectAdded: profileSelectionMenu.insertItem(index, object)
                    onObjectRemoved: profileSelectionMenu.removeItem(object)
                }
                ExclusiveGroup { id: profileSelectionMenuGroup; }

                MenuSeparator { }
                MenuItem {
                    action: base.manageProfilesAction;

                }
            }
//             Button {
//                 id: saveProfileButton
//                 visible: true
//                 anchors.top: parent.top
//                 x: globalProfileSelection.width + 2
//                 width: parent.width/100*25
//                 text: catalog.i18nc("@action:button", "Save");
//                 height: parent.height
//
//                 style: ButtonStyle {
//                     background: Rectangle {
//                         color: control.hovered ? UM.Theme.colors.load_save_button_hover : UM.Theme.colors.load_save_button
//                         Behavior on color { ColorAnimation { duration: 50; } }
//                         width: actualLabel.width + UM.Theme.sizes.default_margin.width
//                         Label {
//                             id: actualLabel
//                             anchors.centerIn: parent
//                             color: UM.Theme.colors.load_save_button_text
//                             font: UM.Theme.fonts.default
//                             text: control.text;
//                         }
//                     }
//                 label: Item { }
//                 }
//             }
        }
    }
    Rectangle{
        width: base.width
        height: UM.Theme.sizes.default_margin.width/2
    }
}
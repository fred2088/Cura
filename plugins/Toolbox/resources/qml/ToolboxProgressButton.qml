// Copyright (c) 2018 Ultimaker B.V.
// Toolbox is released under the terms of the LGPLv3 or higher.

import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import UM 1.1 as UM
import Cura 1.0 as Cura


Item
{
    id: base

    property var active: false
    property var complete: false

    property var readyLabel: catalog.i18nc("@action:button", "Install")
    property var activeLabel: catalog.i18nc("@action:button", "Cancel")
    property var completeLabel: catalog.i18nc("@action:button", "Installed")

    signal readyAction() // Action when button is ready and clicked (likely install)
    signal activeAction() // Action when button is active and clicked (likely cancel)
    signal completeAction() // Action when button is complete and clicked (likely go to installed)

    width: UM.Theme.getSize("toolbox_action_button").width
    height: UM.Theme.getSize("toolbox_action_button").height

    Cura.PrimaryButton
    {
        id: button
        width: UM.Theme.getSize("toolbox_action_button").width
        height: UM.Theme.getSize("toolbox_action_button").height
        fixedWidthMode: true
        text:
        {
            if (complete)
            {
                return completeLabel
            }
            else if (active)
            {
                return activeLabel
            }
            else
            {
                return readyLabel
            }
        }
        onClicked:
        {
            if (complete)
            {
                completeAction()
            }
            else if (active)
            {
                activeAction()
            }
            else
            {
                readyAction()
            }
        }
        busy: active
    }
}

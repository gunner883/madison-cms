function actionNewStandardValueKey() {
    UmbClientMgr.openModalWindow('plugins/Sitereactor/StandardValues/EditStandardValueKeys.aspx?id=' + UmbClientMgr.mainTree().getActionNode().nodeId, 'Create New Key', true, 400, 400);
}

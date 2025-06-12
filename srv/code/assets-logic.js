/**
 * 
 * @Before(event = { "CREATE","UPDATE" }, entity = "jouleSrv.Assets")
 * @param {cds.Request} request - User information, tenant-specific CDS model, headers and query parameters
*/
module.exports = async function(request) {
	// Your code here
	sap.ui.define([
		"sap/ui/core/mvc/Controller",
		"sap/m/MessageToast",
		"sap/m/MessageBox"
	  ], function(Controller, MessageToast, MessageBox) {
		return Controller.extend("my.app.controller.Assets", {
		  onInit() {
			// JSON model to track UI state
			const oVM = new sap.ui.model.json.JSONModel({
			  hasUIChanges: false
			});
			this.getView().setModel(oVM, "appView");
	  
			// Listen for technical errors
			const oMsgModel = sap.ui.getCore().getMessageManager().getMessageModel();
			this._oMsgBinding = oMsgModel.bindList("/", undefined, [], 
			  new sap.ui.model.Filter("technical", sap.ui.model.FilterOperator.EQ, true));
			this._oMsgBinding.attachChange(this._onTechnicalError, this);
			this._bErrors = false;
		  },
	  
		  _setUIChanges(bFlag = this.getView().getModel().hasPendingChanges()) {
			if (this._bErrors) { bFlag = true; }
			this.getView().getModel("appView").setProperty("/hasUIChanges", bFlag);
		  },
	  
		  onCreate() {
			const oTable   = this.byId("assetTable"),
				  oBinding = oTable.getBinding("items"),
				  oCtx     = oBinding.create({ /* initial blank values if needed */ });
			this._setUIChanges(true);
			// optional: focus new row…
		  },
	  
		  onRefresh() {
			this.byId("assetTable").getBinding("items").refresh();
		  },
	  
		  onSave() {
			this._setUIChanges(false);
			this.getView().getModel().submitBatch("assetGroup")
			  .then(() => MessageToast.show("Changes saved"))
			  .catch(err => {
				MessageBox.error(err.message);
				this._setUIChanges(true);
			  });
			this._bErrors = false;
		  },
	  
		  onResetChanges() {
			this.byId("assetTable").getBinding("items").resetChanges();
			this._bErrors = false;
			this._setUIChanges(false);
		  },
	  
		  onInputChange() {
			this._setUIChanges(true);
		  },
	  
		  onDelete(oEvt) {
			const oItem = oEvt.getSource().getParent();
			oItem.getBindingContext().delete().catch(err => {
			  MessageBox.error(err.message);
			});
		  },
	  
		  _onTechnicalError(oEvt) {
			const aMsgs = oEvt.getSource().getContexts().map(c => c.getObject());
			if (!aMsgs.length) return;
			this._bErrors = true;
			MessageBox.error(aMsgs[0].message);
			this._setUIChanges(true);
			sap.ui.getCore().getMessageManager().removeMessages(aMsgs);
		  }
		});
	  });
	  
}
/**********************************************************************
Name:  Account
 Copyright Â© 2017
======================================================
======================================================
Purpose: Trigger for Account
======================================================
======================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE                DETAIL                         FEATURES/CSR/TTP
   1.0      Mark Cook 		    28/06/2017        	
   1.1		Grant Whitfield		21/09/2017			Added Ge_GnetFolderCreation_TH 
   1.2		Grant Whitfield	    17/04/2017 			Added Ge_PopulateRecordTypeDevName_TH 
   1.3		Mark Cook 			09/08/2018 		    Added Ge_PreventInvestorRecordDeletiong_TH
***********************************************************************/
trigger Account on Account (before insert, 
							before update, 
							before delete, 
							after insert, 
							after update, 
							after delete, 
							after undelete) {

	// checking if the automation switch is on for Account trigger
    public static AutomationSwitch__c setting = AutomationSwitch__c.getInstance();

    if (Test.isRunningTest() || setting.AccountSwitch__c) {

    	GeTF_TriggerDispatcher_V dispatcher = new GeTF_TriggerDispatcher_V();

		if (Trigger.isBefore) {
			if (Trigger.isInsert) {
	    		// Prepare inserted data for Gnet Folder Creation
	     		dispatcher.addOperation(new Ge_GnetFolderCreation_TH(Trigger.new, true));
	     		// Populate the Record Type Developer Name
	     		dispatcher.addOperation(new Ge_PopulateAccountRecordTypeDevName_TH(Trigger.new, true, null));
			}
			if (Trigger.isUpdate) {
	     		// Populate the Record Type Developer Name
	     		dispatcher.addOperation(new Ge_PopulateAccountRecordTypeDevName_TH(Trigger.new, false, trigger.oldMap));
			}
		}

	    if (Trigger.isAfter) {
			if (Trigger.isInsert) {
		    	// Queue inserted record for Gnet Folder Creation
		     	dispatcher.addOperation(new Ge_GnetFolderCreation_TH(Trigger.new, false));

		     	// Clearbit Account Data Enrichment 
            	dispatcher.addOperation(new GeDQ_AccountEnrichment_TH(Trigger.new, 'Insert'));      
			}
		    if (Trigger.isUpdate) {
		    	//Update the Record type on Contacts relating to an Account
		        dispatcher.addOperation(new Ge_ContactSharing_TH(Trigger.newMap, Trigger.oldMap));

		        // Clearbit Account Data Enrichment 
            	dispatcher.addOperation(new GeDQ_AccountEnrichment_TH(Trigger.new, 'Update'));         
		    }
    	}
       

       if(Trigger.isDelete){
       		if(Trigger.isBefore){
       			//Check if the record can be deleted / merged
       			dispatcher.addOperation(new Ge_PreventInvestorRecordDelete_TH(Trigger.old));
       		}
       }


    	dispatcher.dispatch();
    }
}
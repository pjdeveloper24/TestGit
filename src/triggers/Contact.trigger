/**********************************************************************
Name:  Contact
 Copyright Â© 2017
======================================================
======================================================
Purpose: Trigger for Contact
======================================================
======================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE                DETAIL                         FEATURES/CSR/TTP
   1.0      Mark Cook 		    28/06/2017         
***********************************************************************/
trigger Contact on Contact (before insert, 
							before update, 
							before delete, 
							after insert, 
							after update, 
							after delete, 
							after undelete) {

	// checking if the automation switch is on for Account trigger
    public static AutomationSwitch__c setting = AutomationSwitch__c.getInstance();
    GeTF_TriggerDispatcher_V dispatcher = new GeTF_TriggerDispatcher_V();

    if (Test.isRunningTest() || setting.ContactSwitch__c) {
	    if (Trigger.isBefore) {
		    if (Trigger.isInsert) {
		    	//add The record Type of the Account to the Contact
		        dispatcher.addOperation(new Ge_ContactSharing_TH(Trigger.new));
		    }
	    }
	}

    dispatcher.dispatch();
}
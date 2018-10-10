/**********************************************************************
Name:  Usage_Tracker
 Copyright Â© 2017
======================================================
======================================================
Purpose: Trigger for Usage_Tracker
======================================================
======================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE                DETAIL                         FEATURES/CSR/TTP
   1.0      Mark Cook 		    24/05/2018        	
***********************************************************************/
trigger Usage_Tracker on Usage_Tracker__c ( before insert, 
											before update, 
											before delete, 
											after insert, 
											after update, 
											after delete, 
											after undelete) {

	// checking if the automation switch is on for Account trigger
    public static AutomationSwitch__c setting = AutomationSwitch__c.getInstance();

    if (Test.isRunningTest() || setting.Usage_Tracking__c) {
    	GeTF_TriggerDispatcher_V dispatcher = new GeTF_TriggerDispatcher_V();

	    if (Trigger.isAfter) {
			if (Trigger.isInsert) {
		    	// Check for matching records
		     	dispatcher.addOperation(new Re_UsageTrackingMatching_TH(Trigger.new));
			}
    		if(Trigger.isUpdate){
                // Check for matching records
                dispatcher.addOperation(new Re_UsageTrackingMatching_TH(Trigger.new));
    			//act on changes to the status of a match
    			dispatcher.addOperation(new Re_UsageTrackingMatchedRecords_TH(Trigger.newMap, Trigger.oldMap));
    		}
    	}
    	if(Trigger.isBefore){

    	}
       
    	dispatcher.dispatch();
    }
}
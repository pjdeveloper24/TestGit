/**********************************************************************
Name:  Task
 Copyright Â© 2017
======================================================
======================================================
Purpose: Trigger for Task
======================================================
======================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE                DETAIL                         FEATURES/CSR/TTP
   1.0      Chuck Martin	    28/05/2018        	
***********************************************************************/
trigger Task on Task (before insert, 
							before update, 
							before delete, 
							after insert, 
							after update, 
							after delete, 
							after undelete) {

	// checking if the automation switch is on for Account trigger
    public static AutomationSwitch__c setting = AutomationSwitch__c.getInstance();

    if (Test.isRunningTest() || setting.TaskSwitch__c) {
    	GeTF_TriggerDispatcher_V dispatcher = new GeTF_TriggerDispatcher_V();
    	if (Trigger.isAfter) {
			//if (Trigger.isInsert) {
			dispatcher.addOperation(new ReEn_PrepareTaskForBot_TH(Trigger.new));
			//}
		}
		
		dispatcher.dispatch();
    }


}
/**********************************************************************
Name:  GeEN_Project_T
 Copyright Â© 2017
======================================================
======================================================
Purpose: Trigger for GeEN_Project__c
======================================================
======================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE                DETAIL                         FEATURES/CSR/TTP
   1.0      Mark Cook 		    09/08/2017         
***********************************************************************/
trigger GeEN_Project_T on GeEN_Project__c ( before insert, 
											before update, 
											before delete, 
											after insert, 
											after update, 
											after delete, 
											after undelete) {

    GeTF_TriggerDispatcher_V dispatcher = new GeTF_TriggerDispatcher_V();
    if(Trigger.isBefore){
    	if(Trigger.isInsert){
	    	//Enriches the expert network Projecty
	        dispatcher.addOperation(new GeEN_EnrichExpertNetworkProject_TH(Trigger.new));    		
    	}

    }
    if (Trigger.isAfter) {
	    if (Trigger.isInsert) {
	    	//Determines the approrpaite Expert networks that should be added to a new Project
	        dispatcher.addOperation(new GeEN_DetermineExpertNetworkForProject_TH(Trigger.new));
	    }
    }

    dispatcher.dispatch();
}
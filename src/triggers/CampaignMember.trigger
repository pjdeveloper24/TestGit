/**********************************************************************
Name:  CampaignMember
 Copyright Â© 2017
======================================================
======================================================
Purpose: Trigger for CampaignMember
======================================================
======================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE                DETAIL                         FEATURES/CSR/TTP
   1.0      Mark Cook 		    28/06/2017         
***********************************************************************/
trigger CampaignMember on CampaignMember (before insert, 
										before update, 
										before delete, 
										after insert, 
										after update, 
										after delete, 
										after undelete) {

    GeTF_TriggerDispatcher_V dispatcher = new GeTF_TriggerDispatcher_V();
    if (Trigger.isBefore) {
	    if (Trigger.isInsert ) {
	    	//Update the Record Contact based on his relationship to the Campaign
	        dispatcher.addOperation(new GeCl_ContactShareWithExtMarketing_TH(Trigger.new));
	    } else if(Trigger.isDelete){
	    	//Update the Record Contact based on his relationship to the Campaign
	        dispatcher.addOperation(new GeCl_ContactShareWithExtMarketing_TH(Trigger.old));
	    }

    }

    dispatcher.dispatch();
}
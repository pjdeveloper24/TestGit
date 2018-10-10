/**
 Author: Bhushan Sukumar (bhushan.k.sukumar@accenture.com)
 Date: 18 Jul 2016

 Descsription: Trigger for Campaign Object. There should only be one trigger per object
 */

trigger CampaignTrigger on Campaign (before insert,
        before update,
        before delete,
        after insert,
        after update,
        after delete,
        after undelete) {
    //Checking if the automation switch is ON for Case trigger
    public static AutomationSwitch__c setting = AutomationSwitch__c.getInstance();
    //Using new trigger framework
    GeTF_TriggerDispatcher_V dispatcher = new GeTF_TriggerDispatcher_V();
    if (Test.isRunningTest() || setting.CampaginSwitch__c){
        //TriggerDispatcher.Run(new CampaignTriggerHandler());
        




        if (Trigger.isBefore) {
            if (Trigger.isUpdate) {
                //Update related records to the Campaign 
                dispatcher.addOperation(new GeCl_ContactShareWithExtMarketing_TH( Trigger.oldMap, Trigger.newMap));
            }
        }
    }   

    dispatcher.dispatch(); 
}
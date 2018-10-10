/**
 Author: Bhushan Sukumar (bhushan.k.sukumar@accenture.com)
 Date: 01 Aug 2016
 
 Descsription: Trigger for opportunity object. There should only be one trigger per object
 */

trigger OpportunityTrigger on Opportunity (before insert,
        before update,
        before delete,
        after insert,
        after update,
        after delete,
        after undelete) {

    //Checking if the automation switch is ON for Opportunity trigger
    public static AutomationSwitch__c setting = AutomationSwitch__c.getInstance();

    if (Test.isRunningTest() || setting.OpportunitySwitch__c) {
        TriggerDispatcher.Run(new OpportunityTriggerHandler());
    }
}
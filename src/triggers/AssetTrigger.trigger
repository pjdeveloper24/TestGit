/**
 Author: Bhushan Sukumar (bhushan.k.sukumar@accenture.com)
 Date: 24 Jul 2016
 
 Descsription: Apex trigger for Asset object. There should only be one trigger per object
 */

trigger AssetTrigger on Asset (before insert,
        before update,
        before delete,
        after insert,
        after update,
        after delete,
        after undelete) {

    //Checking if the automation switch is ON for Asset trigger
    public static AutomationSwitch__c setting = AutomationSwitch__c.getInstance();

    if (Test.isRunningTest() || setting.AssetSwitch__c) {
        TriggerDispatcher.Run(new AssetTriggerHandler());
    } 
}
/**
 Author: Bhushan Sukumar (bhushan.k.sukumar@accenture.com)
 Date: 21 Sep 2016
 
 Descsription: Trigger for Transaction object. There should be only one trigger per object
 */

trigger TransactionTrigger on Transaction__c (
        before insert,
        before update,
        before delete,
        after insert,
        after update,
        after delete,
        after undelete) {

    //Checking if the automation switch is ON for Transaction trigger
    public static AutomationSwitch__c setting = AutomationSwitch__c.getInstance();

    if (Test.isRunningTest() || setting.TransactionSwitch__c) {
        TriggerDispatcher.Run(new TransactionTriggerHandler());
    }
}
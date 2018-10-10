/**
 Author: Bhushan Sukumar (bhushan.k.sukumar@accenture.com)
 Date: 21 Sep 2016
 
 Descsription: Trigger for Case object. There should only one trigger per object
 */

trigger CaseTrigger on Case (before insert,
        before update,
        before delete,
        after insert,
        after update,
        after delete,
        after undelete) {

    //Checking if the automation switch is ON for Asset trigger
    public static AutomationSwitch__c setting = AutomationSwitch__c.getInstance();

    if (Test.isRunningTest() || setting.CaseSwitch__c) {
        TriggerDispatcher.Run(new CaseTriggerHandler());

        GeTF_TriggerDispatcher_V dispatcher = new GeTF_TriggerDispatcher_V();

        if (Trigger.isAfter) {
            if (Trigger.isInsert) {
                // Creates the tasks based from the CoCa_Tasks__c records
                dispatcher.addOperation(new GeCa_TaskCreation_TH(Trigger.new));
                // Rollup the required Control team Case fields to Account object
                dispatcher.addOperation(new Co_RollupCaseFieldsToAccount_TH(Trigger.new));
            }

            if (Trigger.isUpdate) {
                // Rollup the required Control team Case fields to Account object
                dispatcher.addOperation(new Co_RollupCaseFieldsToAccount_TH(Trigger.new));       
            }

        }
       
        dispatcher.dispatch();
    }

}
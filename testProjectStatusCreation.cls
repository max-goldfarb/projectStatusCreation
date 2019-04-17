@isTest
private class testProjectStatusCreation {
	public static testMethod void testSchedule() {
        Test.StartTest();
        
        pse__Proj__c proj = new pse__Proj__c(Name='Test Project',Project_Status_Requirement__c = True, pse__Project_Type__c = 'Customer Project', pse__Stage__c = 'In Progress');
        insert proj;
        
        ProjectStatusCreation scheduledCreation = new ProjectStatusCreation();
        //Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
        String sch = '00 00 00 ? * * *';
        String jobID = System.schedule('Projet Status Creation', sch, scheduledCreation);
        
        Test.StopTest();
    }
}
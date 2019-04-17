//ProjectStatusCreation scheduledCreation = new ProjectStatusCreation();
//Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
//String sch = '00 00 00 ? * 1 *'; (schedules the job every Sunday at 12am)
//String jobID = System.schedule('Projet Status Creation', sch, scheduledCreation);

global class ProjectStatusCreation implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<pse__Proj__c> projs = [SELECT Id, Architect__c, Delivery_Manager__c, pse__Project_Manager__c, Lead_Engineer__c FROM pse__Proj__c 
                                    WHERE Project_Status_Requirement__c = True
                                    AND pse__Project_Type__c = 'Customer Project'
                                    AND pse__Stage__c = 'In Progress'];
        for (pse__Proj__c proj : projs) {
            Project_Status__c status = new Project_Status__c(Project__c	= proj.Id,
                                                             Project_Status__c = '---', 
                                                             Financials_Status__c = '---', 
                                                             Schedule_Status__c = '---',
                                                             Scope_Status__c = '---',
                                                             Resourcing_Status__c = '---',
                                                             Client_Satisfaction__c = '---',
                                                             Client_Status_Report__c = '---',
                                                             Budget_completion__c = 0,
                                                             Project_completion__c = 0,
                                                             Week_End_Date__c = system.today() + 3, //+3 if scheduling job on Sunday (due date = Wednesday)
                                                             Next_Project_Status_Due_Date__c = system.today() + 10,
                                                             Architect__c = proj.Architect__c,
                                                             Delivery_Manager__c = proj.Delivery_Manager__c,
                                                             Project_Manager_Contact__c	= proj.pse__Project_Manager__c,
                                                             Lead_Engineer__c = proj.Lead_Engineer__c
                                                            );
            system.debug(status);
            insert status;
        }
    }
}
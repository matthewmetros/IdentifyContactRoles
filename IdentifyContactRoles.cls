public with sharing class IdentifyContactRoles 
{
    public static void handleTrigger(Map<Id, Opportunity> newOppsMap)
    {

        // Query for each Opportunity and their contact roles
        List<Opportunity> Opportunities_With_ContactRoles = [SELECT id, Initial_Contact_Assigned__c,Champion_Assigned__c, Decision_Maker_Assigned__c,Contract_Signer_Assigned__c, (SELECT Role FROM OpportunityContactRoles) FROM Opportunity WHERE id in :newOppsMap.keySet() ]; 
        
        validateRolesExist(newOppsMap, Opportunities_With_ContactRoles);   
    }




    public static void validateRolesExist(Map<Id, Opportunity> newOpps, List<Opportunity> Opportunities )
    {
        for(Opportunity opp: Opportunities)
        {
            Boolean initialContactAssigned      = false;
            Boolean championContactAssigned    = false;
            Boolean DMAssigned                  = false;
            Boolean contractSignerAssigned      = false;

                // Go through each opportunity Contact role associated with this Opportunity
                for(OpportunityContactRole oppCon: opp.OpportunityContactRoles)
                {   

                    if(oppCon.Role == 'Initial Contact')
                    {
                        initialContactAssigned = true;
                    }
                    else if(oppCon.Role == 'Champion')
                    {
                        championContactAssigned = true;
                    }
                    else if(oppCon.Role == 'Decision Maker')
                    {
                        DMAssigned = true;
                    }
                    else if(oppCon.Role == 'Contract Signer')
                    {
                        contractSignerAssigned = true;
                    }
                }

                newOpps.get(opp.Id).Initial_Contact_Assigned__c = initialContactAssigned;
                newOpps.get(opp.Id).Champion_Assigned__c        = championContactAssigned;
                newOpps.get(opp.Id).Decision_Maker_Assigned__c  = DMAssigned;
                newOpps.get(opp.Id).Contract_Signer_Assigned__c = contractSignerAssigned;


 
        }
    }

}

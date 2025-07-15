public with sharing class UserHandler {

    public static void addAdminsToPublicGroup(List<User> userList) {
        List<GroupMember> groupMembersToInsert = new List<GroupMember>();

        Id sysAdminProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;
        Group adminGroup = [SELECT Id FROM Group WHERE Name = 'Admins' LIMIT 1];

        for (User usr : userList) {
            if (usr.ProfileId == sysAdminProfileId && usr.IsActive) {
                groupMembersToInsert.add(new GroupMember(
                    GroupId = adminGroup.Id,
                    UserOrGroupId = usr.Id
                ));
            }
        }

        if (!groupMembersToInsert.isEmpty()) {
            insert groupMembersToInsert;
        }
    }
}
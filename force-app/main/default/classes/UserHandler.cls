public with sharing class UserHandler {

    public static void addNewAdminToPublicGroup( List<User> userList ){
        List<GroupMember> groupAndMemberToAdd = new List<GroupMember>();
        Group groupId = [ SELECT Id FROM Group WHERE Name = 'Admins' LIMIT 1];

        for( User us : userList ){
            if( us.Profile.Name == 'System Administrator' && us.IsActive == true ){
                groupAndMemberToAdd.add( new GroupMember( GroupId = groupId.Id, UserOrGroupId = us.Id ) );
            }
        }

        if( groupAndMemberToAdd != null ){
            insert groupAndMemberToAdd;
        }

    }

}
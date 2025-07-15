public with sharing class FutureChatterMethod {

    @future (Callout = false)
    public static void createPost( Id groupId, DateTime timeStamp, Integer recordsCount ){

        String postMessage = 'Records Cleaned : ' + recordsCount + '\nTimeStamp : ' + timeStamp.format('yyyy:mm:dd HH:MM:SS');

        FeedItem feed = new FeedItem();
        feed.body = postMessage;
        feed.ParentId = groupId;

        try{
            insert feed;
        }
        catch(Exception e){
            System.debug( e.getMessage() );
        }

    }

}
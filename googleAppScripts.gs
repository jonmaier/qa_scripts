/****
*  Maniupulating google Contacts for testing.
*  
*  https://developers.google.com/apps-script/overview
* 
*  Google Contacts app lets you import via CSV, which is great for adding thousands of contacts for testing, 
*   but they cap you to editing/moving/deleting 250 at a time via the GUI. These functions will delete all contacts 
*   or move `Imported` contacts to the system `My Contacts` group. Once contacts are in that group, they can by sync'd 
*   to mobile devices
****/

function Contacts_DeleteAllContacts() {
  var a = new Date();

  var contacts = ContactsApp.getContacts();
  var arrayLength = contacts.length;
  for (var i = 0; i < arrayLength; i++) {
    var x = new Date();
    
    contacts[i].deleteContact();
    //# if ( i > 50 ) {
    //   throw 'jump out after 50 deletes';
    // }
    
    var z = new Date();
    var delta1 = z - x
    Logger.log('It took %s ms to delete contact %s', delta1, i );

  } 
  
  
  var b = new Date();
  var delta = b - a
  Logger.log('It took %s ms.', delta1 );

}

function Contacts_GetContactGroups() {
 var groups  = ContactsApp.getContactGroups();
 for (var i = 0; i < groups.length; i++) {
   Logger.log(groups[i].getName());
 }
}


function Contacts_MarkAllContactsMyContacts() {
  var a = new Date();
  
  var importGroup = ContactsApp.getContactGroup('Imported');
  var importContacts = importGroup.getContacts();
  var arrayLength = importContacts.length;
  var myContactsGroup = ContactsApp.getContactGroup('System Group: My Contacts')
  
  for (var i = 0; i < arrayLength; i++) {
    var x = new Date();
    
    importContacts[i].addToGroup(myContactsGroup)
    importContacts[i].removeFromGroup(importGroup)
    //# if ( i > 50 ) {
    //   throw 'jump out after 50 deletes';
    // }
    
    var z = new Date();
    var delta1 = z - x
    Logger.log('It took %s ms to move contact %s', delta1, i );

  } 
  
  
  var b = new Date();
  var delta = b - a
  Logger.log('It took %s ms.', delta1 );  
}

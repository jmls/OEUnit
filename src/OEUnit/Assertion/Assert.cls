/*------------------------------------------------------------------------------
  File        :   Assert.cls
  Package     :   OEUnit.Assertion
  Description :   A set of assertion methods for use in test methods. If an 
                  assertion fails, an AssertionFailedError is thrown. Messages 
                  are only recorded when an assertion fails.
  Author      :   Cameron Wills
------------------------------------------------------------------------------*/

ROUTINE-LEVEL ON ERROR UNDO, THROW.

USING OEUnit.Assertion.AssertionFailedError.

CLASS OEUnit.Assertion.Assert: 

  /*----------------------------------------------------------------------------
    Assertion methods for standard ABL data-types
  ----------------------------------------------------------------------------*/
  {OEUnit/Assertion/AssertType.i &DataType="CHARACTER" }    
  {OEUnit/Assertion/AssertType.i &DataType="COM-HANDLE" }               
  {OEUnit/Assertion/AssertType.i &DataType="DATE" }                     
  {OEUnit/Assertion/AssertType.i &DataType="DATETIME" }                 
  {OEUnit/Assertion/AssertType.i &DataType="DATETIME-TZ" }              
  {OEUnit/Assertion/AssertType.i &DataType="DECIMAL" }      
  {OEUnit/Assertion/AssertType.i &DataType="HANDLE" }
  {OEUnit/Assertion/AssertType.i &DataType="INT64" }        
  {OEUnit/Assertion/AssertType.i &DataType="INTEGER" }      
  {OEUnit/Assertion/AssertType.i &DataType="LOGICAL" }      
  {OEUnit/Assertion/AssertType.i &DataType="LONGCHAR" }
  {OEUnit/Assertion/AssertType.i &DataType="MEMPTR" }       
  {OEUnit/Assertion/AssertType.i &DataType="RAW" }          
  {OEUnit/Assertion/AssertType.i &DataType="RECID" }        
  {OEUnit/Assertion/AssertType.i &DataType="ROWID" }     
 
 /*----------------------------------------------------------------------------
    Asserts that an error was encountered in the last statement with a no-error 
    If not then throws an AssertionFailedError.
  ----------------------------------------------------------------------------*/
	method static void didError(  ):
	  didError("").
	end method.

 /*----------------------------------------------------------------------------
    Asserts that an error was encountered in the last statement with a no-error 
    If not then throws an AssertionFailedError.
  ----------------------------------------------------------------------------*/
  method static void didError(failMessage as char):
    isTrue(error-status:num-messages ne 0,if failMessage eq ? or failMessage eq ""
                                             then error-status:get-message(1)
                                             else failMessage).
    return.
  end method.

/*----------------------------------------------------------------------------
    Asserts that no error was encountered in the last statement with a no-error 
    If not then throws an AssertionFailedError.
  ----------------------------------------------------------------------------*/
  method static void didNotError():
    didNotError("").
  end method.
 
 /*----------------------------------------------------------------------------
    Asserts that no error was encountered in the last statement with a no-error 
    If not then throws an AssertionFailedError.
  ----------------------------------------------------------------------------*/
  method static void didNotError(failMessage as char):
    isTrue(error-status:num-messages eq 0,if failMessage eq ? or failMessage eq ""
                                             then error-status:get-message(1)
                                             else failMessage).
    return.
  end method.

  /*----------------------------------------------------------------------------
    Asserts that condition is true. If not then throws an AssertionFailedError.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID IsTrue(INPUT condition AS LOGICAL):
    HandleAssert(condition, STRING(TRUE), STRING(condition), TRUE).
  END METHOD.

  /*----------------------------------------------------------------------------
    Asserts that condition is true. If not then throws an AssertionFailedError 
    with the given failMessage.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID IsTrue(INPUT condition AS LOGICAL, INPUT failMessage AS CHARACTER):
    HandleAssert(condition, STRING(TRUE), STRING(condition), TRUE, failMessage).
  END METHOD.

  /*----------------------------------------------------------------------------
    Asserts that condition is false. If not then throws an AssertionFailedError.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID IsFalse(INPUT condition AS LOGICAL):
    HandleAssert(NOT(condition), STRING(FALSE), STRING(condition), TRUE).
  END METHOD.

  /*----------------------------------------------------------------------------
    Asserts that condition is false. If not then throws an AssertionFailedError 
    with the given failMessage.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID IsFalse(INPUT condition AS LOGICAL, INPUT failMessage AS CHARACTER):
    HandleAssert(NOT(condition), STRING(FALSE), STRING(condition), TRUE, failMessage).
  END METHOD.

  /*----------------------------------------------------------------------------
    Fails the test, throwing an AssertionFailedError.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID Fail():
    Fail(?).
  END METHOD.  

  /*----------------------------------------------------------------------------
    Fails the test, throwing an AssertionFailedError with the given failMessage.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID Fail(INPUT failMessage AS CHARACTER):
    IF failMessage = ? THEN
      failMessage = "Fail() method of Assert class was called".
    HandleAssert(FALSE, failMessage). 
  END METHOD.  
  
  /*----------------------------------------------------------------------------
    Asserts that objects actual and expected are equal. Not necessarily the same.
    If not, then throws an AssertionFailedError.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID AreEqual
    (INPUT actual AS Progress.Lang.Object, INPUT expected AS Progress.Lang.Object):
    
    HandleAssert(INPUT expected:Equals(actual),  
      STRING(expected),
      STRING(actual), TRUE).

  END METHOD. 
  
  /*----------------------------------------------------------------------------
    Asserts that objects actual and expected are equal. Not necessarily the same.
    If not, then throws an AssertionFailedError with the given failMessage.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID AreEqual
    (INPUT actual AS Progress.Lang.Object, INPUT expected AS Progress.Lang.Object,
     INPUT failMessage AS CHARACTER):
    
    HandleAssert(INPUT expected:Equals(actual),  
      STRING(expected),
      STRING(actual), TRUE, failMessage).

  END METHOD. 
  
  /*----------------------------------------------------------------------------
    Asserts that objects actual and notExpected are not equal. If equal, then 
    throws an AssertionFailedError.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID AreNotEqual
    (INPUT actual AS Progress.Lang.Object, INPUT notExpected AS Progress.Lang.Object):
    
    HandleAssert(INPUT NOT(notExpected:Equals(actual)),  
      STRING(notExpected),
      STRING(actual), FALSE).

  END METHOD. 
  
  /*----------------------------------------------------------------------------
    Asserts that objects actual and notExpected are not equal. If equal, then 
    throws an AssertionFailedError with the given failMessage.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID AreNotEqual
    (INPUT actual AS Progress.Lang.Object, INPUT notExpected AS Progress.Lang.Object,
     INPUT failMessage AS CHARACTER):
    
    HandleAssert(INPUT NOT(notExpected:Equals(actual)),  
      STRING(notExpected),
      STRING(actual), FALSE, failMessage).

  END METHOD. 
  
  /*----------------------------------------------------------------------------
    Asserts that objects actual and expected are the same object. If not, then 
    throws an AssertionFailedError.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID AreSame
    (INPUT actual AS Progress.Lang.Object, INPUT expected AS Progress.Lang.Object):
    
    HandleAssert(INPUT (expected = actual),  
      STRING(expected),
      STRING(actual), TRUE).

  END METHOD. 
  
  /*----------------------------------------------------------------------------
    Asserts that objects actual and expected are the same object. If not, then 
    throws an AssertionFailedError with the given failMessage.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID AreSame
    (INPUT actual AS Progress.Lang.Object, INPUT expected AS Progress.Lang.Object,
     INPUT failMessage AS CHARACTER):
    
    HandleAssert(INPUT (expected = actual),  
      STRING(expected),
      STRING(actual), TRUE, failMessage).

  END METHOD. 
  
  /*----------------------------------------------------------------------------
    Asserts that objects actual and notExpected are not the same object. If they
    are then throws an AssertionFailedError.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID AreNotSame
    (INPUT actual AS Progress.Lang.Object, INPUT notExpected AS Progress.Lang.Object):
    
    HandleAssert(INPUT (notExpected <> actual),  
      STRING(notExpected),
      STRING(actual), FALSE).

  END METHOD. 
  
  /*----------------------------------------------------------------------------
    Asserts that objects actual and notExpected are not the same object. If they
    are then throws an AssertionFailedError with the given failMessage.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID AreNotSame
    (INPUT actual AS Progress.Lang.Object, INPUT notExpected AS Progress.Lang.Object,
     INPUT failMessage AS CHARACTER):
    
    HandleAssert(INPUT (notExpected <> actual),  
      STRING(notExpected),
      STRING(actual), FALSE, failMessage).

  END METHOD. 
  
  /*----------------------------------------------------------------------------
    Asserts that obj is null. If not then then throws an AssertionFailedError.
  ----------------------------------------------------------------------------*/      
  METHOD STATIC VOID IsNull(INPUT obj AS Progress.Lang.Object):
    HandleAssert(NOT(VALID-OBJECT(obj)), "?",  STRING(obj), TRUE).
  END METHOD.
  
  /*----------------------------------------------------------------------------
    Asserts that obj is null. If not then then throws an AssertionFailedError 
    with the given failMessage.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID IsNull(INPUT obj AS Progress.Lang.Object, INPUT failMessage AS CHARACTER):
    HandleAssert(NOT(VALID-OBJECT(obj)), "?",  STRING(obj), TRUE, failMessage).
  END METHOD.

  /*----------------------------------------------------------------------------
    Asserts that obj is not null. If null then throws an AssertionFailedError.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID IsNotNull(INPUT obj AS Progress.Lang.Object):
    HandleAssert(VALID-OBJECT(obj), "object",  STRING(obj), TRUE).
  END METHOD.

  /*----------------------------------------------------------------------------
    Asserts that obj is not null. If null then throws an AssertionFailedError
    with the given failMessage.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID IsNotNull(INPUT obj AS Progress.Lang.Object, INPUT failMessage AS CHARACTER):
    HandleAssert(VALID-OBJECT(obj), "object",  STRING(obj), TRUE, failMessage).
  END METHOD.

 /*----------------------------------------------------------------------------
    Asserts that obj is valid object. If not then then throws an AssertionFailedError.
  ----------------------------------------------------------------------------*/      
  METHOD STATIC VOID IsValidObject(INPUT obj AS Progress.Lang.Object):
    IsValidObject(obj,"").
  END METHOD.
  
  /*----------------------------------------------------------------------------
    Asserts that obj is a valid object. If not then then throws an AssertionFailedError 
    with the given failMessage.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID IsValidObject(INPUT obj AS Progress.Lang.Object, INPUT failMessage AS CHARACTER):
    HandleAssert(VALID-OBJECT(obj), "?",  STRING(obj), TRUE, failMessage).
  END METHOD.

  /*----------------------------------------------------------------------------
    Asserts that obj is not a valid object. If it is valid then throws an AssertionFailedError.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID IsNotValidObject(INPUT obj AS Progress.Lang.Object):
    IsNotValidObject(obj,"").
  END METHOD.

  /*----------------------------------------------------------------------------
    Asserts that obj is not null. If it is valid then throws an AssertionFailedError.r
    with the given failMessage.
  ----------------------------------------------------------------------------*/
  METHOD STATIC VOID IsNotValidObject(INPUT obj AS Progress.Lang.Object, INPUT failMessage AS CHARACTER):
    HandleAssert(NOT(VALID-OBJECT(obj)), "object",  STRING(obj), TRUE, failMessage).
  END METHOD.

/** assert that the specified directory does not exist
   *  throws apperror if assertion failed
   *  @param: description of assertion
   *  @param: directory to validate
   */ 
  method static void DirectoryDoesNotExist(p_Dir as char):
    def var lv_file as char no-undo.
    def var lv_Type as char no-undo.
    
    assign lv_file = file-info:file-name
           file-info:file-name = p_dir
           lv_Type             = file-info:file-type
           file-info:file-name = lv_file.

    isTrue(lv_type eq ?).       
  end method.

/** assert that the specified file does not exist
   *  throws apperror if assertion failed
   *  @param: description of assertion
   *  @param: directory to validate
   */ 
  method static void FileDoesNotExist(p_File as char):
    DirectoryDoesNotExist(p_File).
  end method.

/** assert that the specified file exists
   *  throws apperror if assertion failed
   *  @param: description of assertion
   *  @param: file to validate
   */ 

  method static void FileExists(p_file as char):
    ItemExists(p_file,"F").
  end method.
  

  /** assert that the specified directory exists
   *  throws apperror if assertion failed
   *  @param: description of assertion
   *  @param: directory to validate
   */ 

  method static void DirectoryExists(p_Dir as char):
    ItemExists(p_dir,"D").
  end method.

 /** assert that the specified directory exists
   *  throws apperror if assertion failed
   *  @param: description of assertion
   *  @param: directory to validate
   */ 

  method private static void ItemExists(p_Item as char,p_Type as char):
    def var lv_file as char no-undo.
    def var lv_Type as char no-undo.
    
    assign lv_file = file-info:file-name
           file-info:file-name = p_Item
           lv_Type             = substr(file-info:file-type,1,1)
           file-info:file-name = lv_file.

    AreEqual(lv_type,p_type).    
  end method.  

  /** generate md5-digest on src and compare with md5 in file
   *  @param: description of assertion
   *  @param: value to check
   *  @param: md5 value to compare against
   */

  method static void MD5(p_src as longchar,p_target as char):
    AreEqual(string(base64-encode(md5-digest (p_src))),p_target).
  end method.

  /** generate md5-digest on src and compare with md5 in file
   *  @param: description of assertion
   *  @param: value to check
   *  @param: md5 value to compare against
   */

  method static void MD5(p_src as longchar,p_target as longchar):
    MD5(p_src,string(p_target)).
  end method.

  /** generate md5-digest on src and compare with md5 in file
   *  @param: description of assertion
   *  @param: value to check
   *  @param: file to use
   */

  method static void MD5File(p_src as longchar,p_md5File as char):
    def var lv_md5 as longchar no-undo.
    
    copy-lob from file p_md5File to lv_md5.
    
    MD5(p_src,string(lv_md5)).
  end method.

  /** assert that specified db alias is connected
   *  @param: alias to check
   */

  method static void DBConnected(p_alias as char):
    DBConnected(p_alias,"").
  end method.
  
  /** assert that specified db alias is connected
   *  @param: alias to check
   *  @param: error message to use for a fail
   */

  method static void DBConnected(p_alias as char,p_errorMessage as char):
    isTrue(connected(p_alias),p_errorMessage).
  end method.
  
    

  /*----------------------------------------------------------------------------
    If success is false, then throws an AssertionFailedError.  
  ----------------------------------------------------------------------------*/
  METHOD PRIVATE STATIC VOID HandleAssert(INPUT success AS LOGICAL):
     HandleAssert(success, ?, ?, TRUE, ?).
  END METHOD.

  /*----------------------------------------------------------------------------
    If success is false, then throws an AssertionFailedError with the given
    failMessage.
  ----------------------------------------------------------------------------*/
  METHOD STATIC PRIVATE VOID HandleAssert(INPUT success AS LOGICAL, INPUT failMessage AS CHARACTER):
     HandleAssert(success, ?, ?, TRUE, failMessage).
  END METHOD.

  /*----------------------------------------------------------------------------
    If success is false, then throws an AssertionFailedError describing the 
    expected and actual values.
  ----------------------------------------------------------------------------*/
  METHOD PRIVATE STATIC VOID HandleAssert(INPUT success AS LOGICAL, 
    INPUT expected AS CHARACTER, INPUT actual AS CHARACTER, INPUT expectedEqual AS LOGICAL):
     HandleAssert(success, expected, actual, expectedEqual, ?).
  END METHOD.

  /*----------------------------------------------------------------------------
    If success is false, then throws an AssertionFailedError. If failMessage is
    null then constructs a message from expected and actual strings. 
  ----------------------------------------------------------------------------*/  
  METHOD PRIVATE STATIC VOID HandleAssert(INPUT success AS LOGICAL, INPUT expected AS CHARACTER, 
    INPUT actual AS CHARACTER, INPUT expectedEqual AS LOGICAL, INPUT failMessage AS CHARACTER):

    IF NOT success OR success = ? THEN DO:
      IF failMessage = ? THEN DO:
        IF expectedEqual THEN
          failMessage = "Expecting: " + ReplaceNull(expected) + " but found: " + ReplaceNull(actual).
        ELSE
          failMessage = "Not expecting: " + ReplaceNull(expected) + " but found: " + ReplaceNull(actual).
      END.
      RETURN ERROR NEW AssertionFailedError(failMessage).
    END.
    
  END METHOD.
  
  /*----------------------------------------------------------------------------
    If the given string is null then returns "?". Otherwise returns the string.
  ----------------------------------------------------------------------------*/  
  METHOD PRIVATE STATIC CHARACTER ReplaceNull(INPUT str AS CHARACTER):
    IF str = ? THEN RETURN "?".
    RETURN str.
  END METHOD. 
  
END CLASS.
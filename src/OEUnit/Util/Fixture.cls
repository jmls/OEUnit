/*
Copyright (c) 2014, Julian Lyndon-Smith (julian+oeunit@dotr.com)
http://www.dotr.com
All rights reserved.

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction except as noted below, including without limitation
the rights to use,copy, modify, merge, publish, distribute,
and/or sublicense, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

 The Software and/or source code cannot be copied in whole and
 sold without meaningful modification for a profit.

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.

 Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in
 the documentation and/or other materials provided with
 the distribution.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
using Progress.Lang.*.

routine-level on error undo, throw.

class OEUnit.Util.Fixture: 
  
  /** return fixtures directory
   *  param: parent object
   *  return: fullpath of directory
   */
   
  method static char directoryPath(p_object as Progress.Lang.Object):
    return substitute("&1/fixture",replace(p_object:GetClass():Package,".","/")).
  end method.

  /** return filename from the fixtures directory
   *  param: name of file to use
   *  return: fullpath of file , error if file does not exist
   */
   
  method static char pathName(p_object as Progress.Lang.Object,p_file as char):
    return substitute("&1/fixture/&2",replace(p_object:GetClass():Package,".","/")
                                                                         ,p_file).
  end method.

  /** load a file from the fixtures directory
   *  param: name of file to load
   *  return: file contents, error if file does not exist
   */
   
  method static longchar load(p_object as Progress.Lang.Object,p_file as char):
    def var lv_data as longchar no-undo.
    
    def var lv_file as char no-undo.
    
    fix-codepage(lv_Data) = "UTF-8".
    
    /** store current value of file-info in case needed after this method */
    
    assign lv_file             = file-info:file-name 
           file-info:file-name = substitute("&1/fixture/&2",replace(p_object:GetClass():Package,".","/")
                                                           ,p_file).

    if file-info:full-pathname eq ? then undo, throw new AppError(substitute("invalid file &1",p_file),0).
        
    copy-lob from file file-info:full-pathname to lv_data.
    
    return lv_data.
    
    finally:
      assign file-info:file-name = lv_file.
    end finally.
    
  end method.  
  
  
end class.
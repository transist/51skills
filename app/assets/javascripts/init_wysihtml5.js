$(function() {
  if( $('#wysihtml5-textarea-summary-en').length > 0){
    var editor1 = new wysihtml5.Editor("wysihtml5-textarea-summary-en", { // id of textarea element
      toolbar:      "wysihtml5-toolbar-summary-en", // id of toolbar element
      parserRules:  wysihtml5ParserRules // defined in parser rules set 
    });

    var editor2 = new wysihtml5.Editor("wysihtml5-textarea-summary-zh", { // id of textarea element
      toolbar:      "wysihtml5-toolbar-summary-zh", // id of toolbar element
      parserRules:  wysihtml5ParserRules // defined in parser rules set 
    });

    var editor3 = new wysihtml5.Editor("wysihtml5-textarea-description-en", { // id of textarea element
      toolbar:      "wysihtml5-toolbar-description-en", // id of toolbar element
      parserRules:  wysihtml5ParserRules // defined in parser rules set 
    });

    var editor4 = new wysihtml5.Editor("wysihtml5-textarea-description-zh", { // id of textarea element
      toolbar:      "wysihtml5-toolbar-description-zh", // id of toolbar element
      parserRules:  wysihtml5ParserRules // defined in parser rules set 
    });
  }



  var init_wysihtml5_editor = function(){

  }
  
})


        jQuery(document).ready( function(){       
            jQuery(".bill").click( showDialog );

                //variable to reference window
                $myWindow = jQuery('#dial');

                //instantiate the dialog
                $myWindow.dialog({ height: 400,
                        width: 400,
                        modal: true,
                        draggable: true,
                        position: 'center',
                        autoOpen: false,
                        title:'Milestone bill',
                        overlay: { opacity: 0.5, background: 'black'}
                        });
                }

        );
    //function to show dialog   
    var showDialog = function() {
        //if the contents have been hidden with css, you need this
        $myWindow.show(); 
        //open the dialog
        $myWindow.dialog("open");
        }

    //function to close dialog, probably called by a button in the dialog
    var closeDialog = function() {
        $myWindow.dialog("close");
    }

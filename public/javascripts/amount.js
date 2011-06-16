      jQuery(document).ready( function(){       
            jQuery(".amo").bind('click', function (evt) {
                                 
                                            },showDialog);

                //variable to reference window
                $myWindow = jQuery('#dialog');

                //instantiate the dialog
                $myWindow.dialog({ height: 150,
                        width: 300,
                        modal: true,
                        draggable: true,
                        position: 'center',
                        autoOpen: false,
                        title:'Milestone',
                        overlay: { opacity: 0.5, background: 'black'}
                        });
                }

        );

    var showDialog = function() {
        //if the contents have been hidden with css, you need this
       milestone_id = parseInt(this.id.split('m')[1], 10)

        $("#milestone_id").val(milestone_id)
        h = $('#'+this.id).text();
        $("#milestone_amount").val(h);
        $("#milestone_form").attr("action", "/milestones/"+milestone_id);
        $myWindow.show(); 
        //open the dialog
        $myWindow.dialog("open");
        }

    var closeDialog = function() {
        $myWindow.dialog("close");
    }

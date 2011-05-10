var RedBox = {
showInline: function(id){
              this.showOverlay();
              jQuery('#'+id).clone(true).css({display:'block'}).appendTo('#RB_window');
              jQuery("#RB_window").show(0.3);
              this.setWindowPosition();
            },

addHiddenContent: function(id){
                    jQuery("#RB_window").children().remove();
                    jQuery('#'+id).children().appendTo('#RB_window');
                    jQuery("#RB_loading").hide();
                    jQuery("#RB_window").show(0.3);
                    this.setWindowPosition();
                  },

loading: function(){
           this.showOverlay();
           jQuery('#RB_loading').show();
           this.setWindowPosition();
         },

close: function(){
         jQuery("#RB_window").hide(0.3).children().remove();
         jQuery("#RB_overlay").hide(0.3);
       },

initContent: function(){
               if (jQuery('#RB_redbox').length){
                 jQuery('#RB_redbox').children().remove();
                 jQuery('#RB_redbox').html('<div id="RB_window" style="display: none;"></div><div id="RB_overlay" style="display: none;"><div id="RB_loading" style="display: none"></div></div>');
               }
               else{
                 jQuery('body').append('<div id="RB_redbox" align="center"><div id="RB_window" style="display: none;"></div><div id="RB_overlay" style="display: none;"><div id="RB_loading" style="display: none"></div></div></div>');
               }
             },

showOverlay: function(){
               this.initContent();
               jQuery("#RB_overlay").css({height:jQuery(document).height(), opacity:0.6}).show(0.3);
             },

setWindowPosition: function(){
                     jQuery("#RB_window").css({width:'auto', height:'auto'});
                     var left = (jQuery(window).width() - jQuery("#RB_window").width())/2;
                     var top = (jQuery(window).height() - jQuery("#RB_window").height())/2 - 30;
                     jQuery("#RB_window").css({left:left, top:top});
                   }
}


$(document).ready(function() {
   $('ul.sf-menu').superfish({
      delay:       10,                            // задержка в миллисекунду
      animation:   {opacity:'show',height:'show'},  // fade-in и slide-down анимация
      speed:       'fast',                          // увеличение скорости анимации
      autoArrows:  false,                           // отключает стрелку подменю
      dropShadows: false                            // отключает тень
   });
 });


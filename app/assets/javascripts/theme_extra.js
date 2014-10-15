function addLevelClass($parent, level) {
    $parent.addClass('parent-'+level);
    var $children = $parent.children('li');
    $children.addClass('child-'+level).data('level',level);
    $children.each(function() {
        var $sublist = $(this).children('ul');
        if ($sublist.length > 0) {
            $(this).addClass('has-sublist');
            addLevelClass($sublist, level+1);
        }
    });
}

addLevelClass($('.categories_c'), 1);

//----------------------------------------//
$('.categories_c > li a').click(function(e){
    if($(this).parent().hasClass('has-sublist')) {
        e.preventDefault();
    }
    if ($(this).attr('class') != 'active'){
        $(this).parent().siblings().find('ul').slideUp();
        $(this).next().slideToggle();
        if($(this).parent().hasClass("has-sublist")){

            $(this).parent().siblings().find('a').removeClass('active');
            $(this).addClass('active');
        } else {
            var curlvl = $(this).parent().data('level');
            if(curlvl){
                $('.categories_c li.child-'+curlvl+' a').removeClass('active');
            }
        }

    } else {
        console.log('tu jestem');
        $(this).next().slideToggle();
        $(this).parent().find('ul').slideUp();
        var curlvl = $(this).parent().data('level');
        console.log(curlvl);
        if(curlvl){
            $('.categories_c li.child-'+curlvl+' a').removeClass('active');
        }
    }
});
var ready = function(){
	
	$('.search_go').click(function(e){
		e.preventDefault();
		var keyword = $('#keyword').val();
		if(keyword){
			$('.search').submit();
		}
		else{
			alert('請輸入人肉的名稱');
		}
	});
};

$(document).ready(ready);
$(document).on('page:load', ready);
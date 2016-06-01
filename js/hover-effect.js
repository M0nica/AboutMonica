// $(".website-img").hover(
// 	function() {
// 	  $(this).fadeTo("slow" , 0.5)
	
// 	},
// 	function(){
// 		$(this).fadeIn("slow");
// 	}
// );

$(".website-img").hover(
	function() {
	$(this).fadeTo("slow" , 0.5, function() {
	});
});




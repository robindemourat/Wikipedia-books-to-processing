artoo.scrape('#toc li a', {
title : function($){
	var text = $(this).text();
	text = text.substring(2,text.length-1);
	return text;
},
href : function($){
	return window.location.href + $(this).attr('href');
}
}, artoo.savePrettyJson)
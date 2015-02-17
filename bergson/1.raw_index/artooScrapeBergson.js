artoo.scrape('#ws-summary a', {
	title : function($){
		return $(this).text();
	},
	link : function($){
		return "http://fr.wikisource.org"+ $(this).attr('href');
	}
}, artoo.savePrettyJson);